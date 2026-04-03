## `pipInstall`

> Utility to install python dependencies via pip

### Usage

    pipInstall [ --help ] [ --handler handler ] pipPackage [ ... ]

Utility to install python dependencies via pip
Installs python if it hasn't been using `pythonInstall`.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- pipPackage [ ... ]- `` - String. Required. Pip package name to install.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

