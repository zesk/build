## `listRemove`

> Remove one or more items from a text-delimited list

### Usage

    listRemove listValue separator [ item ] [ --help ]

Remove one or more items from a text-delimited list

### Arguments

- `listValue` - Required. List value to modify.
- `separator` - Required. Separator string for item values (typically `:`)
- `item` - the item to be removed from the `listValue`
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

