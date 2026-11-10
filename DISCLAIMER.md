# Disclaimer

Please read this before installing or using SBS GlassLock.

## No warranty

SBS GlassLock is provided **"as is"**, without warranty of any kind, express or implied, including merchantability,
fitness for a particular purpose and non-infringement, as stated in sections 7 and 8 of the
[Apache License 2.0](LICENSE). In no event shall SmartBrain Services, S.A.S. de C.V., the contributors or Google be
liable for any claim, damages or other liability arising from the use of this software.

## Security software: use at your own risk

- This is a **screen lock**, not a security product, and it has **not been independently audited**.
- It deliberately **keeps the screen visible** while locked. Do not use it where the screen contents must be hidden.
- Changing the lock or PAM configuration can **lock you out** of your own session. Always test with
  `timeout 30 sbs-glasslock` first and keep a text console available.
- The installer creates files in `/etc/pam.d/` using `sudo`. Read `contrib/sbs-glasslock/` before running it.
- Fingerprint authentication is generally weaker than a strong password.
- It does not protect against physical-access attacks, a compromised session, a compromised compositor or malware
  already running as your user.
- You are responsible for complying with the laws, regulations and policies that apply to you (including your
  organization's security policies) when installing or using it.

## Not affiliated

SBS GlassLock is an independent fork of [XSecureLock](https://github.com/google/xsecurelock). It is **not
affiliated with, sponsored by or endorsed by Google LLC**. "Google" and other product names are trademarks of their
respective owners and are used here only to identify the upstream project and its authors. No upstream trademark or
logo is used as the name of this project.

Linux, Debian, Ubuntu, Fedora, Arch, KDE, Plasma, GNOME, XFCE and other names mentioned are trademarks of their
respective owners and appear only to describe compatibility.

## Third-party software

SBS GlassLock builds on and links against third-party libraries (Xlib and X11 extensions, Xft, fontconfig, Linux-PAM)
and can use `fprintd`. They keep their own licenses and are not distributed in this repository. See
[CREDITS.md](CREDITS.md).

## Your data

The program runs locally and does not collect, store or transmit any data. Passwords are handled by PAM exactly as in
upstream XSecureLock.
