## `timingReport`

> Output the time elapsed

### Usage

    timingReport [ --color color ] [ --help ] [ --handler handler ] [ start ] [ message ]

Outputs the timing optionally prefixed by a message.
Outputs a nice colorful message showing the number of seconds elapsed as well as your custom message.

### Arguments

- `--color color` - Make text this color (default is `green`)
- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `start` - Unix timestamp milliseconds. See `timingStart`.
- `message` - Any additional arguments are output before the elapsed value computed

### Examples

    init=$(timingStart)
    ...
    timingReport "$init" "Deploy completed in"

### Return codes

- `0` - Exits with exit code zero

