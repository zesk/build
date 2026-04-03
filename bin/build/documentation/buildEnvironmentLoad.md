## `buildEnvironmentLoad`

> Load one or more environment settings from the environment file

### Usage

    buildEnvironmentLoad [ envName ] [ --application applicationHome ] [ --all ] [ --print ] [ --quiet ] [ --help ]

Load one or more environment settings from the environment file path.
If BOTH files exist, both are sourced, so application environments should anticipate values
created by build's default.
Modifies local environment. Not usually run within a subshell.

### Arguments

- `envName` - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and `export`ed.
- `--application applicationHome` - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.
- `--all` - Flag. Optional. Load all environment variables defined in BUILD_ENVIRONMENT_DIRS.
- `--print` - Flag. Print the environment file loaded first.
- `--quiet` - Flag. Optional. No error is displayed when an environment variable does not exist, but return code 1 is returned.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `1` - The environment variable is not found.
- `0` - The environment variable is found and the file was loaded (which *should* set to the global environment variable named)

### Environment

- {SEE:BUILD_ENVIRONMENT_DIRS.sh} - `:` separated list of paths to load env files

