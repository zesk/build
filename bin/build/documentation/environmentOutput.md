### `environmentOutput`

> Output all exported environment variables, hiding secure ones and ones

#### Usage

    environmentOutput [ --underscore ] [ --skip-prefix prefixString ] [ --secure ] [ variable ... ]

Output all exported environment variables, hiding secure ones and ones prefixed with underscore.
Any values which contain a newline are also skipped.

> Location: `bin/build/tools/environment.sh`

#### Arguments

- `--underscore` - Flag. Optional. Include environment variables which begin with underscore `_`.
- `--skip-prefix prefixString` - String. Optional. Skip environment variables which begin with this exact prefix (case-sensitive).
- `--secure` - Flag. Optional. Include environment variables which are in `environmentSecureVariables`
- `variable ...` - String. Optional. Output these variables explicitly.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [throwArgument]({rel}tools/sugar-core.md#throwargument) - Run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L215))
- [decorate]({rel}tools/decorate.md#decorate) - decorate text using colors and styles ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L144))
- [environmentSecureVariables]({rel}tools/environment.md#environmentsecurevariables) - List environment variables related to security ([source](https://github.com/zesk/build/blob/main/bin/build/tools/environment.sh#L45))
- [grepSafe]({rel}tools/text.md#grepsafe) - \`grep\` but returns 0 when nothing matches ([source](https://github.com/zesk/build/blob/main/bin/build/tools/text.sh#L75))
- [`env`]({rel}guide/command.md#env)
- [textRemoveFields]({rel}tools/text.md#textremovefields) - Remove fields from left to right from a text file ([source](https://github.com/zesk/build/blob/main/bin/build/tools/text.sh#L1104))

#### See Also

- [environmentSecureVariables]({rel}tools/environment.md#environmentsecurevariables) - List environment variables related to security ([source](https://github.com/zesk/build/blob/main/bin/build/tools/environment.sh#L45))

