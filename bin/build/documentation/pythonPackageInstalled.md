## `pythonPackageInstalled`

> Is a package installed for python?

### Usage

    pythonPackageInstalled pipPackage ... [ --help ] [ --handler handler ] [ --any ]

Is a package installed for python?

### Arguments

- `pipPackage ...` - String. Required. Package name(s) to check.
- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--any` - Flag. Optional. When specified changes the behavior such that if it returns return code 0 IFF any single package is installed.

### Return codes

- `0` - All packages are installed (or at least one package with `--any`)
- `1` - All packages are not installed (or NO packages are installed with `--any`)

