# map Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />


#### Arguments

- `environmentName` - Optional. String. Map this value only. If not specified, all environment variables are mapped.
- `--prefix` - Optional. String. Prefix character for tokens, defaults to `{`.
- `--suffix` - Optional. String. Suffix character for tokens, defaults to `}`.
- `--help` - Optional. Flag. Display this help.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

Argument-passed or entire environment variables which are exported are used and mapped to the destination.
### `mapValue` - Maps a string using an environment file

Maps a string using an environment file

- Location: `bin/build/tools/map.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `mapFile` - Required. File. a file containing bash environment definitions
- `value` - Optional. String. One or more values to map using said environment file
- `--prefix` - Optional. String. Token prefix defaults to `{`.
- `--suffix` - Optional. String. Token suffix defaults to `}`.
- `--search-filter` - Zero or more. Callable. Filter for search tokens. (e.g. `lowercase`)
- `--replace-filter` - Zero or more. Callable. Filter for replacement strings. (e.g. `trimSpace`)

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `mapValueTrim` - Maps a string using an environment file

Maps a string using an environment file

- Location: `bin/build/tools/map.sh`

#### Arguments

- `mapFile` - Required. File. a file containing bash environment definitions
- `value` - Optional. String. One or more values to map using said environment file.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `isMappable` - Check if text contains mappable tokens

Check if text contains mappable tokens
If any text passed contains a token which can be mapped, succeed.

- Location: `bin/build/tools/text.sh`

#### Arguments

- `--prefix` - Optional. String. Token prefix defaults to `{`.
- `--suffix` - Optional. String. Token suffix defaults to `}`.
- `--token` - Optional. String. Classes permitted in a token
- `text` - Optional. String. Text to search for mapping tokens.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `mapTokens` - undocumented

No documentation for `mapTokens`.

- Location: `bin/build/tools/map.sh`

#### Arguments

- `prefix` - Optional prefix for token search, defaults to `{` (same as `map.sh`)
- `suffix` - Optional suffix for token search, defaults to `}` (same as `map.sh`)

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Local cache

None.

#### Environment

None.

#### Depends

    sed quoteSedPattern
    
