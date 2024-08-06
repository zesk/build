# Self Functions

Easier access to `BUILD_HOME`, list of all functions, cache directory, known environment variables with defaults, and installing `install-bin-build.sh` in new projects.

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />


### `buildHome` - Prints the build home directory (usually same as the application

Prints the build home directory (usually same as the application root)

#### Usage

    buildHome
    

#### Exit codes

- `0` - Always succeeds

#### Environment

BUILD_HOME

### `buildEnvironmentLoad` - Load one or more environment settings from bin/build/env or bin/env.

Load one or more environment settings from bin/build/env or bin/env.


If BOTH files exist, both are sourced, so application environments should anticipate values
created by build's default.

Modifies local environment. Not usually run within a subshell.

#### Usage

    buildEnvironmentLoad [ envName ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Environment

$envName

### `buildFunctions` - Prints the list of functions defined in Zesk Build

Prints the list of functions defined in Zesk Build

#### Usage

    buildFunctions
    

#### Exit codes

- `0` - Always succeeds

#### Environment

BUILD_HOME

### `buildCacheDirectory` - Path to cache directory for build system.

Path to cache directory for build system.

Defaults to `$HOME/.build` unless `$HOME` is not a directory.

Appends any passed in arguments as path segments.

#### Usage

    buildCacheDirectory [ pathSegment ... ]
    

#### Arguments



#### Examples

    logFile=$(buildCacheDirectory test.log)

#### Exit codes

- `0` - Always succeeds

#### Usage

    buildQuietLog name
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

# Installing `install-bin-build.sh`


### `installInstallBuild` - Installs `install-bin-build.sh` the first time in a new project, and

Installs `install-bin-build.sh` the first time in a new project, and modifies it to work in the application path.

#### Usage

    installInstallBuild [ --help ] [ --diff ] [ --local ] [ path [ applicationHome ] ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

# Intalling Zesk Build


### `install-bin-build.sh` - Installs a remote package system in a local project directory

Installs a remote package system in a local project directory if not installed. Also
will overwrite the installation binary with the latest version after installation.

Determines the most recent version using GitHub API unless --url or --local is specified

#### Arguments



#### Exit codes

- `1` - Environment error
- `2` - Argument error

#### Environment

Needs internet access and creates a directory `./bin/build`

# Remote Package Installation


### `_installRemotePackage.sh` - Installs a remote package system in a local project directory

Installs a remote package system in a local project directory if not installed. Also
will overwrite the installation binary with the latest version after installation.

URL can be determined programmatically using `urlFunction`.

#### Arguments



#### Exit codes

- `1` - Environment error
- `2` - Argument error
