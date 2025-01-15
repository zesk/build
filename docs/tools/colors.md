# Color Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

All console functions in the form `decorate style` where `style` is a color name or a semantic meaning behave similarly:

- With no arguments output the color escape codes with no newline to standard out
- With arguments wrap the arguments with color escape code to color and reset the console state afterwards

Examples:

    cat $file | wrapLines "$(decorate green)" "$(decorate reset)"
    decorate info Starting to deploy ...

## Color Mode

Zesk Build now supports two color modes for light and dark terminals with related contrasts. To set use `consoleColorMode`.

## New color command

This is still in progress but will likely be the new mechanism.

### `decorate` - Semantics-based

Semantics-based

- Location: `bin/build/install-bin-build.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

# Old method (pre October 2024)

## Semantic color commands

Color commands intended to convey status of messages. Try `colorTest` to see all colors.

- `decorate info` - Informational messages
- `decorate warning` - Warning messages
- `decorate success` - Success messages
- `decorate decoration` - Lines or decoration text
- `decorate error` - Error messages
- `decorate label` - Used for label/value pairs
- `decorate value` - Used for label/value pairs
- `decorate code` - Code output

## Color commands

Colors vary depending on the console and the terminal. Try `colorTest` to see all colors.

### Standard ANSI Colors

- `decorate red`
- `decorate green`
- `decorate cyan`
- `decorate blue`
- `decorate orange`
- `decorate magenta`
- `decorate black`
- `decorate white`

### Text decoration

- `decorate underline`
- `decorate bold`

### Bold Colors

- `decorate bold-red`
- `decorate bold-green`
- `decorate bold-cyan`
- `decorate bold-blue`
- `decorate bold-orange`
- `decorate bold-magenta`
- `decorate bold-black`
- `decorate bold-white`

### Reset color to defaults



## Additional commands

### `consoleColorMode` - Set colors to deal with dark or light-background consoles

Set colors to deal with dark or light-background consoles

- Location: `bin/build/tools/colors.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--dark` - Optional. Flag. Dark mode for darker backgrounds.
- `--light` - Optional. Flag. Light mode for lighter backgrounds.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

BUILD_COLORS_MODE

### `clearLine` - Clear a line in the console

Clears current line of text in the console

Intended to be run on an interactive console, this clears the current line of any text and replaces the line with spaces.

- Location: `bin/build/tools/colors.sh`

#### Usage

    clearLine textToOutput
    

#### Arguments

- No arguments.

#### Examples

    clearLine

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

Intended to be run on an interactive console. Should support `tput cols`.

### `statusMessage` - Output a status message with no newline

Output a status line

This is intended for messages on a line which are then overwritten using clearLine

Clears the line and outputs a message using a command. Meant to show status but not use up an output line for it.

- Location: `bin/build/tools/colors.sh`

#### Usage

    statusMessage command ...
    

#### Arguments

- `command` - Required. Commands which output a message.
- `--last` - Optional. Flag. Last message to be output, so output a newline as well at the end.

#### Examples

    statusMessage decorate info "Loading ..."
    bin/load.sh >>"$loadLogFile"
    clearLine

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

Intended to be run on an interactive console. Should support $(tput cols).

### `consoleNameValue` - Output a name value pair

Utility function which is similar to `usageGenerator` except it operates on a line at a time. The name is output
right-aligned to the `characterWidth` given and colored using `consoleLabel`; the value colored using `consoleValue`.



- Location: `bin/build/tools/colors.sh`

#### Usage

    consoleNameValue characterWidth name [ value ... ]
    

#### Arguments

- `characterWidth` - Required. Number of characters to format the value for spacing
- `name` - Required. Name to output
- `value ...` - Optional. One or more Value to output

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `hasColors` - Sets the environment variable `BUILD_COLORS` if not set, uses `TERM`

Sets the environment variable `BUILD_COLORS` if not set, uses `TERM` to calculate

Exit Code; 1 - Colors are likely not supported by console

- Location: `bin/build/install-bin-build.sh`

#### Usage

    hasColors
    

#### Arguments

- No arguments.

#### Exit codes

- `0` - Console or output supports colors

#### Environment

BUILD_COLORS - Optional. Boolean. Whether the build system will output ANSI colors.

### `hasConsoleAnimation` - Exit Code; 1 - Does not support console animation

Exit Code; 1 - Does not support console animation

- Location: `bin/build/tools/colors.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Supports console animation

### `colorTest` - Output colors

Outputs sample sentences for the `consoleAction` commands to see what they look like.

- Location: `bin/build/tools/colors.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `semanticColorTest` - Output colors

Outputs sample sentences for the `action` commands to see what they look like.

- Location: `bin/build/tools/colors.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `allColorTest` - Alternate color output

If you want to explore what colors are available in your terminal, try this.

- Location: `bin/build/tools/colors.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `simpleMarkdownToConsole` - Converts backticks, bold and italic to console colors.

Converts backticks, bold and italic to console colors.

- Location: `bin/build/tools/colors.sh`

#### Usage

    simpleMarkdownToConsole < $markdownFile
    

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `statusMessage` - Output a status message with no newline

Output a status line

This is intended for messages on a line which are then overwritten using clearLine

Clears the line and outputs a message using a command. Meant to show status but not use up an output line for it.

- Location: `bin/build/tools/colors.sh`

#### Usage

    statusMessage command ...
    

#### Arguments

- `command` - Required. Commands which output a message.
- `--last` - Optional. Flag. Last message to be output, so output a newline as well at the end.

#### Examples

    statusMessage decorate info "Loading ..."
    bin/load.sh >>"$loadLogFile"
    clearLine

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

Intended to be run on an interactive console. Should support $(tput cols).

### `colorComboTest` - undocumented

No documentation for `colorComboTest`.

- Location: `bin/build/tools/colors.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `colorBrightness` - Return an integer between 0 and 100

Return an integer between 0 and 100
Colors are between 0 and 255

- Location: `bin/build/tools/colors.sh`

#### Arguments

- `redValue` - Integer. Optional. Red RGB value (0-255)
- `greenValue` - Integer. Optional. Red RGB value (0-255)
- `blueValue` - Integer. Optional. Red RGB value (0-255)

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
