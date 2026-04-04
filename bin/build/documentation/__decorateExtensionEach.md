## `decorate each`

> Runs the following command on each subsequent argument for formatting

### Usage

    decorate each style [ -- ] [ --index ] [ --count ]

Runs the following command on each subsequent argument for formatting
Also supports formatting input lines instead (on the same line)

### Arguments

- `style` - CommaDelimitedList. Required. Style arguments passed directly to decorate for each item.
- `--` - Flag. Optional. Pass as the first argument after the style to avoid reading arguments from stdin.
- `--index` - Flag. Optional. Show the index of each item before with a colon. `0:first 1:second` etc.
- `--count` - Flag. Optional. Show the count of items in the list after the list is generated.

### Examples

    decorate each code -- "$@"

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

