## `interactiveCountdown`

> Display a message and count down display

### Usage

    interactiveCountdown [ --help ] [ --badge text ] [ --prefix prefix ] counter binary [ ... ]

Display a message and count down display

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--badge text` - String. Display this text as decorate at
- `--prefix prefix` - String.
- `counter` - Integer. Required. Count down from.
- `binary` - Callable. Required. Run this with any additional arguments when the countdown is completed.
- `...` - Arguments. Optional. Passed to binary.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

