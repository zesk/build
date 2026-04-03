## `linkRename`

> Rename a link

### Usage

    linkRename from to

Rename a link
Renames a link forcing replacement, and works on different versions of `mv` which differs between systems.

### Arguments

- `from` - Link. Required. Link to rename.
- `to` - FileDirectory. Required. New link path.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

