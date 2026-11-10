# SBS GlassLock

**A transparent X11 screen lock with fingerprint and password in parallel.**
Lock your session without hiding it: the desktop stays visible and untouched, a tiny dot shows the state, and you
unlock with your password **or** your fingerprint, whichever comes first.

SBS GlassLock is a fork of Google's [XSecureLock](https://github.com/google/xsecurelock), maintained by
[SmartBrain Services](https://smartbrainservices.com). It is licensed under Apache-2.0 and is **not affiliated
with or endorsed by Google**. Please read the [disclaimer](DISCLAIMER.md) before using it.

```
 locked screen                                   status dot (top-right of every monitor)
 ┌────────────────────────────────────────┐
 │  your desktop, exactly as you left it  │ ●    green  = waiting for password or fingerprint
 │                                        │      red    = failed attempt (back to green after 2 s)
 └────────────────────────────────────────┘
```

## Why

| Locker | Screen stays visible | Fingerprint through PAM |
|--------|:-------------------:|:-----------------------:|
| xtrlock | yes | no (checks `/etc/shadow` directly) |
| XSecureLock (upstream) | no (opaque cover) | yes |
| **SBS GlassLock** | **yes** | **yes** |

## Compared with xtrlock and XSecureLock

SBS GlassLock keeps xtrlock's "screen stays visible" feel and XSecureLock's PAM support. In short: unlike xtrlock it
supports fingerprint and any PAM method with feedback on each monitor, and unlike upstream XSecureLock it leaves the
desktop visible and accepts password and fingerprint in parallel. The trade-offs are that it does not hide the screen,
needs a compositor and is built from source. Full table and honest downsides: [docs/COMPARISON.md](docs/COMPARISON.md).

## What it adds on top of XSecureLock

| Setting | Effect |
|---------|--------|
| `XSECURELOCK_TRANSPARENT=1` | Lock windows use a 32-bit ARGB visual with alpha 0, so a compositing window manager shows the desktop through them. |
| `XSECURELOCK_MINIMAL_DIALOG=1` | Replaces the auth dialog with a 9 px dot in the top-right corner of each monitor: green = waiting, red = failed attempt. |
| `XSECURELOCK_FINGER_PAM_SERVICE=<service>` | Runs a fingerprint-only PAM service **in parallel** with the password one, so typing a password never waits for the fingerprint timeout. |
| `XSECURELOCK_HIDE_DIALOG=1` | Never shows the auth dialog at all. |

Everything else is upstream XSecureLock 1.9.0 behavior.

## Quick install (3 steps)

Works on Linux with an **X11 session** and a **compositor** running. Not for Wayland. See
[compatibility](docs/COMPATIBILITY.md).

```bash
# 1. dependencies (Debian/Ubuntu names; see docs/INSTALL.md for other distros)
sudo apt install build-essential autoconf automake pkg-config libx11-dev libxext-dev libxcomposite-dev \
  libxss-dev libpam0g-dev libxft-dev libxrandr-dev libxfixes-dev libxmu-dev libxmuu-dev

# 2. get the code and install (asks for sudo once, only to create two PAM service files)
git clone https://github.com/SBSDev-Jhin/sbs-glasslock.git && cd sbs-glasslock
bash contrib/sbs-glasslock/install.sh            # add --no-fingerprint if you have no fingerprint reader

# 3. test it safely: it unlocks itself after 30 seconds
timeout 30 ~/.local/bin/sbs-glasslock
```

Then bind `~/.local/bin/sbs-glasslock` to a keyboard shortcut (KDE, GNOME, XFCE, i3 examples in
[docs/INSTALL.md](docs/INSTALL.md)).

Prefer a ready-made source archive? Download `sbs-glasslock-<version>.tar.gz` from the
[Releases](../../releases) page and run the same installer from the extracted folder.

## Using it

1. Run `sbs-glasslock` (or your shortcut). The screen stays as it is.
2. Touch any key to wake the lock. That key is discarded. A **green dot** appears on every monitor.
3. Type your password and press Enter, **or** use your fingerprint reader.
4. A **red dot** means the attempt failed. It returns to green and you can try again.

## Important notes

- It does **not** hide your screen. Anything visible (windows, notifications) can be read by someone standing in
  front of the locked computer. If you need to hide the screen, use the upstream XSecureLock or your desktop's locker.
- **Test with `timeout 30 ...` first.** A wrong PAM configuration could stop you from unlocking. Keep a text
  console (`Ctrl+Alt+F2`) available the first times.
- Provided "as is", without warranty. See [DISCLAIMER.md](DISCLAIMER.md) and [SECURITY.md](SECURITY.md).

## Documentation

- [Installation, shortcuts, uninstall and troubleshooting](docs/INSTALL.md)
- [Compatibility: tested environment, expected to work, known not to work](docs/COMPATIBILITY.md)
- [Comparison with xtrlock and XSecureLock](docs/COMPARISON.md)
- [How it works (technical notes)](docs/HOW-IT-WORKS.md)
- [Original XSecureLock README and full option list](README.upstream.md)
- [Changelog](CHANGELOG.md) · [Credits](CREDITS.md) · [Contributing](CONTRIBUTING.md) · [Spanish README](README.es.md)

## Credits

Built on [XSecureLock](https://github.com/google/xsecurelock) by Google, inspired by xtrlock, and relying on
Linux-PAM, fprintd/libfprint and X.Org. Full list with links: [CREDITS.md](CREDITS.md).

## License

Apache License 2.0, the same as upstream. See [LICENSE](LICENSE) and [NOTICE](NOTICE).
Original work Copyright Google Inc. Modifications Copyright 2026 SmartBrain Services, S.A.S. de C.V.
