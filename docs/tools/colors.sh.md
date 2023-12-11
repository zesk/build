# Color Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

All console functions in the form `consoleAction` where `Action` is a color name or a semantic meaning behave similarly:

- With no arguments output the color escape codes with no newline to standard out
- With arguments wrap the arguments with color escape code to color and reset the console state afterwards
- Optionally add a `-n` as the first argument to prevent output of a newline which is output by default

Examples:

    cat $file | prefixLines "$(consoleGreen)"
    consoleInfo Starting to deploy ...

## Semantic color commands

Color commands intended to convey status of messages. Try `colorTest` to see all colors.

- `consoleInfo` - Informational messages
- `consoleWarning` - Warning messages
- `consoleSuccess` - Success messages
- `consoleDecoration` - Lines or decoration text
- `consoleError` - Error messages
- `consoleLabel` - Used for label/value pairs
- `consoleValue` - Used for label/value pairs
- `consoleCode` - Code output

## Color commands

Colors vary depending on the console and the terminal. Try `colorTest` to see all colors.

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


### `clearLine` - Clear a line in the console

Clears current line of text in the console

Intended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces.

#### Usage

    clearLine

#### Examples

statusMessage consoleInfo Loading...; bin/load.sh >>"$loadLogFile";
    clearLine

#### Exit codes

- `0` - Always succeeds

#### Environment

Intended to be run on an interactive console. Should support `tput cols`.

### `statusMessage` - Output a status message with no newline

Output a status line using a colorAction

This is intended for messages on a line which are then overwritten using clearLine

Clears the line and outputs a message using a color command. Meant to show status but not use up an output line for it.

shellcheck disable=SC2120

#### Usage

    statusMessage consoleAction message [ ... ]

#### Arguments

- `consoleAction` - Required. String. Is one of **Semantic color commands** above or **Color commands** above
- `message ...` - Message to output

#### Examples

statusMessage Loading...
    bin/load.sh >>"$loadLogFile"
    clearLine

#### Exit codes

- `0` - Always succeeds

#### Environment

Intended to be run on an interactive console. Should support $(tput cols).

### `consoleNameValue` - Output a name value pair

Utility function which is similar to `usageGenerator` except it operates on a line at a time. The name is output
right-aligned to the `characterWidth` given and colored using `consoleLabel`; the value colored using `consoleValue`.


shellcheck disable=SC2120

#### Usage

    consoleNameValue characterWidth name [ value ... ]

#### Arguments

- `characterWidth` - Required. Number of characters to format the value for spacing
- `name` - Required. Name to output
- `value ...` - Optional. One or more Value to output

#### Exit codes

- `0` - Always succeeds


### `hasColors` - This tests whether `TERM` is set, and if not, uses

This tests whether `TERM` is set, and if not, uses the `DISPLAY` variable to set `BUILD_COLORS` IFF `DISPLAY` is non-empty.
If `TERM1` is set then uses the `tput colors` call to determine the console support for colors.

Exit Code; 1 - No colors

#### Usage

    hasColors

#### Exit codes

- `0` - Console or output supports colors

#### Local cache

this value is cached in BUILD_COLORS if it is not set.

#### Environment

BUILD_COLORS - Override value for this

### `hasConsoleAnimation` - Exit Code; 1 - Does not support console animation

Exit Code; 1 - Does not support console animation

#### Usage

    hasConsoleAnimation

#### Exit codes

- `0` - Supports console animation

#### Environment

CI - If this has a non-blank value, this returns true (supports animation)


### `colorTest` - Output colors

Outputs sample sentences for the `consoleAction` commands to see what they look like.

#### Exit codes

- `0` - Always succeeds

### `allColorTest` - Alternate color output

If you want to explore what colors are available in your terminal, try this.

#### Exit codes

- `0` - Always succeeds

### `simpleMarkdownToConsole` - Converts backticks, bold and italic to console colors.

Converts backticks, bold and italic to console colors.

#### Usage

    simpleMarkdownToConsole < $markdownFile

#### Exit codes

- `0` - Always succeeds

### `statusMessage` - Output a status message with no newline

Output a status line using a colorAction

This is intended for messages on a line which are then overwritten using clearLine

Clears the line and outputs a message using a color command. Meant to show status but not use up an output line for it.

shellcheck disable=SC2120

#### Usage

    statusMessage consoleAction message [ ... ]

#### Arguments

- `consoleAction` - Required. String. Is one of **Semantic color commands** above or **Color commands** above
- `message ...` - Message to output

#### Examples

statusMessage Loading...
    bin/load.sh >>"$loadLogFile"
    clearLine

#### Exit codes

- `0` - Always succeeds

#### Environment

Intended to be run on an interactive console. Should support $(tput cols).

### `consoleColumns` - Column count in current console

Column count in current console

Output the number of columns in the terminal. Default is 80 if not able to be determined from `TERM`.

#### Usage

    consoleColumns

#### Examples

repeat $(consoleColumns)

#### Exit codes

- `0` - Always succeeds

#### Environment

Uses the `tput cols` tool to find the value if `TERM` is non-blank.

### `simpleMarkdownToConsole` - Converts backticks, bold and italic to console colors.

Converts backticks, bold and italic to console colors.

#### Usage

    simpleMarkdownToConsole < $markdownFile

#### Exit codes

- `0` - Always succeeds

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
