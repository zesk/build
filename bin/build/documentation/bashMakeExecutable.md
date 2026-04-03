## `bashMakeExecutable`

> Makes all `*.sh` files executable

### Usage

    bashMakeExecutable [ --find findArguments ] [ path ... ]

Makes all `*.sh` files executable

### Arguments

- `--find findArguments` - String. Optional. Add arguments to exclude files or paths. SPACE-delimited for multiple options.
- `path ...` - Directory. Optional. One or more paths to scan for shell files. Uses PWD if not specified.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- Works from the current directory

