## `mariadbConnect`

> Connect to a mariadb-type database using a URL

### Usage

    mariadbConnect [ dsn ] [ binary ] [ --print ]

Connect to a mariadb-type database using a URL

### Arguments

- `dsn` - URL. Database to connect to. All arguments after this are passed to `binary`.
- `binary` - Callable. Executable to connect to the database.
- `--print` - Flag. Optional. Just print the statement instead of running it.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:MARIADB_BINARY_CONNECT.sh}

