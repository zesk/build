## `timingElapsed`

> Show elapsed time from a start time

### Usage

    timingElapsed timingOffset [ --help ]

Show elapsed time from a start time

### Arguments

- `timingOffset` - UnsignedInteger. Required. Offset in milliseconds from January 1, 1970.
- `--help` - Flag. Optional. Display this help.

### Writes to standard output

UnsignedInteger

### Examples

    init=$(timingStart)
    ...
    timingElapsed "$init"

### Sample Output

4232

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

