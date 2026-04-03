## `packageGroupWhich`

> Install a package group to have a binary installed

### Usage

    packageGroupWhich binary group

Install a package group to have a binary installed
Any unrecognized groups are installed using the name as-is.

### Arguments

- `binary` - String. Required. Binary which will exist in PATH after `group` is installed if it does not exist.
- `group` - String. Required. Package group.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

