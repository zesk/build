## `consoleLine`

> Output a bar as wide as the console

### Usage

    consoleLine [ alternateChar ] [ offset ]

Output a bar as wide as the console using the `=` symbol.

### Arguments

- `alternateChar` - String. Optional. Use an alternate character or string output
- `offset` - Integer. Optional. an integer offset to increase or decrease the size of the bar (default is `0`)

### Examples

    decorate success $(consoleLine =-)
    decorate success $(consoleLine "- Success ")
    decorate magenta $(consoleLine +-)

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

