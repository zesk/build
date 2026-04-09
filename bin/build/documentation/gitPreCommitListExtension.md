## `gitPreCommitListExtension`

> List the file(s) of an extension.

### Usage

    gitPreCommitListExtension [ extension ] [ --help ]

List the file(s) of an extension.

### Arguments

- `extension` - String. Optional. Extension to list. Use `!` for blank extension and `@` for all extensions. Can specify one or more.
- `--help` - Flag. Optional. Display this help.

### Writes to standard output

File. One per line.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

