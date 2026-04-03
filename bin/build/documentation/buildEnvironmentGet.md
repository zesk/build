## `buildEnvironmentGet`

> Load and print one or more environment settings

### Usage

    buildEnvironmentGet [ envName ] [ --application applicationHome ] [ --quiet ]

Load and print one or more environment settings
If BOTH files exist, both are sourced, so application environments should anticipate values
created by build's default.
Modifies local environment. Not usually run within a subshell.

### Arguments

- `envName` - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and `export`ed.
- `--application applicationHome` - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.
- `--quiet` - Flag. Optional. No error is displayed when an environment variable does not exist, but return code 1 is returned.

### Writes to standard output

The environment variable(s) requested, one per line

### Return codes

- `1` - The environment variable is not found.
- `0` - The environment variable is found and the value was output to `stdout`

### Environment

- $envName
- {SEE:BUILD_ENVIRONMENT_DIRS.sh} - `:` separated list of paths to load env files

