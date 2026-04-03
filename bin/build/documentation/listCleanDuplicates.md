## `listCleanDuplicates`

> Removes duplicates from a list and maintains ordering.

### Usage

    listCleanDuplicates separator listText [ --removed ] [ --test testFunction ] [ --help ]

Removes duplicates from a list and maintains ordering.

### Arguments

- `separator` - String. Required. List separator character.
- `listText` - String. Required. List to clean duplicates.
- `--removed` - Flag. Optional. Show removed items instead of the new list.
- `--test testFunction` - Function. Optional. Run this function on each item in the list and if the return code is non-zero, then remove it from the list.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

