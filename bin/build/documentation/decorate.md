### `decorate`

> decorate text using colors and styles

#### Usage

    decorate style [ text ... ]

Singular decoration function which allows access to console colors, links, and custom formatting for any type in the system.
If no text is supplied the default is to read input from stdin.
##### Special argument `--`

Passing the special argument `--` for text will *skip* reading input from `stdin` and instead continue decorating any
additional arguments, if any. This allows blank arguments to be processed correctly by the internal implementation of
`decorate` as well as the extensions. To output the text `--` you *MUST* pipe it to `stdin` or pass the argument twice:

    > decorate info -- I like two dashes on my lines
    I like two dashes on my lines
    > decorate info -- -- I like two dashes on my lines
    -- I like two dashes on my lines

Ideally we would be able to `check` if any input is available on `stdin` without having to wait, but some versions of
Bash `read` does not support a timeout of zero (which is effectively a `select` to see if `stdin`
has data) this allows us to disambiguate when `stdin` is expected and should be read and cases where arguments may be
blank unintentionally but intended to be decorated. Sadly, if `executeInputSupport` worked with a timeout of zero then
this would not be needed.

The use case where this happens is:

    decorate info "${items[@]}"

Where `items` may be empty. Without the `--` this takes a second on some platforms for `read` to timeout. Generally
speaking, this is acceptable for the behavior but should be avoided at all costs.

    😎 dude@mai ~/Developer/build > timing decorate info
    decorate info 1 second, 55ms [1055]
    😎 dude@mai ~/Developer/build > timing decorate info --
    decorate info -- 35ms [35]

##### Extending Decorations

You can extend this function by writing a your own extension prefixed with `__decorationExtension`.

For example, the function `__decorationExtensionCustom` is called for `decorate custom`. The style name is converted as follows prior to determining the function to call:

- All `-` characters are converted to `_` characters
- The first letter of the style is capitalized. (Remaining characters are unchanged.)

If the function exists, it is used for the decoration. Additionally, if the function plus the suffix `.Pure` exists, it is called *without* `executeInputSupport` which means your decoration function **must handle stdin** and **arguments** correctly.

This is useful when you handle `stdin` differently than `executeInputSupport` or need to handle `--` parameters differently.

Built-in extensions:

- {SEE:__decorateExtensionDiff}
- {SEE:__decorateExtensionEach}
- {SEE:__decorateExtensionFile}
- {SEE:__decorateExtensionPair}
- {SEE:__decorateExtensionQuote}
- {SEE:__decorateExtensionSize}
- {SEE:__decorateExtensionWrap}

> Location: `bin/build/tools/decorate/core.sh`

#### Arguments

- `style` - String. Required. One of: reset underline no-underline bold no-bold black black-contrast blue cyan green magenta orange red white yellow code info notice success warning error subtle label value decoration
- `text ...` - String. Optional. Text to output. If not supplied, outputs a code to change the style to the new style. May contain arguments for `style`.

#### Reads standard input

String. Optional. Text to decorate.

#### Writes to standard output

Decorated text

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- __BUILD_DECORATE - String. Cached color lookup.
- {SEE:BUILD_COLORS} - Boolean. Colors enabled (`true` or `false`).

#### Requires

- [isFunction]({rel}tools/type.md#isfunction) - Test if argument are bash functions ([source](https://github.com/zesk/build/blob/main/bin/build/tools/type.sh#L177))
- [catchArgument]({rel}tools/sugar-core.md#catchargument) - Run \`command\`, upon failure run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L238))
- [catchReturn]({rel}tools/sugar.md#catchreturn) - Run binary and catch errors with handler ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L284))
- [`awk`]({rel}guide/command.md#awk)
- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))
- [helpArgument]({rel}tools/argument.md#helpargument) - Simple help argument handler. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/argument.sh#L576))
- [executeInputSupport]({rel}tools/sugar.md#executeinputsupport) - Support arguments and stdin as arguments to an executor ([source](https://github.com/zesk/build/blob/main/bin/build/tools/sugar.sh#L167))

