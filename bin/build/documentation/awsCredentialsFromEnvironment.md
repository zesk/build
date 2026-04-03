## `awsCredentialsFromEnvironment`

> Write an AWS profile to the AWS credentials file

### Usage

    awsCredentialsFromEnvironment [ --profile profileName ] [ --force ] [ --help ]

Write the credentials to the AWS credentials file.
If the AWS credentials file is not found, returns exit code 1 and outputs nothing.
If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.

### Arguments

- `--profile profileName` - String. Optional. The credentials profile to write (default value is `default`)
- `--force` - Flag. Optional. Write the credentials file even if the profile already exists
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

