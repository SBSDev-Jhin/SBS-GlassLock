# Compatibility

SBS GlassLock is XSecureLock 1.9.0 plus a few changes, so it inherits upstream's requirements. This page says
plainly what was **tested**, what is **expected** to work but was **not tested**, and what **will not** work.

## Tested

| Item | Value |
|------|-------|
| Distribution | Parrot OS 7 (Debian 13 "trixie" base) |
| Session | X11 |
| Desktop / compositor | KDE Plasma 6 with KWin compositing |
| Monitors | Two, side by side, different resolutions (1920x1080 and 1920x1200) |
| Authentication | Linux-PAM, `pam_unix` password + `pam_fprintd` fingerprint reader |
| Compiler | GCC |

Verified there: transparent lock on both monitors, green/red dot on both monitors, unlocking by password,
unlocking by fingerprint, wrong password turning the dot red and allowing a retry.

## Expected to work (not tested)

These should work because they provide X11, a compositor and PAM, but **nobody has verified them yet**:

- Debian 12/13, Ubuntu 22.04/24.04 and derivatives (Linux Mint, Pop!_OS, Kali).
- Fedora and Arch (needs `system-auth` instead of `common-account`; the installer substitutes it, check the result).
- Other desktops running on **X11** with compositing enabled: XFCE (xfwm4 compositor), Cinnamon, MATE (with
  compositing), GNOME on Xorg, i3/openbox/bspwm with `picom`.
- Single-monitor setups and more than two monitors.

If you try one, please open an issue with the result (see "Reporting results" below).

## Will not work

- **Wayland sessions** (GNOME/KDE on Wayland, Sway, Hyprland...). XSecureLock is an X11 program; running under
  XWayland does not give it control of the session. Use your desktop's own locker there.
- **No compositor running.** The transparency comes from the compositor. Without one the lock windows will look
  opaque or show garbage.
- Systems without PAM.

## Known caveats

- **Not a privacy lock.** Everything on screen stays readable while locked, including notification pop-ups.
- **Fingerprint** needs `fprintd`, `libpam-fprintd` (or your distro's equivalent) and an enrolled finger. A
  fingerprint is generally weaker than a strong password; skip the fingerprint service (`--no-fingerprint`) if that
  matters for you.
- The PAM service files are the one distro-specific part: `@include common-account` is Debian/Ubuntu;
  Fedora/Arch use `system-auth`. If your PAM layout is unusual, edit
  `/etc/pam.d/sbs-glasslock-password` and `/etc/pam.d/sbs-glasslock-finger`.
- Proprietary GPU drivers with some compositors can behave differently (flicker, tearing). Untested.
- If the compositor crashes or is restarted while locked, the desktop may be exposed or not drawn correctly. Upstream
  has the same limitation.
- Only the password prompt is replaced by the dot. Informational text from other PAM modules is not shown.
- Physical access attacks (console/TTY, rebooting, disk access, cold boot...) are out of scope for any X11 locker.
  Use disk encryption and firmware/boot protection.

## Build requirements

`gcc`, `make`, `autoconf`, `automake`, `pkg-config` and development headers for: Xlib, Xext, Xcomposite, XScreenSaver
(`libxss`), Xft, Xrandr, Xfixes, Xmu/Xmuu, and PAM. Package names for Debian/Ubuntu are in
[INSTALL.md](INSTALL.md).

## Reporting results

Open an issue titled `Compatibility: <distro> <version> / <desktop> / <X11|Wayland>` with: distribution and version,
desktop and compositor, number of monitors, whether the lock was transparent, whether password and fingerprint
unlocked, and anything odd. **Do not include hostnames, usernames, IP addresses, serial numbers or logs with personal
paths.**
