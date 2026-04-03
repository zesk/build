## `aptKeyRemove`

> Remove apt keys

### Usage

    aptKeyRemove keyName [ --skip ] [ --help ]

Remove apt keys

### Arguments

- `keyName` - String. Required. One or more key names to remove.
- `--skip` - Flag. Optional. a Do not do `apt-get update` afterwards to update the database.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `1` - if environment is awry
- `0` - Apt key was removed AOK

