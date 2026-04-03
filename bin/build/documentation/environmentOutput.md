## `environmentOutput`

> Output all exported environment variables, hiding secure ones and ones

### Usage

    environmentOutput [ --underscore ] [ --skip-prefix prefixString ] [ --secure ] [ variable ... ]

Output all exported environment variables, hiding secure ones and ones prefixed with underscore.
Any values which contain a newline are also skipped.

### Arguments

- `--underscore` - Flag. Optional. Include environment variables which begin with underscore `_`.
- `--skip-prefix prefixString` - String. Optional. Skip environment variables which begin with this exact prefix (case-sensitive).
- `--secure` - Flag. Optional. Include environment variables which are in `environmentSecureVariables`
- `variable ...` - String. Optional. Output these variables explicitly.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

throwArgument decorate environmentSecureVariables grepSafe env textRemoveFields

