## `manPathRemove`

> Remove a path from the MANPATH environment variable

### Usage

    manPathRemove [ --help ] path ...

Remove a path from the MANPATH environment variable

### Arguments

- `--help` - Flag. Optional. Display this help.
- `path ...` - Directory. Required. The path to be removed from the `MANPATH` environment

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:MANPATH.sh}

