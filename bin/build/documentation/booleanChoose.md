### `booleanChoose`

> Boolean selector

#### Usage

    booleanChoose testValue [ trueChoice ] [ falseChoice ]

Boolean selector

> Location: `bin/build/tools/_sugar.sh`

#### Arguments

- `testValue` - Boolean. Required. Test value
- `trueChoice` - EmptyString. Optional. Value to output when testValue is `true`
- `falseChoice` - EmptyString. Optional. Value to output when testValue is `false`

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- {SEE:isBoolean}
- {SEE:returnArgument}
- [`printf`]({rel}guide/builtin.md#printf)

