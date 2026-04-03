## `fileType`

> Better type handling of shell objects

### Usage

    fileType [ item ] [ --help ]

Better type handling of shell objects
Outputs one of `type` output or enhancements:
- `builtin`, `function`, `alias`, `file`
- `link-directory`, `link-file`, `link-dead`, `directory`, `integer`, `unknown`

### Arguments

- `item` - String. Optional. Thing to classify
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

