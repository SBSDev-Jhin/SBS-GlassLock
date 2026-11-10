# SBS GlassLock vs. xtrlock vs. XSecureLock

Three X11 lockers, three different trade-offs. None is "best"; pick by what you need.

| | xtrlock | XSecureLock (upstream) | **SBS GlassLock** |
|---|:---:|:---:|:---:|
| Screen stays visible while locked | yes | no (opaque cover) | **yes** |
| Authentication | password checked against the shadow database (`crypt`), no PAM | PAM | **PAM** |
| Fingerprint (fprintd) | no | yes | **yes** |
| Password and fingerprint at the same time | n/a | no (the stack runs in order; the fingerprint step comes first) | **yes (parallel)** |
| Visual feedback | cursor only | dialog with title, user, asterisks | **tiny green/red dot** |
| Multi-monitor handling | not a feature | yes | **yes (dot on each monitor)** |
| Needs a compositor | no | no | **yes (for transparency)** |
| Hides what is on screen | no | yes | **no** |
| Code size / attack surface | very small | larger, split into separate processes | same as upstream plus a small patch |
| Packaged by distros | yes | yes | no (build from source) |
| Wayland | no | no | no |

## Advantages of SBS GlassLock over xtrlock

- **Fingerprint and any other PAM method.** xtrlock does not use PAM, so it cannot use `fprintd`, smart cards or
  any PAM-based setup. SBS GlassLock does.
- **Honors the system's account rules** (expired accounts, lockouts configured in PAM).
- **Feedback.** xtrlock gives almost none; the dot tells you when it is waiting and when an attempt failed.
- **Multi-monitor handling and window protection**, inherited from XSecureLock (it keeps its windows on top and
  watches for other windows covering them).
- **Security-oriented base.** XSecureLock is designed around separating privileged and unprivileged parts into
  different processes; SBS GlassLock keeps that design.

## Advantages of SBS GlassLock over upstream XSecureLock

- **The desktop stays visible**, which upstream cannot do (it always covers the screen).
- **Password and fingerprint in parallel.** With the stock PAM stack the fingerprint step runs first and blocks the
  password prompt until it times out; here either one unlocks immediately.
- **Minimal, unobtrusive feedback** instead of a dialog box over your screen.

## What you give up

- **Privacy.** Anything on screen is readable while locked, including notification pop-ups. xtrlock has the same
  property; upstream XSecureLock does not.
- **Simplicity of xtrlock.** xtrlock is a very small program with almost no dependencies; SBS GlassLock is
  XSecureLock plus extra code and needs a compositor.
- **Packaging.** You build it yourself and install two PAM files; there is no distro package.
- **Maturity.** SBS GlassLock is new and has been tested on one environment so far (see
  [COMPATIBILITY.md](COMPATIBILITY.md)); xtrlock and XSecureLock have been used by many people for years.

## Which one should I use?

- You want the screen **hidden**: upstream XSecureLock (or your desktop's locker).
- You want the lightest possible **visible** lock and password-only is fine: xtrlock.
- You want a **visible** lock with **fingerprint** and password: SBS GlassLock.
