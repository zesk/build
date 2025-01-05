# MariaDB Functions

**MariaDB** is the open-source successor to **MySQL** which was acquired by **Oracle**. These functions can be used with any installation which is compatible with **MariaDB** or **MySQL**.

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `mariadbDump` - Dump a MariaDB database to raw SQL

Dump a MariaDB database to raw SQL

- Location: `bin/build/tools/mariadb.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--echo` - Optional. Flag. Show the command.
- `--binary` - Optional. Executable. The binary to use to do the dump. Defaults to `MARIADB_BINARY_DUMP`.
- `--lock` - Optional. Flag. Lock the database during dump
- `--password password` - Optional. String. Password to connect
- `--user user` - Optional. String. User to connect
- `--host host` - Optional. String. Host to connect
- `--port port` - Optional. Integer. Port to connect

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
