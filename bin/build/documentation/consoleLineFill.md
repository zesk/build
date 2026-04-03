## `consoleLineFill`

> Clear a line in the console

### Usage

    consoleLineFill [ textToOutput ]

Clears current line of text in the console
Intended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces.
Intended to be run on an interactive console. Should support $(tput cols).

### Arguments

- `textToOutput` - String. Optional. Text to display on the new cleared line.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

