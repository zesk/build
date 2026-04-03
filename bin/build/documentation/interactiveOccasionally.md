## `interactiveOccasionally`

> Do something the first time and then only occasionally thereafter.

### Usage

    interactiveOccasionally [ --delta deltaMilliseconds ] [ --mark ] [ --verbose ] name

Do something the first time and then only occasionally thereafter.
This manages a state file compared to the current time and triggers after `delta` seconds.
Think of it like something that only returns 0 like once every `delta` seconds but it's going to happen at minimum `delta` seconds, or the next time after that. And the first time as well.

### Arguments

- `--delta deltaMilliseconds` - PositiveInteger. Optional. Default is 60000.
- `--mark` - Flag. Optional. Write the marker which says the
- `--verbose` - Flag. Optional. Be chatty.
- `name` - EnvironmentVariable. Required. The global codename for this interaction.

### Return codes

- `0` - Do the thing
- `1` - Do not do the thing
- `2` - Argument error

