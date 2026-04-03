## `interactiveManager`

> Run checks interactively until errors are all fixed.

### Usage

    interactiveManager loopCallable [ --exec binary ] [ --delay delaySeconds ] [ fileToCheck ... ]

Run checks interactively until errors are all fixed.
Not ready for prime time yet - written not tested.

### Arguments

- `loopCallable` - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails.
- `--exec binary` - Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names.
- `--delay delaySeconds` - Integer. Optional. Delay in seconds between checks in interactive mode.
- `fileToCheck ...` - File. Optional. Shell file to validate. May also supply file names via stdin.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

