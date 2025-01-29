# Self Functions

Easier access to `BUILD_HOME`, list of all functions, cache directory, known environment variables with defaults, and installing `install-bin-build.sh` in new projects.

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `buildHome` - Prints the build home directory (usually same as the application

Prints the build home directory (usually same as the application root)

- Location: `bin/build/tools/self.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

BUILD_HOME
BUILD_HOME
### `buildEnvironmentGet` - Load and print one or more environment settings

Load and print one or more environment settings


If BOTH files exist, both are sourced, so application environments should anticipate values
created by build's default.

Modifies local environment. Not usually run within a subshell.

- Location: `bin/build/tools/self.sh`

#### Arguments

- `envName` - Optional. String. Name of the environment value to load. Afterwards this should be defined (possibly blank) and `export`ed.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

$envName
BUILD_ENVIRONMENT_PATH - `:` separated list of paths to load env files
### `buildEnvironmentLoad` - Load one or more environment settings from the environment file

Load one or more environment settings from the environment file path.


If BOTH files exist, both are sourced, so application environments should anticipate values
created by build's default.

Modifies local environment. Not usually run within a subshell.

- Location: `bin/build/tools/self.sh`

#### Arguments

- `envName` - Optional. String. Name of the environment value to load. Afterwards this should be defined (possibly blank) and `export`ed.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

$envName
BUILD_ENVIRONMENT_PATH - `:` separated list of paths to load env files
### `buildEnvironmentContext` - Run a command and ensure the build tools context matches

Run a command and ensure the build tools context matches the current project
Avoid infinite loops here, call down.

- Location: `bin/build/tools/self.sh`

#### Arguments

- `arguments ...` - Required. Command to run in new context.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `buildFunctions` - Prints the list of functions defined in Zesk Build

Prints the list of functions defined in Zesk Build

- Location: `bin/build/tools/self.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

BUILD_HOME
### `buildCacheDirectory` - Path to cache directory for build system.

Path to cache directory for build system.

Defaults to `$HOME/.build` unless `$HOME` is not a directory.

Appends any passed in arguments as path segments.

- Location: `bin/build/tools/self.sh`

#### Arguments

- `pathSegment` - One or more directory or file path, concatenated as path segments using `/`

#### Examples

    logFile=$(buildCacheDirectory test.log)

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `buildQuietLog` - Generate the path for a quiet log in the build

Generate the path for a quiet log in the build cache directory, creating it if necessary.

- Location: `bin/build/tools/self.sh`

#### Arguments

- `name` - String. Required. The log file name to create. Trims leading `_` if present.
- `--no-create` - Flag. Optional. Do not require creation of the directory where the log file will appear.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

# Running commands

### `Build` - Installs `install-bin-build.sh` the first time in a new project, and

Installs `install-bin-build.sh` the first time in a new project, and modifies it to work in the application path.

- Location: `bin/build/tools/self.sh`

#### Arguments

- `--help` - Optional. Flag. This help.
- `--diff` - Optional. Flag. Show differences between new and old files if changed.
- `--local` - Optional. Flag. Use local copy of `install-bin-build.sh` instead of downloaded version.
- `path` - Optional. Directory. Path to install the binary. Default is `bin`. If ends with `.sh` will name the binary this name.
- `applicationHome` - Optional. Directory. Path to the application home directory. Default is current directory.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

# Installing `install-bin-build.sh`

### `installInstallBuild` - Installs `install-bin-build.sh` the first time in a new project, and

Installs `install-bin-build.sh` the first time in a new project, and modifies it to work in the application path.

- Location: `bin/build/tools/self.sh`

#### Arguments

- `--help` - Optional. Flag. This help.
- `--diff` - Optional. Flag. Show differences between new and old files if changed.
- `--local` - Optional. Flag. Use local copy of `install-bin-build.sh` instead of downloaded version.
- `path` - Optional. Directory. Path to install the binary. Default is `bin`. If ends with `.sh` will name the binary this name.
- `applicationHome` - Optional. Directory. Path to the application home directory. Default is current directory.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

# Intalling Zesk Build

#### Arguments

- `--local localPackageDirectory` - Optional. Directory. Directory of an existing bin/infrastructure installation to mock behavior for testing
- `--url url` - Optional. URL. URL of a tar.gz. file. Download source code from here.
- `--debug` - Optional. Flag. Debugging is on.
- `--force` - Optional. Flag. Force installation even if file is up to date.
- `--diff` - Optional. Flag. Show differences between old and new file.

#### Exit codes

- `1` - Environment error
- `2` - Argument error

#### Environment

Needs internet access and creates a directory `./bin/build`

# Package Installation

#### Arguments

- `--source source` - Optional. String. Source to display for the binary name. INTERNAL.
- `--name name` - Optional. String. Name to display for the remote package name. INTERNAL.
- `--local localPackageDirectory` - Optional. Directory. Directory of an existing installation to mock behavior for testing. INTERNAL.
- `--url url` - Optional. URL. URL of a tar.gz file. Download source code from here.
- `--user headerText` - Optional. String. Add `username:password` to remote request.
- `--header headerText` - Optional. String. Add one or more headers to the remote request.
- `--version-function urlFunction` - Optional. Function. Function to compare live version to local version. Exits 0 if they match. Output version text if you want. INTERNAL.
- `--url-function urlFunction` - Optional. Function. Function to return the URL to download. INTERNAL.
- `--check-function checkFunction` - Optional. Function. Function to check the installation and output the version number or package name. INTERNAL.
- `--replace fie` - Optional. Flag. Replace the target file with this script and delete this one. Internal only, do not use. INTERNAL.
- `--debug` - Optional. Flag. Debugging is on. INTERNAL.
- `--force` - Optional. Flag. Force installation even if file is up to date.
- `--diff` - Optional. Flag. Show differences between old and new file.

#### Exit codes

- `1` - Environment error
- `2` - Argument error
### `installInstallBinary` - Installs an installer the first time in a new project,

Installs an installer the first time in a new project, and modifies it to work in the application path.

- Location: `bin/build/tools/self.sh`

#### Arguments

- `--help` - Optional. Flag. This help.
- `--diff` - Optional. Flag. Show differences between new and old files if changed.
- `--url` - Optional. URL. A remote URL to download the installation script.
- `--url-function` - Optional. Callable. Fetch the remote URL where the installation script is found.
- `--source` - Required. File. The local copy of the `--bin` file.
- `--local` - Optional. Flag. Use local copy `--bin` instead of downloaded version.
- `--bin` - Required. String. Name of the installer file.
- `path` - Optional. Directory. Path to install the binary. Default is `bin`. If ends with `.sh` will name the binary this name.
- `applicationHome` - Optional. Directory. Path to the application home directory. Default is current directory.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
