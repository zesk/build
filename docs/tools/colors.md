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


























