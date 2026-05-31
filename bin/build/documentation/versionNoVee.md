## `versionNoVee`

> Strip leading vee from version tags

### Usage

    versionNoVee [ --help ]

Take one or more versions and strip the leading `v`

> Location: `bin/build/tools/version.sh`

### Arguments

- `--help` - Flag. Optional. Display this help.

### Reads standard input

Versions containing a preceding `v` character (optionally)

### Writes to standard output

Versions with the initial `v` (if it exists) removed

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

