## `printfOutputPrefix`

> Pipe to output some text before any output, otherwise, nothing

### Usage

    printfOutputPrefix ...

Pipe to output some text before any output, otherwise, nothing is output.
Without arguments, displays help.

### Arguments

- `...` - Arguments. Required. printf arguments.

### Reads standard input

text (Optional)

### Writes to standard output

printf output and then the stdin text IFF stdin text is non-blank

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

