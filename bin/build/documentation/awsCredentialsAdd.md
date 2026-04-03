## `awsCredentialsAdd`

> Write an AWS profile to the AWS credentials file

### Usage

    awsCredentialsAdd [ --profile profileName ] [ --force ] [ --comments ] [ --help ] [ key ] [ secret ]

Write the credentials to the AWS credentials file.
If the AWS credentials file is not found, it is created

### Arguments

- `--profile profileName` - String. Optional. The credentials profile to write (default value is `default`)
- `--force` - Flag. Optional. Write the credentials file even if the profile already exists
- `--comments` - Flag. Optional. Write comments to the credentials file (in addition to updating the record).
- `--help` - Flag. Optional. Display this help.
- `key` - The AWS_ACCESS_KEY_ID to write
- `secret` - The AWS_SECRET_ACCESS_KEY to write

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

