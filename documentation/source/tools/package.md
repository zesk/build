# Package Manager Tools

<!-- TEMPLATE toolHeader 2 -->
[🛠️ Tools ](./index.md) &middot; [⬅ Top ](../index.md)
<hr />

Wrapper around:

- [apt](./apt.md) (Debian/Ubuntu)
- [apk](./apk.md) (Alpine)
- [MacPorts](./macports.md) and [brew](./brew.md) (Darwin)

Package names change between platforms. Use `packageGroupInstall` for generic cross-platform names.

## Conditional installation

{packageWhich}
{packageWhichUninstall}

## Package management

{packageUpdate}
{packageUpgrade}
{packageInstall}
{packageUninstall}

## Package groups

A package group represents software which often is installed using different package manager names.

{packageGroupWhich}
{packageGroupInstall}
{packageGroupUninstall}
{packageMapping}

## Package lists

{packageDefault}
{packageIsInstalled}
{packageInstalledList}
{packageAvailableList}

## Package Utilities

{packageManagerValid}
{packageManagerDefault}
{packageNeedRestartFlag}
