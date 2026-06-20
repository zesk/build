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

- {SEE:throwArgument}
- [decorate]({rel}tools/decorate.md#decorate) - decorate text using colors and styles ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L144))
- {SEE:environmentSecureVariables}
- {SEE:grepSafe}
- [`env`]({rel}guide/command.md#env)
- {SEE:textRemoveFields}

#### See Also

- {SEE:environmentSecureVariables}

