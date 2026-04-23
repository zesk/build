## `userRecordName`

> Quick user database query of the user name

### Usage

    userRecordName [ user ] [ database ]

Look user up, output user name

### Arguments

- `user` - String. Optional. User name to look up. Uses `whoami` if not supplied.
- `database` - File. Optional. User name database file to examine. Uses `/etc/passwd` if not supplied.

### Writes to standard output

the user name

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

