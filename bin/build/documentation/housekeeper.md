## `housekeeper`

> Run a command and ensure files are not modified

### Usage

    housekeeper [ --ignore grepPattern ] [ --temporary temporaryPath ] [ --cache cacheDirectory ] [ --overhead ] [ --path path ] [ path ] [ callable ] [ --help ] [ --handler handler ]

Run a command and ensure files are not modified

### Arguments

- `--ignore grepPattern` - String. Directory. One or more directories to watch. If no directories are supplied uses current working directory.
- `--temporary temporaryPath` - Directory. Optional. Use this as a temporary directory instead of the default.
- `--cache cacheDirectory` - Directory. Optional. Directory used to cache information between calls; if supplied for similar calls saves time in subsequent calls.
- `--overhead` - Flag. Optional. Report on timing used by this function.
- `--path path` - Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory.
- `path` - Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory.
- `callable` - Callable. Optional. Program to run and watch directory before and after.
- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

