#!/bin/bash
# Removes everything install.sh created. Needs sudo for the PAM files.
set -euo pipefail
PREFIX="${SBS_GLASSLOCK_PREFIX:-$HOME/.local/sbs-glasslock}"
rm -rf "$PREFIX" "$HOME/.local/bin/sbs-glasslock"
sudo rm -f /etc/pam.d/sbs-glasslock-password /etc/pam.d/sbs-glasslock-finger
echo "SBS GlassLock removed. Remember to delete the keyboard shortcut you created."
