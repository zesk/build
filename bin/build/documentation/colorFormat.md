## `colorFormat`

> Take r g b decimal values and convert them to

### Usage

    colorFormat [ format ] [ red ] [ green ] [ blue ] [ --help ]

Take r g b decimal values and convert them to hex color values
Takes arguments or stdin values in groups of 3.

### Arguments

- `format` - String. Optional. Formatting string.
- `red` - UnsignedInteger. Optional. Red component.
- `green` - UnsignedInteger. Optional. Blue component.
- `blue` - UnsignedInteger. Optional. Green component.
- `--help` - Flag. Optional. Display this help.

### Reads standard input

list:UnsignedInteger

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

