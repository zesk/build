## `quoteGrepPattern`

> Quote grep -e patterns for shell use

### Usage

    quoteGrepPattern text

Quote grep -e patterns for shell use
Without arguments, displays help.

### Arguments

- `text` - EmptyString. Required. Text to quote.

### Examples

    grep -e "$(quoteGrepPattern "$pattern")" < "$filterFile"

### Sample Output

string quoted and appropriate to insert in a grep search or replacement phrase

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

