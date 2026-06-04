### `throwEnvironment`

> Run `handler` with an environment error

#### Usage

    throwEnvironment handler [ message ... ]

Run `handler` with an environment error

> Location: `bin/build/tools/_sugar.sh`

#### Arguments

- `handler` - Function. Required. Error handler.
- `message ...` - String. Optional. Error message

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- {SEE:isFunction}
- {SEE:returnArgument}
- {SEE:decorate}
- {SEE:debuggingStack}

