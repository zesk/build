## `buildCompletion`

> Completion for Zesk Build (EXPERIMENTAL)

### Usage

    buildCompletion [ --quiet ] [ --alias name ] [ --reload-alias name ] [ --help ]

Add completion handler for Zesk Build to Bash (EXPERIMENTAL)
This has the side effect of turning on the shell option `expand_aliases`

### Arguments

- `--quiet` - Flag. Optional. Do not output any messages to stdout.
- `--alias name` - String. Optional. The name of the alias to create.
- `--reload-alias name` - String. Optional. The name of the alias which reloads Zesk Build. (source)
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

