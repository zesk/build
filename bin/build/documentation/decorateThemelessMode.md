### `decorateThemelessMode`

> Converts decoration style to a mode where the theme can

#### Usage

    decorateThemelessMode [ --end ] [ --help ]

Converts decoration style to a mode where the theme can be applied later to text which is formatted.
All decorate calls made after this call will output with special codes not to be displayed to the user.

> Location: `bin/build/tools/decorate/theme.sh`

#### Arguments

- `--end` - Flag. Optional. End themeless mode.
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- __BUILD_DECORATE

#### See Also

- [decorateThemed]({rel}tools/decoration.md#decoratethemed)- `` - Applies the current theme to text rendered using \`decorateThemelessMode\` ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/theme.sh#L70))

