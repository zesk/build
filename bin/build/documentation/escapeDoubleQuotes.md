## `escapeDoubleQuotes`

> Quote strings for inclusion in shell quoted strings

### Usage

    escapeDoubleQuotes [ text ]

Quote strings for inclusion in shell quoted strings
Without arguments, displays help.

### Arguments

- `text` - String. Optional. Text to quote

### Examples

    escapeDoubleQuotes "Now I can't not include this in a bash string."

### Sample Output

Single quotes are prefixed with a backslash

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

