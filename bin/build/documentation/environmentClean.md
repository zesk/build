## `environmentClean`

> Clean *most* exported variables from the current context except a

### Usage

    environmentClean [ keepEnvironment ]

Clean *most* exported variables from the current context except a few important ones:
- CI PATH LD_LIBRARY USER HOME PS1 PS2 PS3 PS4 BUILD_HOME
- __BUILD_DECORATE BUILD_COLORS BUILD_DEBUG BUILD_HOOK_DIRS __BUILD_LOADER
Calls unset on any variable in the global environment and exported.
Use with caution. Any additional environment variables you wish to preserve, simply pass those on the command line

### Arguments

- `keepEnvironment` - EnvironmentVariable. Optional. Keep this environment variable. ZeroOrMore.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

