## `timing`

> Time command, similar to `time` but uses internal functions

### Usage

    timing command [ --help ] [ --name ] [ --slow slowMilliseconds ] [ --fast fastMilliseconds ]

Time command, similar to `time` but uses internal functions
Outputs time as `timingReport`

> Location: `bin/build/tools/timing.sh`

### Arguments

- `command` - Executable. Required. Command to run.
- `--help` - Flag. Optional. Display this help.
- `--name` - String. Optional. Display this help.
- `--slow slowMilliseconds` - UnsignedInteger. Optional. Display output if the underlying commend takes is slower (longer) than this threshold.
- `--fast fastMilliseconds` - UnsignedInteger. Optional. Display output if the underlying commend runs is faster (shorter) than this threshold.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

