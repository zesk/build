## `bashFindUncaughtAssertions`

> Search bash files for assertions which do not terminate a

### Usage

    bashFindUncaughtAssertions [ --help ] [ --handler handler ] [ --exclude path ] [ --exec binary ] [ directory ] [ --list ]

Search bash files for assertions which do not terminate a function and are likely an error

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--exclude path` - String. Optional. Exclude paths which contain this string
- `--exec binary` - Executable. Optional. For each failed file run this command.
- `directory` - Directory. Optional. Where to search for files to check.
- `--list` - Flag. Optional. List files which fail. (Default is simply to exit silently.)

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

