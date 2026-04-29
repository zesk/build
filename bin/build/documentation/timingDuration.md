## `timingDuration`

> Output timing like "1 day, 2 hours, 3 minutes, 4

### Usage

    timingDuration [ duration ] [ --help ] [ --handler handler ] [ --stop stopUnit ]

Output timing like "1 day, 2 hours, 3 minutes, 4 seconds, 5 ms"

### Arguments

- `duration` - UnsignedInteger. Optional. Timing to output
- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--stop stopUnit` - String. Optional. Stop displaying fractional output after this unit is displayed.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

