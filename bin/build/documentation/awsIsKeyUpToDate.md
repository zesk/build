## `awsIsKeyUpToDate`

> Test whether the AWS keys do not need to be updated

### Usage

    awsIsKeyUpToDate [ upToDateDays ]

For security we gotta update our keys every 90 days
This value would be better encrypted and tied to the AWS_ACCESS_KEY_ID so developers
can not just update the value to avoid the security issue.
This tool checks the environment `AWS_ACCESS_KEY_DATE` and ensures it's within `upToDateDays` of today; if not this fails.
It will also fail if:
- `upToDateDays` is less than zero or greater than 366
- `AWS_ACCESS_KEY_DATE` is empty or has an invalid value
Otherwise, the tool *may* output a message to the console warning of pending days, and returns exit code 0 if the `AWS_ACCESS_KEY_DATE` has not exceeded the number of days.

### Arguments

- `upToDateDays` - PositiveInteger.

### Examples

    if ! awsIsKeyUpToDate 90; then
        decorate big Failed, update key and reset date
        exit 99
    fi

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:AWS_ACCESS_KEY_DATE.sh} - Variable used to test
- {SEE:AWS_ACCESS_KEY_DATE.sh} - Read-only. Date. A `YYYY-MM-DD` formatted date which represents the date that the key was generated.

