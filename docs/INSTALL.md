# Installation

## 1. Requirements

An X11 session, a compositing window manager running, Linux-PAM. See [COMPATIBILITY.md](COMPATIBILITY.md).

Dependencies:

```bash
# Debian / Ubuntu / Parrot / Kali / Mint
sudo apt install build-essential autoconf automake pkg-config libx11-dev libxext-dev libxcomposite-dev \
  libxss-dev libpam0g-dev libxft-dev libxrandr-dev libxfixes-dev libxmu-dev libxmuu-dev

# Fingerprint (optional)
sudo apt install fprintd libpam-fprintd && fprintd-enroll
```

```bash
# Fedora (package names may vary slightly)
sudo dnf install gcc make autoconf automake pkgconf-pkg-config libX11-devel libXext-devel libXcomposite-devel \
  libXScrnSaver-devel pam-devel libXft-devel libXrandr-devel libXfixes-devel libXmu-devel

# Arch
sudo pacman -S base-devel libx11 libxext libxcomposite libxss pam libxft libxrandr libxfixes libxmu
```

## 2. Install

```bash
git clone https://github.com/<owner>/sbs-glasslock.git
cd sbs-glasslock
bash contrib/sbs-glasslock/install.sh            # or: --no-fingerprint
```

Or download the source archive from the Releases page, extract it and run the same script.

The installer:

- builds the program into `~/.local/sbs-glasslock` (nothing is installed system-wide, your system XSecureLock, if any,
  is untouched);
- installs the launcher `~/.local/bin/sbs-glasslock` (make sure `~/.local/bin` is in your `PATH`);
- uses `sudo` **once** to create `/etc/pam.d/sbs-glasslock-password` and, unless `--no-fingerprint`,
  `/etc/pam.d/sbs-glasslock-finger`.

## 3. Test before you rely on it

```bash
timeout 30 ~/.local/bin/sbs-glasslock
```

It locks and then exits on its own after 30 seconds, so you cannot get stuck. Check: the desktop is visible on all
monitors, a touch of any key shows a green dot, your password unlocks, a wrong password turns the dot red, and (if
installed) the fingerprint unlocks. Keep a text console (`Ctrl+Alt+F2`) at hand the first times; from there
`pkill -x xsecurelock` ends a stuck lock.

## 4. Bind a keyboard shortcut

Bind the command `~/.local/bin/sbs-glasslock` (use the full path).

- **KDE Plasma:** System Settings > Keyboard > Shortcuts > Add New > Command or Script.
- **GNOME (on Xorg):** Settings > Keyboard > Custom Shortcuts.
- **XFCE:** Settings > Keyboard > Application Shortcuts.
- **i3:** `bindsym $mod+l exec --no-startup-id ~/.local/bin/sbs-glasslock`
- **Other:** any tool that runs a command on a key combination.

Avoid paths with spaces in shortcut commands, many desktops split them.

## 5. Update

```bash
cd sbs-glasslock && git pull && bash contrib/sbs-glasslock/install.sh
```

## 6. Uninstall

```bash
bash contrib/sbs-glasslock/uninstall.sh
```

Then remove your keyboard shortcut.

## Troubleshooting

| Symptom | Likely cause / fix |
|---------|--------------------|
| The screen goes black instead of transparent | No compositor running, or you launched the system `xsecurelock` instead of `~/.local/bin/sbs-glasslock`. |
| The password never unlocks | `/etc/pam.d/sbs-glasslock-password` missing or wrong `@include`. Re-run the installer, or check `journalctl`/auth logs. |
| No green dot, nothing happens on key press | Check the terminal output of `timeout 30 ~/.local/bin/sbs-glasslock`. Make sure you run an X11 session (`echo $XDG_SESSION_TYPE`). |
| Fingerprint never works | Run `fprintd-verify`. If that fails, enroll with `fprintd-enroll`; otherwise reinstall with `--no-fingerprint`. |
| `Could not find the program ...` from a shortcut | The shortcut command has spaces in its path. Use `~/.local/bin/sbs-glasslock`. |
| Stuck locked | `Ctrl+Alt+F2`, log in, run `pkill -x xsecurelock`. |
| Build error about missing headers | Install the dependencies in step 1. |
