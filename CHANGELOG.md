# Changelog

All notable changes to SBS GlassLock. Versions follow `MAJOR.MINOR.PATCH`; the upstream base is noted for each.

## [1.0.1] - 2026-11-10

### Fixed
- The status dot no longer flickers between red and green when the fingerprint reader is unavailable (no device,
  `fprintd` stuck). A fingerprint PAM service that exits in under 1.5 s is now treated as "reader unavailable":
  the dot stays green and the reader is retried after ~10 s instead of every 2 s. Red is shown only for a real
  failed scan or a wrong password.

### Documentation
- Troubleshooting entry for a wedged fingerprint reader (`endpoint stalled`) and how to power-cycle its USB port.

## [1.0.0] - 2026-11-10

First public release. Based on upstream XSecureLock 1.9.0 (commit `98fc8a3`).

### Added
- `XSECURELOCK_TRANSPARENT`: transparent (ARGB) lock windows, the desktop stays visible.
- `XSECURELOCK_MINIMAL_DIALOG`: green/red status dot per monitor instead of the auth dialog.
- `XSECURELOCK_HIDE_DIALOG`: never show the auth dialog.
- `XSECURELOCK_FINGER_PAM_SERVICE`: fingerprint and password accepted in parallel.
- Launcher `sbs-glasslock`, PAM service files, `install.sh` and `uninstall.sh`.
- Documentation: installation, compatibility, how it works, disclaimer, security policy.

### Changed
- Upstream's `README.md` moved to `README.upstream.md` (the build reads the option list from it).

### Known issues
- Tested only on Parrot OS 7 (Debian 13 base) with KDE Plasma 6 on X11. See `docs/COMPATIBILITY.md`.
