# AWS Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

       ▄▄    ▄▄      ▄▄   ▄▄▄▄
      ████   ██      ██ ▄█▀▀▀▀█
      ████   ▀█▄ ██ ▄█▀ ██▄
     ██  ██   ██ ██ ██   ▀████▄
     ██████   ███▀▀███       ▀██
    ▄██  ██▄  ███  ███  █▄▄▄▄▄█▀
    ▀▀    ▀▀  ▀▀▀  ▀▀▀   ▀▀▀▀▀

AWS stands for Amazon Web Services and tools related to interacting with the `aws` binary.

### `awsInstall` - aws Command-Line install

aws Command-Line install

Installs x86 or aarch64 binary based on `$HOSTTYPE`.



- Location: `bin/build/tools/aws.sh`

#### Usage

    awsInstall [ package ... ]
    

#### Arguments

- `package` - One or more packages to install using `apt-get` prior to installing AWS

#### Exit codes

- if `packageInstall` fails, the exit code is returned

#### Depends

    apt-get
    
### `awsIsKeyUpToDate` - Test whether the AWS keys do not need to be updated

For security we gotta update our keys every 90 days

This value would be better encrypted and tied to the AWS_ACCESS_KEY_ID so developers
can not just update the value to avoid the security issue.

This tool checks the environment `AWS_ACCESS_KEY_DATE` and ensures it's within `upToDateDays` of today; if not this fails.

It will also fail if:

- `upToDateDays` is less than zero or greater than 366
- `AWS_ACCESS_KEY_DATE` is empty or has an invalid value

Otherwise, the tool *may* output a message to the console warning of pending days, and returns exit code 0 if the `AWS_ACCESS_KEY_DATE` has not exceeded the number of days.

- Location: `bin/build/tools/aws.sh`

#### Arguments

- No arguments.

#### Examples

    if ! awsIsKeyUpToDate 90; then
        bigText Failed, update key and reset date
        exit 99
    fi

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

AWS_ACCESS_KEY_DATE - Read-only. Date. A `YYYY-MM-DD` formatted date which represents the date that the key was generated.
### `awsHasEnvironment` - Test whether the AWS environment variables are set or not

This tests `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` and if both are non-empty, returns exit code 0 (success), otherwise returns exit code 1.
Fails if either `AWS_ACCESS_KEY_ID` or `AWS_SECRET_ACCESS_KEY` is blank

- Location: `bin/build/tools/aws.sh`

#### Arguments

- No arguments.

#### Examples

    if awsHasEnvironment; then
    ...
    fi

#### Exit codes

- `0` - If environment needs to be updated
- `1` - If the environment seems to be set already

#### Environment

AWS_ACCESS_KEY_ID - Read-only. If blank, this function succeeds (environment needs to be updated)
AWS_SECRET_ACCESS_KEY - Read-only. If blank, this function succeeds (environment needs to be updated)
### `awsIPAccess` - Grant access to AWS security group for this IP only using Amazon IAM credentials

Register current IP address in listed security groups to allow for access to deployment systems from a specific IP.
Use this during deployment to grant temporary access to your systems during deployment only.
Build scripts should have a $(decorate code --revoke) step afterward, always.
services are looked up in /etc/services and match /tcp services only for port selection

- Location: `bin/build/tools/aws.sh`

#### Arguments

- `--profile profileName` - String. Optional. Use this AWS profile when connecting using ~/.aws/credentials
--services service0,service1,- `...` - List. Required. List of services to add or remove (service names or port numbers)
- `--id developerId` - String. Optional. Specify an developer id manually (uses DEVELOPER_ID from environment by default)
- `--group securityGroup` - String. Required. String. Specify one or more security groups to modify. Format: `sg-` followed by hexadecimal characters.
- `--ip ip` - Optional. IP. Specify bn IP manually (uses ipLookup tool from tools.sh by default)
- `--revoke` - Flag. Optional. Remove permissions
- `--help` - Flag. Optional. Show this help

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

AWS_REGION - Where to update the security group
DEVELOPER_ID - Developer used to register rules in Amazon
AWS_ACCESS_KEY_ID - Amazon IAM ID
AWS_SECRET_ACCESS_KEY - Amazon IAM Secret
### `awsSecurityGroupIPModify` - undocumented

No documentation for `awsSecurityGroupIPModify`.

- Location: `bin/build/tools/aws.sh`

#### Arguments

