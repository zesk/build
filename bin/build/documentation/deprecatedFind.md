## `deprecatedFind`

> Find files which match a token or tokens

### Usage

    deprecatedFind findArgumentFunction search [ --path cannonPath ]

Find files which match a token or tokens

### Arguments

- `findArgumentFunction` - Function. Required. Find arguments (for `find`) for `textCannon`.
- `search` - String. Required. String to search for (one or more)
- `--path cannonPath` - Directory. Optional. Run `textCannon` operation starting in this directory.

### Return codes

- `0` - One of the search tokens was found in a file (which matches find arguments)
- `1` - Search tokens were not found in any file (which matches find arguments)

