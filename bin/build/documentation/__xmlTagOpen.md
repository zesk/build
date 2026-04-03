## `__xmlTagOpen`

> Output am XML open tag

### Usage

    __xmlTagOpen name [ ... ]

Output am XML open tag

### Arguments

- `name` - String. Required. Tag name.
- `...` - Arguments. Optional. Attributes to output within the tag in name/value pairs as `name=value`

### Writes to standard output

String. XML tag open

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

