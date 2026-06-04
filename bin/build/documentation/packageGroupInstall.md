### `packageGroupInstall`

> Install a package group

#### Usage

    packageGroupInstall group

Install a package group
Any unrecognized groups are installed using the name as-is.

> Location: `bin/build/tools/package.sh`

#### Arguments

- `group` - String. Required. Currently allowed: "python"

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

