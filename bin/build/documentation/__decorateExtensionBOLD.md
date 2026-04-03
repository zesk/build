## `decorate BOLD`

> Add bold style to another style

### Usage

    decorate BOLD style [ text ... ]

Add bold style to another style

### Arguments

- `style` - CommaDelimitedList. Required. Style arguments passed directly to decorate for each item.
- `text ...` - EmptyString. Optional. Text to format. Use `--` to output begin codes only.

### Examples

decorate BOLD info Info is more important

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

