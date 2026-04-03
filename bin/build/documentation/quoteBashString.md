## `quoteBashString`

> Quote bash strings for inclusion as single-quoted for eval

### Usage

    quoteBashString text

Quote bash strings for inclusion as single-quoted for eval

### Arguments

- `text` - EmptyString. Required. Text to quote.

### Examples

    name="$(quoteBashString "$name")"

### Sample Output

string quoted and appropriate to assign to a value in the shell

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

