## `packageInstall`

> Install packages using a package manager

### Usage

    packageInstall [ package ] [ --verbose ] [ --manager packageManager ] [ --force ] [ --show-log ]

Install packages using a package manager.
Supported managers:
- apk
- apt-get
- brew

### Arguments

- `package` - One or more packages to install
- `--verbose` - Flag. Optional. Display progress to the terminal.
- `--manager packageManager` - String. Optional. Package manager to use. (apk, apt, brew)
- `--force` - Flag. Optional. Force even if it was updated recently.
- `--show-log` - Flag. Optional. Show package manager logs.

### Examples

    packageInstall shellcheck

### Return codes

- `0` - If `apk` is not installed, returns 0.
- `1` - If `apk` fails to install the packages

