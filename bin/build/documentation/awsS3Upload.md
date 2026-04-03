## `awsS3Upload`

> Upload a set of files or directories to S3.

### Usage

    awsS3Upload [ --help ] [ --handler handler ] --target target item [ --profile profileName ]

Upload a set of files or directories to S3.
Creates a `manifest.json` file at target with structure:
- hostname - host name which sent results
- created - Milliseconds creation time
- createdString - Milliseconds creation time in current locale language
- arguments - arguments to this function
Creates a `files.json` with a list of files as well at target

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--target target` - Required. S3 URL. S3 URL to upload to (with path)
- `item` - Required. A file or directory to upload to S3. All files and directories are uploaded as the same name in the top-level directory target.
- `--profile profileName` - String. Optional. S3 Profile to use when using S3

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

