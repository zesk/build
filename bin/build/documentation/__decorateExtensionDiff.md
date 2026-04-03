## `decorate diff`

> Decoration for `diff -U0`

### Usage

    decorate diff leftStyle rightStyle

Removes most diff character decoration and replaces with colors

### Arguments

- `leftStyle` - String. Required. Style for left file lines
- `rightStyle` - String. Required. Style for right file lines

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

