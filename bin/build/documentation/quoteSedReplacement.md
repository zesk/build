## `quoteSedReplacement`

> Quote sed replacement strings for shell use

### Usage

    quoteSedReplacement text [ separatorChar ]

Quote sed replacement strings for shell use

### Arguments

- `text` - EmptyString. Required. Text to quote
- `separatorChar` - The character used to separate the sed pattern and replacement. Defaults to `/`.

### Examples

    sed "s/$(quoteSedPattern "$1")/$(quoteSedReplacement "$2")/g"
    needSlash=$(quoteSedPattern '$.*/[\]^')

### Sample Output

string quoted and appropriate to insert in a `sed` replacement phrase

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

printf sed usageDocument __help

