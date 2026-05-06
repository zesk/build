## `jsonPath`

> Generate `jq` paths

### Usage

    jsonPath [ path ]

Generate a path for a JSON structure for use in `jq` queries

Without arguments, displays help.

> Location: `bin/build/tools/json.sh`

### Arguments

- `path` - String. Output a json path separated by dots.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

