## `decorate`

> Singular decoration function

### Usage

    decorate style [ text ... ]

Singular decoration function
You can extend this function by writing a your own extension `__decorationExtensionCustom` is called for `decorate custom`.

> Location: `bin/build/tools/decorate/core.sh`

### Arguments

- `style` - String. Required. One of: reset underline no-underline bold no-bold black black-contrast blue cyan green magenta orange red white yellow code info notice success warning error subtle label value decoration
- `text ...` - String. Optional. Text to output. If not supplied, outputs a code to change the style to the new style. May contain arguments for `style`.

### Writes to standard output

Decorated text

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- __BUILD_DECORATE - String. Cached color lookup.
- {SEE:BUILD_COLORS} - Boolean. Colors enabled (`true` or `false`).

### Requires

- {SEE:isFunction}
- {SEE:catchArgument}
- {SEE:catchReturn}
- awk
- {SEE:bashDocumentation}
- {SEE:helpArgument}
- {SEE:_decorateInitialize}
- {SEE:__decorateStyle}
- {SEE:__decorate}
- {SEE:executeInputSupport}

