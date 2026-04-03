## `executeCount`

> Run a binary count times

### Usage

    executeCount [ count ] [ binary ] [ args ... ]

Run a binary count times

### Arguments

- `count` - The number of times to run the binary
- `binary` - The binary to run
- `args ...` - Any arguments to pass to the binary each run

### Return codes

- `0` - success
- `2` - `count` is not an unsigned number
- `Any` - If `binary` fails, the exit code is returned

