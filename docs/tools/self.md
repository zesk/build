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
### `buildEnvironmentLoad` - Load one or more environment settings from bin/build/env or bin/env.

Load one or more environment settings from bin/build/env or bin/env.


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
#### Arguments

- `name` - The log file name
- `--no-create` - Optional. Do not require creation of the directory where the log file will appear.

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
