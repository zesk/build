## `timingDuration`

> Output timing like "1 day, 2 hours, 3 minutes, 4

### Usage

    timingDuration [ duration ] [ --stop unit ] [ --help ] [ --handler handler ]

Output timing like "1 day, 2 hours, 3 minutes, 4 seconds, 5 ms"

### Arguments

- `duration` - UnsignedInteger. Optional. Timing to output
- `--stop unit` - String. Optional. Stop computation and display at this unit.
- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

