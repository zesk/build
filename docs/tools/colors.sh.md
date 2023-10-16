# Color Functions

All console functions in the form `consoleAction` where `Action` is a color name or a semantic meaning behave similarly:

- With no arguments output the color escape codes with no newline to standard out
- With arguments wrap the arguments with color escape code to color and reset the console state afterwards
- Optionally add a `-n` as the first argument to prevent output of a newline which is output by default

Examples:

    cat $file | prefixLines "$(consoleGreen)"
    consoleInfo Starting to deploy ...

## Semantic color commands

- `consoleInfo` - Informational messages
- `consoleWarning` - Warning messages
- `consoleSuccess` - Success messages
- `consoleDecoration` - Lines or decoration text
- `consoleError` - Error messages
- `consoleLabel` - Used for label/value pairs
- `consoleValue` - Used for label/value pairs
- `consoleCode` - Code output

## Color commands

Colors vary depending on the console and the terminal.

- `consoleRed`
- `consoleGreen`
- `consoleCyan`
- `consoleBlue`
- `consoleOrange`
- `consoleMagenta`
- `consoleBlack`
- `consoleWhite`
- `consoleBoldMagenta`
- `consoleUnderline`
- `consoleBold`
- `consoleBoldRed`

## `clearLine` - Clear a line in the console

Intended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces.

### Usage

    clearLine

### Arguments

None

### Environment

Intended to be run on an interactive console. Should support `tput cols`.

### Exit codes

Zero

### Examples

    statusMessage consoleInfo Loading...; bin/load.sh >>"$loadLogFile";
    clearLine


## `statusMessage` - Output a status message with no newline

Clears the line and outputs a message using a color command. Meant to show status but not use up an output line for it.

### Usage

    statusMessage consoleAction message [ ... ]

### Arguments

- `consoleAction` is one of **Semantic color commands** above or **Color commands** above
- `message ...` is a message to output

### Environment

Intended to be run on an interactive console. Should support `tput cols`.

### Exit codes

Zero

### Examples

    statusMessage Loading...; bin/load.sh >>"$loadLogFile";
    clearLine


## `consoleReset` - Reset the color

This is typically appended after most `consoleAction` calls to reset the state of the console to default color and style.

It does *not* take the optional `-n` argument ever, and outputs the reset escape sequence to standard out.

## `consoleNameValue` - Output a name value pair

Utility function which is similar to `usageGenerator` except it operates on a line at a time. The name is output
right-aligned to the `characterWidth` given and colored using `consoleLabel`; the value colored using `consoleValue`.

Usage:

    consoleNameValue characterWidth name value

### Arguments

- `characterWidth` - Number of characters to format the value for spacing
- `name` - Name to output
- `value` - Value to output

## `colorTest` - Output colors

Outputs sample sentences for the `consoleAction` commands to see what they look like.

## `allColorTest` - Alternate color output

If you want to explore what colors are available in your terminal, try this.

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)