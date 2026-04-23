## `userRecordHome`

> Quick user database query of the user home directory

### Usage

    userRecordHome [ user ] [ database ]

Look user up, output user home directory

### Arguments

- `user` - String. Optional. User name to look up. Uses `whoami` if not supplied.
- `database` - File. Optional. User name database file to examine. Uses `/etc/passwd` if not supplied.

### Writes to standard output

`Directory`. The user home directory.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

