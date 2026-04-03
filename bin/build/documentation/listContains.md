## `listContains`

> Does a character-delimited list contain item(s)?

### Usage

    listContains listValue separator [ item ... ] [ --help ]

Return code 0 IFF all items are found in the list. If any item is not found, returns code 1.
If no items are passed in the return value is 0 (true).
Add an item to the beginning or end of a text-delimited list

### Arguments

- `listValue` - Required. List value to search.
- `separator` - Required. Separator string for item values (typically `:`)
- `item ...` - Optional. the item to be searched for in the `listValue`
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - All items are found in the `listValue`
- `1` - One or more items were NOT found in the `listValue`

