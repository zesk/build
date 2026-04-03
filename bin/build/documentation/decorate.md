## `decorate`

> Singular decoration function

### Usage

    decorate style [ text ... ]

Singular decoration function
You can extend this function by writing a your own extension `__decorationExtensionCustom` is called for `decorate custom`.

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
- {SEE:BUILD_COLORS.sh} - Boolean. Colors enabled (`true` or `false`).

### Requires

isFunction returnArgument awk catchEnvironment bashDocumentation executeInputSupport __help

