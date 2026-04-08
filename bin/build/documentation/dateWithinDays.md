## `dateWithinDays`

> Is a date in the past beyond its expiration date?

### Usage

    dateWithinDays keyDate [ upToDateDays ] [ --name name ] [ --help ]

stdout: Two tokens on a single line:
This tool checks the `keyDate` and checks if it is within `days` of today; if not this fails.
It will also fail if:
- `keyDate` is empty or has an invalid value
- `upToDateDays` is less than zero

### Arguments

- `keyDate` - Date. Required. Formatted like `YYYY-MM-DD`. Truncated at 10 characters as well.
- `upToDateDays` - Integer. Optional. Days that key expires after `keyDate`. Default is 90.
- `--name name` - String. Optional. Name of the expiring item for error messages.
- `--help` - Flag. Optional. Display this help.

### Writes to standard output

- UnsignedInteger. Days until expiration.
- UnsignedInteger. Expiration timestamp.

### Examples

    if ! dateWithinDays "$AWS_ACCESS_KEY_DATE" 90; then
      decorate big Failed, update key and reset date
      exit 99
    fi

### Return codes

- `0` - The date has not expired.
- `1` - The date has expired.
- `2` - The date is incorrectly formatted.
- `2` - Argument error.

