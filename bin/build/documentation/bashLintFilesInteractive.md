## `bashLintFilesInteractive`

> Run checks interactively until errors are all fixed.

### Usage

    bashLintFilesInteractive [ --exec binary ] [ --delay delaySeconds ] [ fileToCheck ... ]

Run checks interactively until errors are all fixed.

### Arguments

- `--exec binary` - Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names.
- `--delay delaySeconds` - Integer. Optional. Delay in seconds between checks in interactive mode.
- `fileToCheck ...` - File. Optional. Shell file to validate.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

