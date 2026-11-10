# Security policy

## Reporting a vulnerability

Please **do not** open a public issue for a security problem. Use GitHub's private vulnerability reporting for this
repository ("Security" tab > "Report a vulnerability"), or contact SmartBrain Services through the contact details on
<https://smartbrainservices.com> and mention "SBS GlassLock security".

Include the version (`git describe` or the release tag), your distribution and desktop, and steps to reproduce.
Do not send real passwords, hostnames or personal data.

We aim to acknowledge a report within a reasonable time and to credit reporters who wish it. This is a small project
maintained on a best-effort basis; no response time or fix is guaranteed.

## Scope

- Issues in the changes made by this fork (transparent windows, status dot, parallel fingerprint, PAM service files,
  installer): report here.
- Issues in unmodified upstream code: please also report them to
  [XSecureLock upstream](https://github.com/google/xsecurelock) (which has its own process).

## Known limitations (not vulnerabilities)

See [DISCLAIMER.md](DISCLAIMER.md) and [docs/COMPATIBILITY.md](docs/COMPATIBILITY.md): the screen stays visible
while locked by design, and physical-access attacks are out of scope.

## Supported versions

Only the latest release is supported.
