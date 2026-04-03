## `escapeQuotes`

> Quote strings for inclusion in shell quoted strings

### Usage

    escapeQuotes [ text ]

Quote strings for inclusion in shell quoted strings
Without arguments, displays help.

### Arguments

- `text` - Text to quote

### Writes to standard output

The input text properly quoted

### Examples

    escapeQuotes "Now I can't not include this in a bash string."

### Sample Output

Single quotes are prefixed with a backslash

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

