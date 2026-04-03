## `incrementor`

> Set or increment a incrementor state based on a state

### Usage

    incrementor [ count ] [ variable ] [ --path cacheDirectory ] [ --reset ] [ --separator ] [ --line ]

Set or increment a incrementor state based on a state directory. If no numeric value is supplied the default is to increment the current value and output it.
New values are set to 0 by default so will output `1` upon first handler.
If no variable name is supplied it uses the default variable name `default`.
Variable names can contain alphanumeric characters, underscore, or dash.
The special count `?` is used to query variables directly by name without modifying them.
Passing `?` on the command line without any name arguments will output all incrementors active using the `--separator` and `--line` markers.
Sets `default` incrementor to 1 and outputs `1`
    incrementor 1
Increments the `kitty` counter and outputs `1` on first call and `n + 1` for each subsequent call.
    incrementor kitty
Sets `kitty` incrementor to 2 and outputs `2`
    incrementor 2 kitty
Dumps the current incrementors:
    incrementor ?
    default 1
    kitty 2
The default cache `--path` is placed within the `buildCacheDirectory`.

### Arguments

- `count` - Integer. Optional. Sets the value for any following named variables to this value.
- `variable` - String. Optional. Variable to change or increment.
- `--path cacheDirectory` - Directory. Optional. Use this directory path as the state directory.
- `--reset` - Flag. Optional. Reset all counters to zero.
- `--separator` - String. Optional. When dumping all variables use this as the separator between name and value. (Default is space: `"  "`)
- `--line` - String. Optional. When dumping all variables use this as the separator between values. (Default is newline: `$'\n'`)

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

