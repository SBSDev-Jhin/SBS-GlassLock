# How it works

XSecureLock splits the job into several programs: `xsecurelock` (grabs input, owns the windows), a saver, and
`auth_x11` with `authproto_pam` (shows the dialog and talks to PAM). SBS GlassLock changes three things.

## 1. Transparent windows (`main.c`)

Upstream creates its covering windows with an opaque background. With `XSECURELOCK_TRANSPARENT=1` the background and
saver windows are created with a 32-bit ARGB visual, its own colormap and `background_pixel = 0` (alpha 0). A
compositing window manager then shows the desktop through them. The composite-overlay-window trick that upstream uses
to cover everything is disabled in this mode. The auth window keeps the default visual because `auth_x11` draws with
Xft on it.

## 2. Status dot (`helpers/auth_x11.c`)

With `XSECURELOCK_MINIMAL_DIALOG=1`, `DisplayMessage()` is replaced by `DisplayDot()`: a 9 px window, shaped as a
circle with XShape, in the top-right corner of each monitor, filled green or red. Red is shown for two seconds after
a failed fingerprint, after PAM asks for the password again (a rejected password) and after authentication ends in
failure.

## 3. Parallel fingerprint (`helpers/auth_x11.c`)

With the stock PAM stack, `pam_fprintd` runs first and blocks until the finger is read or it times out, and only then
the password is asked, so typing a password blindly does not work. With
`XSECURELOCK_FINGER_PAM_SERVICE=<service>`, `auth_x11` starts a second `authproto_pam` for a fingerprint-only service
in the background while the main one asks for the password in a password-only service. Whichever succeeds first
unlocks; if the fingerprint attempt fails it is restarted after a short pause.

The two services are plain files (`/etc/pam.d/sbs-glasslock-password`, `/etc/pam.d/sbs-glasslock-finger`) provided in
`contrib/sbs-glasslock/pam.d/`.

## Diff against upstream

Base: upstream XSecureLock 1.9.0 (commit `98fc8a3`). Changes are in `main.c`, `helpers/auth_x11.c`, the option list
(`README.upstream.md`, which the build uses to generate `--help`) and the new `contrib/`, `docs/` and top-level
project files. `git log` keeps upstream's full history.
