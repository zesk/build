## `directoryRequire`

> Given a list of directories, ensure they exist and create

### Usage

    directoryRequire [ directoryPath ... ] [ --help ] [ --mode fileMode ] [ --owner ownerName ]

Given a list of directories, ensure they exist and create them if they do not.

### Arguments

- `directoryPath ...` - One or more directories to create
- `--help` - Flag. Optional. Display this help.
- `--mode fileMode` - String. Optional. Enforce the directory mode for `mkdir --mode` and `chmod`. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to `-` to reset to no value.
- `--owner ownerName` - String. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to `-` to reset to no value.

### Examples

    directoryRequire "$cachePath"

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

throwArgument usageArgumentFunction usageArgumentString decorate catchEnvironment dirname
chmod chown

