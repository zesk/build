### `isBoolean`

> Boolean test

#### Usage

    isBoolean [ --help ] [ value ]

Boolean test
If you want "true-ish" use `isTrue`.
Returns 0 if `value` is boolean `false` oHar `true`.
Is this a boolean? (`true` or `false`)

> Location: `bin/build/tools/_sugar.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `value` - String. Optional. Value to check if it is a boolean.

#### Return codes

- `0` - if value is a boolean
- `1` - if value is not a boolean

#### Requires

- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))

#### See Also

- {SEE:isTrue}
- [booleanParse]({rel}tools/text.md#booleanparse) - Parses text and determines if it's true-ish ([source](https://github.com/zesk/build/blob/main/bin/build/tools/text.sh#L155))

