### `helpArgument`

> Simple help argument handler.

#### Usage

    helpArgument [ --only ] handlerFunction [ arguments ... ]

Simple help argument handler.

Easy `--help` handler for any function useful when it's the only option.

Useful for utilities which single argument types, single arguments, and no arguments (except for `--help`)

Oddly one of the few functions we can not offer the `--help` flag for.
Without arguments, displays help.

Example:
Example:
Example:
Example:

> Location: `bin/build/tools/argument.sh`

#### Arguments

- `--only` - Flag. Optional. Must be first parameter. If calling function ONLY takes the `--help` parameter then throw an argument error if the argument is anything but `--help`.
- `handlerFunction` - Function. Required. Must be first or second parameter. If calling function ONLY takes the `--help` parameter then throw an argument error if the argument is anything but `--help`.
- `arguments ...` - Arguments. Optional. Arguments passed to calling function to check for `--help` argument.

#### Examples

    # NOT DEFINED handler
    helpArgument "_${FUNCNAME[0]}" "$@" || return 0
    [ "${1-}" != "--help" ] || helpArgument "_${FUNCNAME[0]}" "$@" || return 0
    [ $# -eq 0 ] || helpArgument --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
    # Argument 1 absolutely exists
    [ "${1-}" != "--help" ] || helpArgument "_${FUNCNAME[0]}" "$@" || return 0
    # DEFINED handler
    local handler="_${FUNCNAME[0]}"
    helpArgument "$handler" "$@" || return 0
    [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
    [ $# -eq 0 ] || helpArgument --only "$handler" "$@" || return "$(convertValue $? 1 0)"
    # Blank Arguments for help
    [ $# -gt 0 ] || helpArgument "_${FUNCNAME[0]}" --help || return 0
    [ $# -gt 0 ] || helpArgument "$handler" --help || return 0

#### Return codes

- `0` - Help was not found or displayed
- `1` - Help was found and displayed
- `2` - Argument error

#### Requires

- [throwArgument]({rel}tools/sugar-core.md#throwargument) - Run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L215))
- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))

