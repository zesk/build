## `packageUninstall`

> Removes packages using package manager

### Usage

    packageUninstall package [ --manager packageManager ]

Removes packages using the current package manager.

### Arguments

- `package` - String. Required. One or more packages to uninstall
- `--manager packageManager` - String. Optional. Package manager to use. (apk, apt, brew)

### Examples

    packageUninstall shellcheck

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

