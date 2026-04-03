## `executeLoop`

> Run checks interactively until errors are all fixed.

### Usage

    executeLoop loopCallable [ --delay delaySeconds ] [ --until exitCode ] [ --title title ] [ arguments ... ]

Run checks interactively until errors are all fixed.

### Arguments

- `loopCallable` - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails.
- `--delay delaySeconds` - Integer. Optional. Delay in seconds between checks in interactive mode.
- `--until exitCode` - Integer. Optional. Check until exit code matches this.
- `--title title` - String. Optional. Display this title instead of the command.
- `arguments ...` - Optional. Arguments. Arguments to `loopCallable`

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

