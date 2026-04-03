## `awsCredentialsHasProfile`

> Get credentials and output environment variables for AWS authentication

### Usage

    awsCredentialsHasProfile [ profileName ] [ --help ]

Extract a profile from a credentials file
If the AWS credentials file is not found, returns exit code 1 and outputs nothing.
If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.

### Arguments

- `profileName` - The credentials profile to load (default value is `default` and loads section identified by `[default]` in `~/.aws/credentials`)
- `--help` - Flag. Optional. Display this help.

### Examples

    setFile=$(fileTemporaryName "$handler") || return $?
    if awsEnvironment "$profile" > "$setFile"; then
    eval $(cat "$setFile")
    rm "$setFile"
    else
    decorate error "Need $profile profile in aws credentials file"`
    exit 1
    fi

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

