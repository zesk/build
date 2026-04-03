## `timingStart`

> Start a timer

### Usage

    timingStart [ --help ]

Outputs the offset in milliseconds from January 1, 1970.
Should never fail, unless date is not installed

### Arguments

- `--help` - Flag. Optional. Display this help.

### Examples

    init=$(timingStart)
    ...
    timingReport "$init" "Completed in"

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

__timestamp, returnEnvironment date

