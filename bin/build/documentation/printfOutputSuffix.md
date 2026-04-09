## `printfOutputSuffix`

> Pipe to output some text after any output, otherwise, nothing

### Usage

    printfOutputSuffix ...

Pipe to output some text after any output, otherwise, nothing is output.
Without arguments, displays help.

### Arguments

- `...` - Arguments. Required. printf arguments.

### Reads standard input

text (Optional)

### Writes to standard output

stdin text and then printf output IFF stdin text is non-blank

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

