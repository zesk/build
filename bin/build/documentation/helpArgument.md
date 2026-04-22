## `helpArgument`

> Simple help argument handler.

### Usage

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

### Arguments

- `--only` - Flag. Optional. Must be first parameter. If calling function ONLY takes the `--help` parameter then throw an argument error if the argument is anything but `--help`.
- `handlerFunction` - Function. Required. Must be first or second parameter. If calling function ONLY takes the `--help` parameter then throw an argument error if the argument is anything but `--help`.
- `arguments ...` - Arguments. Optional. Arguments passed to calling function to check for `--help` argument.

### Return codes

- `0` - Help was not found or displayed
- `1` - Help was found and displayed
- `2` - Argument error

