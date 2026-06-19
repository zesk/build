### `__dateFromTimestamp`

> Platform `dateFromTimestamp`

#### Usage

    __dateFromTimestamp value format [ isUTC ]

Platform-specific implementation of `dateFromTimestamp`.

> Location: `bin/build/tools/platform/Darwin.sh`

#### Arguments

- `value` - Integer. Required.
- `format` - String. Required.
- `isUTC` - Boolean. Optional. Defaults to `true`.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [`date`]({rel}guide/command.md#date)

