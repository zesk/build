## `mariadbDumpClean`

> Clean mariadb dumps for import

### Usage

    mariadbDumpClean

Clean mariadb dumps of the dreaded code `/*!999999\- enable the sandbox mode */`
- [Official documentation](https://mariadb.org/mariadb-dump-file-compatibility-change/)

### Arguments

- none

### Reads standard input

mariadbDump

### Writes to standard output

mariadbDump (cleaned)

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

