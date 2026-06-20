### `decorate quote`

> Double-quote all arguments

#### Usage

    __decorateExtensionQuote

Double-quote all arguments as properly quoted bash string.
Mostly $ and " are problematic within a string.

> Location: `bin/build/tools/decorate/core.sh`

#### Arguments

- none

#### Examples

    > decorate quote "$title"
    "Can't believe it was only \$0.99?"

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [`printf`]({rel}guide/builtin.md#printf)
- [decorate]({rel}tools/decorate.md#decorate) - decorate text using colors and styles ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L144))

