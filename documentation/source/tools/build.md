# Build Environment Functions

## Build Application

Configure a project to use **Zesk Build**.

{buildApplicationConfigure}

## Build Environment

- Easier access to `BUILD_HOME` (calculates if needed) and environment variables
- Creation and easy access to cache directory
- Access known environment variables with defaults, and installing `install-bin-build.sh` in new projects.

<!-- TEMPLATE header 2 -->
[⬅ Parent ](../index.md)
<hr />

{buildHome}

{buildEnvironmentGet}

{buildEnvironmentGetDirectory}

{buildEnvironmentFiles}

{buildEnvironmentNames}

{buildEnvironmentLoad}

{buildEnvironmentAdd}

{buildEnvironmentContext}

{buildFunctions}

{buildDeprecatedFunctions}

{buildCacheDirectory}

{buildQuietLog}

## Running commands

{tools}

## Installing `install-bin-build.sh`

{installInstallBuild}

## Installing Zesk Build

{__installPackageConfiguration}

## Package Installer Core

These tools are if you wish to write your own installer for your own software in `bash` using **Zesk Build**'s
functions – but has no dependencies on **Zesk Build**.

Copy `install.sample.sh` and rename, and keep up to date in your own project with
`bin/build/repair.sh --internal`.

Your installer will download and install your package as outlined
in [building your own installer](../guide/installer.md).

{_installRemotePackage}

{installInstallBinary}
