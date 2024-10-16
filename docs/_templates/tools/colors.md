# Color Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

All console functions in the form `decorate style` where `style` is a color name or a semantic meaning behave similarly:

- With no arguments output the color escape codes with no newline to standard out
- With arguments wrap the arguments with color escape code to color and reset the console state afterwards

Examples:

    cat $file | wrapLines "$(decorate green)" "$(decorate reset)"
    consoleInfo Starting to deploy ...

## Color Mode

Zesk Build now supports two color modes for light and dark terminals with related contrasts. To set use `consoleColorMode`.

## New color command

This is still in progress but will likely be the new mechanism.

{decorate}

# Old method (pre October 2024)

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

### Standard ANSI Colors

- `consoleRed`
- `consoleGreen`
- `consoleCyan`
- `consoleBlue`
- `consoleOrange`
- `consoleMagenta`
- `consoleBlack`
- `consoleWhite`

### Text decoration

- `consoleUnderline`
- `consoleBold`

### Bold Colors

- `consoleBoldRed`
- `consoleBoldGreen`
- `consoleBoldCyan`
- `consoleBoldBlue`
- `consoleBoldOrange`
- `consoleBoldMagenta`
- `consoleBoldBlack`
- `consoleBoldWhite`

## Additional commands

{consoleColorMode}

{clearLine}

{statusMessage}

{consoleNameValue}

{hasColors}

{hasConsoleAnimation}

{colorTest}

{semanticColorTest}

{allColorTest}

{simpleMarkdownToConsole}

{statusMessage}

{colorComboTest}

{colorBrightness}
