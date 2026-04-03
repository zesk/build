## `escapeSingleQuotes`

> Quote strings for inclusion in shell quoted strings

### Usage

    escapeSingleQuotes [ text ]

Quote strings for inclusion in shell quoted strings
Without arguments, displays help.

### Arguments

- `text` - Text to quote

### Examples

    escapeSingleQuotes "Now I can't not include this in a bash string."

### Sample Output

Single quotes are prefixed with a backslash

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

