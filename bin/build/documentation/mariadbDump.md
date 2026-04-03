## `mariadbDump`

> Dump a MariaDB database to raw SQL

### Usage

    mariadbDump [ --help ] [ --print ] [ --binary ] [ --lock ] [ --password password ] [ --user user ] [ --host host ] [ --port port ]

Dump a MariaDB database to raw SQL

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--print` - Flag. Optional. Show the command.
- `--binary` - Executable. Optional. The binary to use to do the dump. Defaults to `MARIADB_BINARY_DUMP`.
- `--lock` - Flag. Optional. Lock the database during dump
- `--password password` - String. Optional. Password to connect
- `--user user` - String. Optional. User to connect
- `--host host` - String. Optional. Host to connect
- `--port port` - Integer. Optional. Port to connect

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

