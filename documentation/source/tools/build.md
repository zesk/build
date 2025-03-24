# Build Functions

- Easier access to `BUILD_HOME` (calculates if needed) and environment variables
- List of all Zesk Build functions
- Creation and easy access to cache directory
- Access known environment variables with defaults, and installing `install-bin-build.sh` in new projects.

<!-- TEMPLATE header 2 -->
[⬅ Parent ](../index.md)
<hr />

{buildHome}
{buildEnvironmentGet}
{buildEnvironmentLoad}
{buildEnvironmentContext}
{buildFunctions}
{buildCacheDirectory}
{buildQuietLog}

# Running commands

{Build}

# Installing `install-bin-build.sh`

{installInstallBuild}

# Installing Zesk Build

{__installPackageConfiguration}

# Package Installation

These tools are if you wish to write your own installer for your own software in `bash` using **Zesk Build**.

Copy `install-bin-build.sh` and rename, keep up to date in your own project with `bin/build/identical-repair.sh --internal`.

{_installRemotePackage}
{installInstallBinary}

It will download and install your package as outlined in [building your own installer](../guide/installer.md)
