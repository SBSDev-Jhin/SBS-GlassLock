#!/bin/bash
# SBS GlassLock installer. Run from anywhere:  bash contrib/sbs-glasslock/install.sh
# Builds into ~/.local/sbs-glasslock, installs ~/.local/bin/sbs-glasslock and (with sudo) two PAM services.
# Use --no-fingerprint to skip the fingerprint service.
set -euo pipefail
cd "$(dirname "$0")/../.."
PREFIX="${SBS_GLASSLOCK_PREFIX:-$HOME/.local/sbs-glasslock}"
FINGER=1
[ "${1:-}" = "--no-fingerprint" ] && FINGER=0

need=""
for t in gcc make autoconf automake pkg-config; do command -v "$t" >/dev/null || need="$need $t"; done
if [ -n "$need" ]; then
  echo "Missing build tools:$need" >&2
  echo "Debian/Ubuntu: sudo apt install build-essential autoconf automake pkg-config libx11-dev libxext-dev libxcomposite-dev libxss-dev libpam0g-dev libxft-dev libxrandr-dev libxfixes-dev libxmu-dev libxmuu-dev" >&2
  exit 1
fi

./autogen.sh
./configure --prefix="$PREFIX" --with-pam-service-name=sbs-glasslock-password
make -j"$(nproc)"
make install

mkdir -p "$HOME/.local/bin"
install -m 755 contrib/sbs-glasslock/sbs-glasslock "$HOME/.local/bin/sbs-glasslock"
if [ "$FINGER" = 0 ]; then
  sed -i '/XSECURELOCK_FINGER_PAM_SERVICE/d' "$HOME/.local/bin/sbs-glasslock"
fi

ACCOUNT=common-account
[ -e /etc/pam.d/common-account ] || ACCOUNT=system-auth
services="sbs-glasslock-password"
[ "$FINGER" = 1 ] && services="$services sbs-glasslock-finger"
for svc in $services; do
  sed "s/common-account/$ACCOUNT/" "contrib/sbs-glasslock/pam.d/$svc" | sudo tee "/etc/pam.d/$svc" >/dev/null
done

cat <<MSG

Installed. Test it safely first (it unlocks itself after 30 seconds):
  timeout 30 ~/.local/bin/sbs-glasslock
Then bind ~/.local/bin/sbs-glasslock to a keyboard shortcut (see docs/INSTALL.md).
MSG
