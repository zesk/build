## `awsCredentialsRemove`

> Remove credentials from the AWS credentials file

### Usage

    awsCredentialsRemove [ --profile profileName ] [ --comments ] [ profileName ] [ --help ]

Remove credentials from the AWS credentials file
If the AWS credentials file is not found, succeeds.
You can supply the profile using the `--profile` or directly, but just one.

### Arguments

- `--profile profileName` - String. Optional. The credentials profile to remove.
- `--comments` - Flag. Optional. Write comments to the credentials file (in addition to updating the record).
- `profileName` - String. Optional. The credentials profile to remove.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

