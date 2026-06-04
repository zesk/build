### `pause`

> Pause for user input

#### Usage

    pause [ --help ] [ -- ] [ message ... ]

Pause for user input

> Location: `bin/build/tools/interactive.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `--` - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.
- `message ...` - Display this message while pausing

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

