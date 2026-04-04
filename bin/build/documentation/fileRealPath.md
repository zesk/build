## `fileRealPath`

> Find the full, actual path of a file avoiding symlinks

### Usage

    fileRealPath file ...

Find the full, actual path of a file avoiding symlinks or redirection.
Without arguments, displays help.

### Arguments

- `file ...` - File. Required. One or more files to `realpath`.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

