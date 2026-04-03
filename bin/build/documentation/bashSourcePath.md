## `bashSourcePath`

> Load a directory of bash scripts

### Usage

    bashSourcePath [ --exclude pattern ] directory ... [ --help ]

Load a directory of bash scripts, excluding any dot directories (`*/.*/*`), and optionally any additional
files if you use `--exclude`. But recursively loads scripts in sorted alphabetic order within the directory until one fails.
All files must be executable.
Load a directory of `.sh` files using `source` to make the code available.
Has security implications. Use with caution and ensure your directory is protected.

### Arguments

- `--exclude pattern` - String. Optional. String passed to `! -path pattern` in `find`
- `directory ...` - Directory. Required. Directory to `source` all `.sh` files used.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

