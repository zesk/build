# AWS Functions

       ▄▄    ▄▄      ▄▄   ▄▄▄▄
      ████   ██      ██ ▄█▀▀▀▀█
      ████   ▀█▄ ██ ▄█▀ ██▄
     ██  ██   ██ ██ ██   ▀████▄
     ██████   ███▀▀███       ▀██
    ▄██  ██▄  ███  ███  █▄▄▄▄▄█▀
    ▀▀    ▀▀  ▀▀▀  ▀▀▀   ▀▀▀▀▀

## `awsCredentialsFile` - Get the path to the AWS credentials file

Usage:

    awsCredentialsFile [ verboseFlag ]

Pass any value to output warnings if the environment or file is not found; otherwise output the credentials file path.

If not found, returns with exit code 1.

Examples:

    if ! awsCredentialsFile 1 >/dev/null; then
        consoleError "No AWS credentials"
        exit 1
    fi
    file=$(awsCredentialsFile)

## `isAWSKeyUpToDate` - Test whether the AWS keys do not need to be updated

Usage:

    isAWSKeyUpToDate upToDateDays

This tool checks the environment `AWS_ACCESS_KEY_DATE` and ensures it's within `upToDateDays` of today; if not this fails.

It will also fail if:

- `upToDateDays` is less than zero or greater than 366
- `AWS_ACCESS_KEY_DATE` is empty or has an invalid value

Otherwise, the tool *may* output a message to the console warning of pending days, and returns exit code 0 if the `AWS_ACCESS_KEY_DATE` has not exceeded the number of days.

Examples:

    if !isAWSKeyUpToDate 90; then
        bigText Failed, update key and reset date
        exit 99
    fi
### Environment:

- `AWS_ACCESS_KEY_DATE` - Read-only. Date. A `YYYY-MM-DD` formatted date which represents the date that the key was generated.

## `needAWSEnvironment` - Test whether the AWS environment variables are set or not

This tests `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` and if either is empty, returns exit code 0 (success), otherwise returns exit code 1.

Usage:

    needAWSEnvironment

Examples:

    if needAWSEnvironment; then
        ...
    fi

### Environment:

- `AWS_ACCESS_KEY_ID` - Read-only.
- `AWS_SECRET_ACCESS_KEY` - Read-only.

## `awsEnvironment`

Load the credentials supplied from the AWS credentials file and output shell commands to set the appropriate `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` values.

If the AWS credentials file is not found, returns exit code 1 and outputs nothing.
If the AWS credentials file is incomplete, returns exit code 1 and outputs nothing.

Usage:

    awsEnvironment profileName

Arguments:

- `profileName` - The credentials profile to load (default value is `default`  and loads section identified by `[default]` in `~/.aws/credentials`)

Examples:
    setFile=$(mktemp)
    if awsEnvironment "$profile" > "$setFile"; then
        eval $(cat "$setFile")
        rm "$setFile"
    else
        consoleError "Need $profile profile in aws credentials file"
        exit 1
    fi

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)