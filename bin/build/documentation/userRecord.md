## `userRecord`

> Quick user database look up

### Usage

    userRecord index [ user ] [ database ]

Look user up, output a single user database record.

### Arguments

- `index` - PositiveInteger. Required. Index (1-based) of field to select.
- `user` - String. Optional. User name to look up. Uses `whoami` if not supplied.
- `database` - File. Optional. User name database file to examine. Uses `/etc/passwd` if not supplied.

### Writes to standard output

String. Associated record with `index` and `user`.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

