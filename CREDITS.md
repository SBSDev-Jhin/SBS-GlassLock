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

## Components it depends on (not included in this repository)

| Component | Used for | License |
|-----------|----------|---------|
| Xlib and X11 extensions (Xext, Xcomposite, XScreenSaver, Xrandr, Xfixes) | windows, input grabs, multi-monitor | MIT/X11 |
| Xft, fontconfig | text rendering | MIT/X11 style |
| Linux-PAM | authentication | BSD-style / GPL (see the project) |
| fprintd and libfprint (optional) | fingerprint reader | GPL / LGPL (see each project) |

Each keeps its own license. Their names belong to their respective owners.

## Tested with

KDE Plasma (KWin) as the compositing environment during development. KDE is a trademark of KDE e.V.; no endorsement is
implied.
