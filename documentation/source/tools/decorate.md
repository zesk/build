# Color Tools

<!-- TEMPLATE header 2 -->
[⬅ Parent ](../index.md)
<hr />

For color console support use `decorate style` where `style` is a color name or a _semantic meaning_, each of which
behave similarly:

Examples:

    decorate green < "$file"
    decorate info Starting to deploy ...

## Color Mode

Zesk Build supports customizations of all decoration colors to custom values.

{decorate}

{decorateInitialized}

{decorations}

{decorateStyle}

{colorScheme}

{__decorateExtensionBOLD}

{__decorateExtensionEach}

{__decorateExtensionPair}

{__decorateExtensionDiff}

{__decorateExtensionWrap}

{__decorateExtensionQuote}

# Semantic color commands

Color commands intended to convey status of messages. Try `colorSampleSemanticStyles` to see all colors.

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

## Extensions

- `decorate BOLD` `style` `text` ...
- `decorate` `pair` `[` `width` `]` `name` `value` ...
- `decorate` `each` `[ ``--count` `]` `[` `--index` `]` `style` `item1` `item2` ...
- `decorate` `size` `value`

### Creating extensions

You can add your own decoration extension to your code by creating a function named:

- `__decorateExtensionFoo` - where `foo` (lowercase first letter) is the decoration name

# Additional commands

{consoleLineFill}

{statusMessage}

{consoleHasColors}

{consoleHasAnimation}

# Color tests

{colorSampleCombinations}

{colorSampleCodes}

{colorSampleStyles}

{colorSampleSemanticStyles}

# Color tools

{colorFormat}

{colorMultiply}

{colorNormalize}

{colorParse}

{colorBrightness}
