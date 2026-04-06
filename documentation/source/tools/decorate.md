# Decoration and Console Colors

<!-- TEMPLATE header 2 -->
[⬅ Parent ](../index.md)
<hr />

For color console support use `decorate style` where `style` is a color name or a _semantic meaning_, each of which
behave similarly:

Examples:

    decorate green < "$file"
    decorate info Starting to deploy ...

Zesk Build allows for customizations of all decoration colors to custom values allowing themes to be created.

{decorate}

{decorateInitialized}

{decorations}

{decorateStyle}

{colorScheme}

## Semantic color commands

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

## Color commands

Colors vary depending on the console and the terminal. Try `colorSampleStyles` to see all colors.

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

## Decorate extensions

Examples:

- `decorate BOLD` `style` `text` ...
- `decorate` `pair` `[` `width` `]` `name` `value` ...
- `decorate` `each` `[ ``--count` `]` `[` `--index` `]` `style` `item1` `item2` ...
- `decorate` `size` `value`
- `decorate big "Welcome to Zesk" | decorate box | decorate at 1 1`
- `decorate` `pair` `name` `value ...`
- `decorate` `wrap` `prefix` `suffix ...`
- `decorate` `quote` `word` `...`
- `decorate` `file` `path` 
- `decorate` `link` `url` `[` `text` `]`
- `decorate` `box` `Hello` 

{__decorateExtensionBOLD}

{__decorateExtensionEach}

{__decorateExtensionPair}

{__decorateExtensionWrap}

{__decorateExtensionQuote}

{__decorateExtensionFile}

{__decorateExtensionLink}

{__decorateExtensionSize}

{__decorateExtensionBox}

{__decorateExtensionBig}

{__decorateExtensionAt}

{__decorateExtensionDiff}

{__decorateExtensionExpired}

### Creating extensions

You can add your own decoration extension to your code by creating a function named:

- `__decorateExtensionFoo` - where `foo` (lower case first letter) is the decoration name

Your function will be called by [`executeInputSupport`](../sugar.md#executeinputsupport) which handles converting
arguments from `stdin` into multiple calls to your function.

If you want to handle input from `stdin` on your own, create a function instead named:

- `__decorateExtensionFoo.Pure` - where `foo` (lower case first letter) is the decoration name

This should handle reading from `stdin` or arguments and handle either appropriately.

## Additional commands

{consoleLineFill}

{statusMessage}

{consoleHasColors}

{consoleHasAnimation}

## Color tests

{colorSampleCombinations}

<img src="../images/colorSampleCombinations.png"  alt="Sample `colorSampleCombinations` output"/>

{colorSampleCodes}

<img src="../images/colorSampleCodes.png"  alt="Sample `colorSampleCodes` output"/>

{colorSampleStyles}

<img src="../images/colorSampleStyles.png"  alt="Sample `colorSampleStyles` output"/>

{colorSampleSemanticStyles}

<img src="../images/colorSampleSemanticStyles.png"  alt="Sample `colorSampleSemanticStyles` output"/>

## Color tools

{colorFormat}

{colorMultiply}

{colorNormalize}

{colorParse}

{colorBrightness}
