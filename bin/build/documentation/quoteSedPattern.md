## `quoteSedPattern`

> Quote sed search strings for shell use

### Usage

    quoteSedPattern text

Quote a string to be used in a sed pattern on the command line.

### Arguments

- `text` - EmptyString. Required. Text to quote

### Examples

    sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/g"
    needSlash=$(quoteSedPattern '$.*/[\]^')

### Sample Output

string quoted and appropriate to insert in a sed search or replacement phrase

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

