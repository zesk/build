## `pipUninstall`

> Utility to uninstall python dependencies via pip

### Usage

    pipUninstall [ --help ] [ --handler handler ] pipPackage [ ... ]

Utility to uninstall python dependencies via pip

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- pipPackage [ ... ]- `` - String. Required. Pip package name to uninstall.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

