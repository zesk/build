## `printfOutputEmpty`

> printf when output is blank

### Usage

    printfOutputEmpty ...

Pipes all input to output, if any input exists behaves like `cat`. If input is empty then runs and outputs the `printf` statement result.
Without arguments, displays help.

### Arguments

- `...` - Arguments. Required. printf arguments.

### Reads standard input

text (Optional)

### Writes to standard output

printf output and then the stdin text IFF stdin text is blank

### Examples

    cat "$failedFunctions" | decorate wrap -- "- " | printfOutputEmpty "%s\n" "No functions failed."

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

