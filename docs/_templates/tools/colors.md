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

{clearLine}
{statusMessage}
{consoleNameValue}

{hasColors}
{hasConsoleAnimation}

{colorTest}
{allColorTest}
{simpleMarkdownToConsole}
{statusMessage}
{consoleColumns}
{simpleMarkdownToConsole}

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
