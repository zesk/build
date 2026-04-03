## `__xmlAttributes`

> Output XML attributes

### Usage

    __xmlAttributes [ nameValue ]

Output XML attributes
Beware of Bash quoting rules when passing in values

### Arguments

- `nameValue` - String. Optional. One or more name/value pairs in the form `name=value` where the delimiter is an equals sign `=` and the value is *unquoted*.

### Writes to standard output

String. XML attribute values formatted on a single line with a leading space

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

