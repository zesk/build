## `deprecatedCannon`

> undocumented

### Usage

    deprecatedCannon [ --path cannonPath ] findArgumentFunction search replace [ extraCannonArguments ]

No documentation for `deprecatedCannon`.

### Arguments

- `--path cannonPath` - Directory. Optional. Run cannon operation starting in this directory.
- `findArgumentFunction` - Function. Required. Find arguments (for `find`) for cannon.
- `search` - String. Required. String to search for
- `replace` - EmptyString. Required. Replacement string.
- `extraCannonArguments` - Arguments. Optional. Any additional arguments are passed to `cannon`.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

