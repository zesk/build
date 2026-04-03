## `awsS3DirectoryDelete`

> Delete a directory remotely on S3

### Usage

    awsS3DirectoryDelete [ --help ] [ --handler handler ] [ --show ] url ...

Delete a directory remotely on S3

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--show` - Flag. Optional. Show what would change, do not change anything.
- `url ...` - URL. Required. AWS S3 URL to delete

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

