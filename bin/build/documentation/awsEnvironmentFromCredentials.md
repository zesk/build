## `awsEnvironmentFromCredentials`

> Get credentials and output environment variables for AWS authentication

### Usage

    awsEnvironmentFromCredentials [ profileName ] [ --profile profileName ] [ --comments ] [ --help ]

Load the credentials supplied from the AWS credentials file and output shell commands to set the appropriate `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` values.
If the AWS credentials file is not found, returns exit code 1 and outputs nothing.
If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.
Both forms can be used, but the profile should be supplied once and only once.

### Arguments

- `profileName` - String. Optional. The credentials profile to load (default value is `default` and loads section identified by `[default]` in `~/.aws/credentials`)
- `--profile profileName` - String. Optional. The credentials profile to load (default value is `default` and loads section identified by `[default]` in `~/.aws/credentials`)
- `--comments` - Flag. Optional. Write comments to the credentials file (in addition to updating the record).
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

