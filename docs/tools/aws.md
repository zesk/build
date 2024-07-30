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



#### Usage

    awsInstall [ package ... ]
    

#### Arguments



#### Exit codes

- if `aptInstall` fails, the exit code is returned

#### Depends

    apt-get
    

### `awsCredentialsFile` - Get the path to the AWS credentials file

Get the credentials file path, optionally outputting errors

Pass a true-ish value to output warnings to stderr on failure

Pass any value to output warnings if the environment or file is not found; otherwise
output the credentials file path.

If not found, returns with exit code 1.



#### Usage

     awsCredentialsFile [ verboseFlag ]
    

#### Examples

    if ! awsCredentialsFile 1 >/dev/null; then
    consoleError "No AWS credentials"
    exit 1
    fi
    file=$(awsCredentialsFile)

#### Exit codes

- `1` - If `$HOME` is not a directory or credentials file does not exist
- `0` - If credentials file is found and output to stdout

### `awsIsKeyUpToDate` - Test whether the AWS keys do not need to be updated

For security we gotta update our keys every 90 days

This value would be better encrypted and tied to the AWS_ACCESS_KEY_ID so developers
can not just update the value to avoid the security issue.

This tool checks the environment `AWS_ACCESS_KEY_DATE` and ensures it's within `upToDateDays` of today; if not this fails.

It will also fail if:

- `upToDateDays` is less than zero or greater than 366
- `AWS_ACCESS_KEY_DATE` is empty or has an invalid value

Otherwise, the tool *may* output a message to the console warning of pending days, and returns exit code 0 if the `AWS_ACCESS_KEY_DATE` has not exceeded the number of days.

#### Usage

    awsIsKeyUpToDate upToDateDays
    

#### Examples

    if !awsIsKeyUpToDate 90; then
        bigText Failed, update key and reset date
        exit 99
    fi

#### Exit codes

- `0` - Always succeeds

#### Environment

AWS_ACCESS_KEY_DATE - Read-only. Date. A `YYYY-MM-DD` formatted date which represents the date that the key was generated.

### `awsHasEnvironment` - Test whether the AWS environment variables are set or not

This tests `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` and if both are non-empty, returns exit code 0 (success), otherwise returns exit code 1.
Fails if either AWS_ACCESS_KEY_ID or AWS_SECRET_ACCESS_KEY is blank

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

### `awsEnvironment` - Get credentials and output environment variables for AWS authentication

Load the credentials supplied from the AWS credentials file and output shell commands to set the appropriate `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` values.

If the AWS credentials file is not found, returns exit code 1 and outputs nothing.
If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.

#### Usage

    awsEnvironment profileName
    

#### Arguments



#### Examples

    setFile=$(mktemp)
    if awsEnvironment "$profile" > "$setFile"; then
    eval $(cat "$setFile")
    rm "$setFile"
    else
    consoleError "Need $profile profile in aws credentials file"`
    exit 1
    fi

#### Exit codes

- `0` - Always succeeds

### `awsIPAccess` - Grant access to AWS security group for this IP only using Amazon IAM credentials

Register current IP address in listed security groups to allow for access to deployment systems from a specific IP.
Use this during deployment to grant temporary access to your systems during deployment only.
Build scripts should have a $(consoleCode --revoke) step afterward, always.
services are looked up in /etc/services and match /tcp services only for port selection

#### Usage

    awsIPAccess --services service0,service1,... [ --profile awsProfile ] [ --id developerId ] [ --group securityGroup ] [ --ip ip ] [ --revoke ] [ --debug ] [ --help ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Environment

AWS_REGION - Where to update the security group
DEVELOPER_ID - Developer used to register rules in Amazon
AWS_ACCESS_KEY_ID - Amazon IAM ID
AWS_SECRET_ACCESS_KEY - Amazon IAM Secret

#### Usage

    awsSecurityGroupIPModify --add --group group [ --region region ] --port port --description description --ip ip
    awsSecurityGroupIPModify --remove --group group [ --region region ] --description description
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `awsSecurityGroupIPRegister` - Usage:

Usage:

#### Exit codes

- `0` - Always succeeds

#### Usage

    awsValidRegion region
    

#### Arguments



#### Exit codes

- `0` - Region is a valid AWS region
- `1` - Region is NOT a valid AWS region
