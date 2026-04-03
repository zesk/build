## `consoleLink`

> console hyperlinks

### Usage

    consoleLink link [ text ] [ --help ]

Output a hyperlink to the console
OSC 8 standard for terminals
No way to test ability, I think. Maybe `tput`.

### Arguments

- `link` - EmptyString. Required. Link to output.
- `text` - String. Optional. Text to display, if none then uses `link`.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

