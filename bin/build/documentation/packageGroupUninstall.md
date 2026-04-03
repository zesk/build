## `packageGroupUninstall`

> Uninstall a package group

### Usage

    packageGroupUninstall group

Uninstall a package group
Any unrecognized groups are uninstalled using the name as-is.

### Arguments

- `group` - String. Required. Currently allowed: "python"

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

