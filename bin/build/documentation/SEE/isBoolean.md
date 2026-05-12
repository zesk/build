## `isBoolean`

> Boolean test

### Usage

    isBoolean [ --help ] [ value ]

Boolean test
If you want "true-ish" use `isTrue`.
Returns 0 if `value` is boolean `false` oHar `true`.
Is this a boolean? (`true` or `false`)

> Location: `bin/build/tools/_sugar.sh`

### Arguments

- `--help` - Flag. Optional. Display this help.
- `value` - String. Optional. Value to check if it is a boolean.

### Return codes

- `0` - if value is a boolean
- `1` - if value is not a boolean

### Requires

- {SEE:bashDocumentation}

### See Also

- ## `isTrue`

