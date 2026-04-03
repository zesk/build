## `notify`

> Notify after running a binary. Uses the `notify` hook with

### Usage

    notify [ --help ] [ --handler handler ] [ --verbose ] [ --title title ] [ --message message ] [ --fail failMessage ] [ --sound soundName ] [ --fail-title title ] [ --fail-sound soundName ]

Notify after running a binary. Uses the `notify` hook with some handy parameters which are inherited
between "success" and "failure":
If a value is not specified for failure, it will use the `success` value.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--verbose` - Flag. Optional. Be verbose.
- `--title title` - String. Optional. Sets the title for the notification.
- `--message message` - String. Optional. Display this message (alias is `-m`)
- `--fail failMessage` - String. Optional. Display this message in console and dialog upon failure.
- `--sound soundName` - String. Optional. Sets the sound played for the notification.
- `--fail-title title` - String. Optional. Sets the title for the notification if the binary fails.
- `--fail-sound soundName` - String. Optional. Sets the sound played for the notification if the binary fails.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

