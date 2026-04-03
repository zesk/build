## `textRepeat`

> Repeat a string

### Usage

    textRepeat `count` `text` .. [ --help ]

Repeat a string

### Arguments

- `count` - UnsignedInteger. Required. Count of times to repeat.
- ``text` ..` - String. Required. A sequence of characters to repeat.
- `--help` - Flag. Optional. Display this help.

### Examples

    textRepeat 80 =
    decorate info Hello world
    textRepeat 80 -

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

