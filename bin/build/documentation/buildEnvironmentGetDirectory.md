## `buildEnvironmentGetDirectory`

> Load and print one or more environment settings which represents

### Usage

    buildEnvironmentGetDirectory [ envName ] [ --subdirectory subdirectory ] [ --mode fileMode ] [ --owner ownerName ] [ --no-create ]

Load and print one or more environment settings which represents a directory which should be created.
If BOTH files exist, both are sourced, so application environments should anticipate values
created by build's default.
Modifies local environment. Not usually run within a subshell.

### Arguments

- `envName` - String. Optional. Name of the environment value to load. Afterwards this should be defined (possibly blank) and `export`ed.
- `--subdirectory subdirectory` - String. Optional. Name of a subdirectory to return "beneath" the value of environment variable. Created if the flag is set.
- `--mode fileMode` - String. Optional. Enforce the mode for `mkdir --mode` and `chmod`. Use special mode `-` to mean no mode enforcement.
- `--owner ownerName` - String. Optional. Enforce the owner of the directory. Use special ownerName `-` to mean no owner enforcement.
- `--no-create` - Flag. Optional. Do not create the subdirectory if it does not exist.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- $envName
- {SEE:BUILD_ENVIRONMENT_DIRS.sh} - `:` separated list of paths to load env files

