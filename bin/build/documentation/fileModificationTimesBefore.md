## `fileModificationTimesBefore`

> List files modified before a specific timestamp (inclusive)

### Usage

    fileModificationTimesBefore directory timestamp [ findArgs ]

List files modified before a specific timestamp (inclusive)

Output is sorted from oldest time to newest (chronological).

> Location: `bin/build/tools/file.sh`

### Arguments

- `directory - Directory. Required. Must exists` - directory to list.
- `timestamp` - PositiveInteger. Required. Timestamp to compare file timestamps with.
- `findArgs` - Arguments. Optional. Optional additional arguments to modify the find query

### Examples

fileModificationTimesBefore "$myDir" "$yesterdayNoon" ! -path "*/.*/*"

### Sample Output

1704312758 bin/build/deprecated.sh
1705347087 bin/build/tools.sh
1705442647 bin/build/build.json

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

