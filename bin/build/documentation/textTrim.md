## `textTrim`

> Trim whitespace of a bash argument

### Usage

    textTrim [ text ]

Trim spaces and only spaces from arguments or a pipe

### Arguments

- `text` - EmptyString. Optional. Text to remove spaces. If no arguments are supplied it is assumed that input should be read from standard input.

### Reads standard input

Reads lines from stdin until EOF

### Writes to standard output

Outputs trimmed lines

### Examples

    textTrim "$token"
    grep "$tokenPattern" | textTrim > "$tokensFound"

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Credits

Thanks to [Chris F.A. Johnson (2008)
](https://web.archive.org/web/20121022051228/http://codesnippets.joyent.com/posts/show/1816
).

