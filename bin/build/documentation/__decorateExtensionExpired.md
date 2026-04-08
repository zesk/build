## `decorate expired`

> Utility to display key expiration
Test whether the key needs to be updated

### Usage

    decorate expired keyDate upToDateDays [ --name name ] [ --help ]

For security one should update keys every ... number of days.
f.k.a. `is``UpToDate`
This value would be better encrypted and tied to the key itself so developers
can not just update the value to avoid the security issue.
This tool checks the value and checks if it is `upToDateDays` of today; if not this fails.
It will also fail if:
- `upToDateDays` is less than zero or greater than 366
- `keyDate` is empty or has an invalid value
Otherwise, the tool *may* output a message to the console warning of pending days, and returns exit code 0 if the `keyDate` has not exceeded the number of days.
Outputs a big text message as it gets closer.

### Arguments

- `keyDate` - Date. Required. Formatted like `YYYY-MM-DD`. Truncated at 10 characters as well.
- `upToDateDays` - Integer. Required. Days that key expires after `keyDate`.
- `--name name` - String. Optional. Name of the expiring item for error messages.
- `--help` - Flag. Optional. Display this help.

### Examples

    if !decorate expired "$AWS_ACCESS_KEY_DATE" 90; then
      decorate big Failed, update key and reset date
      exit 99
    fi

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

