## `decorate box`

> Box around content

### Usage

    decorate box [ --type (ascii|line|double-line) ] [ --outside outsideStyle ] [ --inside insideStyle ] [ --width characterCount ] [ --size lineCount ] [ --fill fileCharacter ] [ text ... ] [ --help ]

Box around content

### Arguments

--type (ascii|line|double-line)- `` - String. Optional. Line style. Default `line`
- `--outside outsideStyle` - String. Optional. Style to apply to the outside border. (Default `decoration`)
- `--inside insideStyle` - String. Optional. Style to apply to the inside content. (Default `decoration`)
- `--width characterCount` - UnsignedInteger|String. Optional. Box width. Specify "auto" to make size of content, or "console" for `consoleWidth`. Defaults to `console`.
- `--size lineCount` - UnsignedInteger. Optional. Print this many blank lines between the header and title. (Default none)
- `--fill fileCharacter` - String. Optional. Use this character to fill empty space in the box.
- `text ...` - String. Optional. Text to put in the box, one per line.
- `--help` - Flag. Optional. Display this help.

### Examples

    __decorateExtensionBox --style ascii "Moving ..."
    __decorateExtensionBox --style line Hello
    __decorateExtensionBox --style double-line "I'm sorry, Hal, I'm afraid I can't do that.

### Sample Output

    +==========================================================================+
    | Moving ...                                                               |
    +==========================================================================+
    ┌──────────────────────────────────────────────────────────────────────────┐
    │ Hello                                                                    │
    └──────────────────────────────────────────────────────────────────────────┘
    ╔══════════════════════════════════════════════════════════════════════════╗
    ║ I'm sorry, Hal, I'm afraid I can't do that.                              ║
    ╚══════════════════════════════════════════════════════════════════════════╝

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

