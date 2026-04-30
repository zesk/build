## `consoleHeadingBoxed`

> Text heading decoration

### Usage

    consoleHeadingBoxed [ --outside outsideStyle ] [ --inside insideStyle ] [ --shrink characterCount ] [ --size lineCount ] [ text ... ] [ --help ]

Heading for section output

### Arguments

- `--outside outsideStyle` - String. Optional. Style to apply to the outside border. (Default `decoration`)
- `--inside insideStyle` - String. Optional. Style to apply to the inside spacing. (Default blank)
- `--shrink characterCount` - UnsignedInteger. Optional. Reduce the box by this many characters wide. (Default 0)
- `--size lineCount` - UnsignedInteger. Optional. Print this many blank lines between the header and title. (Default 1)
- `text ...` - Text to put in the box
- `--help` - Flag. Optional. Display this help.

### Examples

    consoleHeadingBoxed Moving ...

### Sample Output

    +==========================================================================+
    |                                                                          |
    | Moving ...                                                               |
    |                                                                          |
    +==========================================================================+

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

