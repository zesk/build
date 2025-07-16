# Color Tools

<!-- TEMPLATE header 2 -->
[⬅ Parent ](../index.md)
<hr />

All console functions in the form `decorate style` where `style` is a color name or a semantic meaning behave similarly:

Examples:

    decorate green < "$file"
    decorate info Starting to deploy ...

## Color Mode

Zesk Build supports customizations of all decoration colors to custom values.

{decorate}

{decorations}

{decorateStyle}

{__decorateExtensionEach}

{__decorateExtensionPair}

{__decorateExtensionWrap}

{__decorateExtensionQuote}

# Semantic color commands

Color commands intended to convey status of messages. Try `semanticColorSampleStyles` to see all colors.

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

Colors vary depending on the console and the terminal. Try `colorSampleStyles` to see all colors.

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
- `decorate each --count code item1 item2 item3`
- `decorate each --index code item1 item2 item3`
- `decorate size 100`

# Additional commands

{consoleColorMode}

{clearLine}

{statusMessage}

{hasColors}

{hasConsoleAnimation}

# Color tests

{colorSampleCombinations}

{colorSampleCodes}

{colorSampleStyles}

{semanticColorSampleStyles}

# Color tools

{colorFormat}

{colorMultiply}

{colorNormalize}

{colorParse}

{colorBrightness}