- `--remove - Optional. Flag. Remove instead of add` - only `group`, and `description` required.
- `--add` - Optional. Flag. Add to security group (default).
- `--register` - Optional. Flag. Add it if not already added.
- `--group group` - Required. String. Security Group ID
- `--region region` - Optional. String. AWS region, defaults to `AWS_REGION`. Must be supplied.
- `--port port` - Required for `--add` only. Integer. service port
- `--description description` - Required. String. Description to identify this record.
- `--ip ip` - Required for `--add` only. String. IP Address to add or remove.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `awsRegionValid` - undocumented

No documentation for `awsRegionValid`.

- Location: `bin/build/tools/aws.sh`

#### Arguments

- `region ...` - String. Required. The AWS Region to validate.

#### Exit codes

- `0` - All regions are valid AWS region
- `1` - One or more regions are NOT a valid AWS region
### `awsProfilesList` - List AWS profiles available in the credentials file

List AWS profiles available in the credentials file

- Location: `bin/build/tools/aws.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `awsCredentialsFile` - Get the path to the AWS credentials file

Get the credentials file path, optionally outputting errors

Pass a true-ish value to output warnings to stderr on failure

Pass any value to output warnings if the environment or file is not found; otherwise
output the credentials file path.

If not found, returns with exit code 1.



- Location: `bin/build/tools/aws.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--verbose` - Flag. Optional. Verbose mode
- `--create` - Optional. Flag. Create the directory and file if it does not exist
- `--home homeDirectory` - Optional. Directory. Home directory to use instead of `$HOME`.

#### Examples

    credentials=$(awsCredentialsFile) || __failEnvironment "$usage" "No credentials file found" || return $?

#### Exit codes

- `1` - If `$HOME` is not a directory or credentials file does not exist
- `0` - If credentials file is found and output to stdout
### `awsCredentialsAdd` - Write an AWS profile to the AWS credentials file

Write the credentials to the AWS credentials file.

If the AWS credentials file is not found, it is created

- Location: `bin/build/tools/aws.sh`

#### Arguments

- `--profile profileName` - String. Optional. The credentials profile to write (default value is `default`)
- `--force` - Flag. Optional. Write the credentials file even if the profile already exists
- `id` - The AWS_ACCESS_KEY_ID to write
- `key` - The AWS_SECRET_ACCESS_KEY to write

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `awsCredentialsRemove` - Remove credentials from the AWS credentials file

Remove credentials from the AWS credentials file

If the AWS credentials file is not found, succeeds.

- Location: `bin/build/tools/aws.sh`

#### Arguments

- `--profile profileName` - String. Optional. The credentials profile to write (default value is `default`)

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `awsEnvironmentFromCredentials` - Get credentials and output environment variables for AWS authentication

Load the credentials supplied from the AWS credentials file and output shell commands to set the appropriate `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` values.

If the AWS credentials file is not found, returns exit code 1 and outputs nothing.
If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.

Both forms can be used, but the profile should be supplied once and only once.

- Location: `bin/build/tools/aws.sh`

#### Arguments

- `profileName` - String. Optional. The credentials profile to load (default value is `default` and loads section identified by `[default]` in `~/.aws/credentials`)
- `--profile profileName` - String. Optional. The credentials profile to load (default value is `default` and loads section identified by `[default]` in `~/.aws/credentials`)

#### Examples

    setFile=$(mktemp)
    if awsEnvironment "$profile" > "$setFile"; then
    eval $(cat "$setFile")
    rm "$setFile"
    else
    decorate error "Need $profile profile in aws credentials file"`
    exit 1
    fi

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `awsCredentialsFromEnvironment` - Write an AWS profile to the AWS credentials file

Write the credentials to the AWS credentials file.

If the AWS credentials file is not found, returns exit code 1 and outputs nothing.
If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.

- Location: `bin/build/tools/aws.sh`

#### Arguments

- `--profile profileName` - String. Optional. The credentials profile to write (default value is `default`)
- `--force` - Flag. Optional. Write the credentials file even if the profile already exists

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `awsCredentialsHasProfile` - Get credentials and output environment variables for AWS authentication

Extract a profile from a credentials file

If the AWS credentials file is not found, returns exit code 1 and outputs nothing.
If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.

- Location: `bin/build/tools/aws.sh`

#### Usage

    awsEnvironment profileName
    

#### Arguments

- `profileName` - The credentials profile to load (default value is `default` and loads section identified by `[default]` in `~/.aws/credentials`)

#### Examples

    setFile=$(mktemp)
    if awsEnvironment "$profile" > "$setFile"; then
    eval $(cat "$setFile")
    rm "$setFile"
    else
    decorate error "Need $profile profile in aws credentials file"`
    exit 1
    fi

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
