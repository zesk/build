# Color Tools

<!-- TEMPLATE header 2 -->
[⬅ Parent ](../)
<hr />

All console functions in the form `decorate style` where `style` is a color name or a semantic meaning behave similarly:

Examples:

    cat $file | wrapLines "$(decorate green)" "$(decorate reset)"
    decorate info Starting to deploy ...

## Color Mode

Zesk Build now supports two color modes for light and dark terminals with related contrasts. To set use `consoleColorMode`.

{decorate}
{decorations}

{__decorateExtensionEach}
{__decorateExtensionQuote}

# Semantic color commands

Color commands intended to convey status of messages. Try `semanticColorTest` to see all colors.

- `decorate info` - Informational messages
- `decorate notice` - Notice messages
- `decorate warning` - Warning messages
- `decorate success` - Success messages
- `decorate decoration` - Lines or decoration text
- `decorate error` - Error messages
- `decorate label` - Used for label/value pairs
- `decorate value` - Used for label/value pairs
- `decorate code` - Code output

# Color commands

Colors vary depending on the console and the terminal. Try `colorTest` to see all colors.

## Standard ANSI Colors

- `decorate red`
- `decorate green`
- `decorate cyan`
- `decorate blue`
- `decorate orange`
- `decorate magenta`
- `decorate black`
- `decorate white`

## Text decoration

- `decorate underline`
- `decorate bold`

## Bold Colors

- `decorate bold-red`
- `decorate bold-green`
- `decorate bold-cyan`
- `decorate bold-blue`
- `decorate bold-orange`
- `decorate bold-magenta`
- `decorate bold-black`
- `decorate bold-white`

## Extensions

- `decorate pair name value`
- `decorate pair 40 name value`
- `decorate each code item1 item2`

# Additional commands

{consoleColorMode}

{clearLine}
{statusMessage}

{hasColors}
{hasConsoleAnimation}
{simpleMarkdownToConsole}

# Color tests

{colorComboTest}
{allColorTest}
{colorTest}
{semanticColorTest}

# Color tools

{colorFormat}
{colorMultiply}
{colorNormalize}
{colorParse}
{colorBrightness}
