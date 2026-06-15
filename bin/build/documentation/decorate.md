### `decorate`

> Singular decoration function

#### Usage

    decorate style [ text ... ]

Singular decoration function
You can extend this function by writing a your own extension `__decorationExtensionCustom` is called for `decorate custom`.

> Location: `bin/build/tools/decorate/core.sh`

#### Arguments

- `style` - String. Required. One of: reset underline no-underline bold no-bold black black-contrast blue cyan green magenta orange red white yellow code info notice success warning error subtle label value decoration
- `text ...` - String. Optional. Text to output. If not supplied, outputs a code to change the style to the new style. May contain arguments for `style`.

#### Writes to standard output

Decorated text

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- __BUILD_DECORATE - String. Cached color lookup.
- [`BUILD_COLORS` Build Colors Flag]({rel}env/#decoration) – **Boolean**. If true then colors are shown, blank means guess the - Boolean. Colors enabled (`true` or `false`).

#### Requires

- [isFunction]({rel}tools/type.md#isfunction) - Test if argument are bash functions ([source](https://github.com/zesk/build/blob/main/bin/build/tools/type.sh#L177))
- [catchArgument]({rel}tools/sugar-core.md#catchargument) - Run \`command\`, upon failure run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L238))
- [catchReturn]({rel}tools/sugar.md#catchreturn) - Run binary and catch errors with handler ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L284))
- awk
- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))
- [helpArgument]({rel}tools/argument.md#helpargument) - Simple help argument handler. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/argument.sh#L576))
- {SEE:_decorateInitialize}
- {SEE:__decorateStyle}
- {SEE:__decorate}
- [executeInputSupport]({rel}tools/sugar.md#executeinputsupport) - Support arguments and stdin as arguments to an executor ([source](https://github.com/zesk/build/blob/main/bin/build/tools/sugar.sh#L167))

