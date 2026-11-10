# Credits

## Original work

**XSecureLock**, by Google. Copyright 2014 Google Inc. All rights reserved. Licensed under the Apache License 2.0.
<https://github.com/google/xsecurelock>

All the real lock-screen engineering (input grabbing, window protection, PAM protocol, multi-monitor support,
savers) is theirs. SBS GlassLock is a small set of changes on top of it. The upstream git history is preserved in this
repository so every original author stays credited.

## This fork

**SBS GlassLock**, Copyright 2026 SmartBrain Services, S.A.S. de C.V.
<https://smartbrainservices.com>

Changes: transparent lock windows, status dot, parallel fingerprint and password authentication, PAM service files,
installer and documentation.

## Projects this work is based on or inspired by

| Project | Role | Link |
|---------|------|------|
| **XSecureLock** (Google) | **Code base.** SBS GlassLock is a fork of it. | <https://github.com/google/xsecurelock> |
| **xtrlock** | **Inspiration.** The idea of a lock that leaves the screen visible comes from it. No xtrlock code is used. | <https://packages.debian.org/xtrlock> (Debian package page) |

## Projects it depends on or works with (not included in this repository)

| Project | Used for | Link | License |
|---------|----------|------|---------|
| Linux-PAM | authentication | <https://github.com/linux-pam/linux-pam> | BSD-style / GPL |
| fprintd | fingerprint authentication (optional) | <https://gitlab.freedesktop.org/libfprint/fprintd> | GPL |
| libfprint | fingerprint reader drivers (optional, via fprintd) | <https://gitlab.freedesktop.org/libfprint/libfprint> | LGPL |
| X.Org (Xlib, Xext, Xcomposite, XScreenSaver, Xrandr, Xfixes, Xmu) | windows, input grabs, multi-monitor | <https://gitlab.freedesktop.org/xorg> | MIT/X11 |
| Xft and fontconfig | text rendering | <https://gitlab.freedesktop.org/fontconfig/fontconfig> | MIT style |
| xss-lock, xautolock, XScreenSaver | optional tools that upstream XSecureLock documents for auto-locking and savers; not required here | see upstream README | see each project |

Each project keeps its own license and copyright; their names belong to their respective owners.

## Developed and tested with

KDE Plasma and its window manager KWin (<https://invent.kde.org/plasma/kwin>) as the compositing environment during
development, on Parrot OS (Debian-based). KDE is a trademark of KDE e.V.; no endorsement is implied.

## Thanks

To the authors and maintainers of all the projects above, and to everyone who has contributed to XSecureLock upstream.
If we forgot to credit you or a project, please open an issue and we will fix it.
