## `mapValue`

> Maps a string using an environment file

### Usage

    mapValue [ --help ] [ --handler handler ] mapFile [ value ] [ --prefix ] [ --suffix ] [ --search-filter ] [ --replace-filter ]

Maps a string using an environment file

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `mapFile` - File. Required. a file containing bash environment definitions
- `value` - String. Optional. One or more values to map using said environment file
- `--prefix` - String. Optional. Token prefix defaults to `{`.
- `--suffix` - String. Optional. Token suffix defaults to `}`.
- `--search-filter` - Zero or more. Callable. Filter for search tokens. (e.g. `stringLowercase`)
- `--replace-filter` - Zero or more. Callable. Filter for replacement strings. (e.g. `textTrim`)

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

