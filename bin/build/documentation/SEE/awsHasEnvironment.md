## `awsHasEnvironment`

> Test whether the AWS environment variables are set or not

### Usage

    awsHasEnvironment [ --help ]

This tests `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` and if both are non-empty, returns exit code 0 (success), otherwise returns exit code 1.
Fails if either `AWS_ACCESS_KEY_ID` or `AWS_SECRET_ACCESS_KEY` is blank

> Location: `bin/build/tools/aws.sh`

### Arguments

- `--help` - Flag. Optional. Display this help.

### Examples

    if awsHasEnvironment; then
    ...
    fi

### Return codes

- `0` - If environment needs to be updated
- `1` - If the environment seems to be set already

