## `booleanChoose`

> Boolean selector

### Usage

    booleanChoose testValue [ trueChoice ] [ falseChoice ]

Boolean selector

### Arguments

- `testValue` - Boolean. Required. Test value
- `trueChoice` - EmptyString. Optional. Value to output when testValue is `true`
- `falseChoice` - EmptyString. Optional. Value to output when testValue is `false`

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

isBoolean returnArgument printf

