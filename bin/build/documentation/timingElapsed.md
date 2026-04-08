## `timingElapsed`

> Show elapsed time from a start time

### Usage

    timingElapsed timingOffset [ --help ]

Show elapsed time from a start time

### Arguments

- `timingOffset` - UnsignedInteger. Required. Offset in milliseconds from January 1, 1970.
- `--help` - Flag. Optional. Display this help.

### Examples

    init=$(timingStart)
    ...
    timingElapsed "$init"

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

