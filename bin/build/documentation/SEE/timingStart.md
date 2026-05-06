## `timingStart`

> Start a timer

### Usage

    timingStart [ --help ]

Outputs the offset in milliseconds from midnight UTC January 1, 1970.

Only fails if `date` is not installed

> Location: `bin/build/tools/timing.sh`

### Arguments

- `--help` - Flag. Optional. Display this help.

### Writes to standard output

UnsignedInteger

### Examples

    init=$(timingStart)
    ...
    timingReport "$init" "Completed in"
    start=$(timingStart) && printf "%d\n" "$start"
    1777501474602

### Sample Output

1777501474602

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

- __timestamp,
- {SEE:returnEnvironment}
- date

