## `listAppend`

> Add an item to a character-delimited list.

### Usage

    listAppend listValue separator [ --first ] [ --last ] [ item ] [ --help ]

Add an item to a list IFF it does not exist in the list already
Add an item to the beginning or end of a text-delimited list

### Arguments

- `listValue` - Required. List value to modify.
- `separator` - Required. Separator string for item values (typically `:`)
- `--first` - Flag. Optional. Place any items after this flag first in the list
- `--last` - Flag. Optional. Place any items after this flag last in the list. Default.
- `item` - the value to be added to the `listValue`
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

