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

#### Reads standard input

{stdin}

#### Writes to standard output

{stdout}

#### Writes to standard error

{stderr}

#### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

{build_debug}

#### Examples

{example}

#### Sample Output

{output}

#### Return codes

- `0` - if value is a boolean
- `1` - if value is not a boolean

#### Local cache

{local_cache}

#### Environment

{environment}

#### Requires



#### See Also

- [isTrue]({rel}tools/type.md#istrue) - True-ish ([source](https://github.com/zesk/build/blob/main/bin/build/tools/type.sh#L72))[booleanParse]({rel}tools/text.md#booleanparse) - Parses text and determines if it's true-ish ([source](https://github.com/zesk/build/blob/main/bin/build/tools/text.sh#L155))

#### Credits

Thanks to [{credits}]({source}).

#### Review Status

File `bin/build/tools/_sugar.sh`, function `isBoolean` was reviewed {reviewed}.

#### Errors

{error}
