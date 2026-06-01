## `fileModificationTimesAfter`

> List files modified after a specific timestamp (inclusive)

### Usage

    fileModificationTimesAfter directory timestamp [ findArgs ]

List files modified after a specific timestamp (inclusive)

Output is sorted from newest time to oldest time (reverse chronological).

> Location: `bin/build/tools/file.sh`

### Arguments

- `directory - Directory. Required. Must exist` - directory to list.
- `timestamp` - PositiveInteger. Required. Timestamp to compare file timestamps with.
- `findArgs` - Arguments. Optional. Optional additional arguments to modify the find query

### Examples

fileModificationTimesAfter "$myDir" "$yesterdayNoon" ! -path "*/.*/*"

### Sample Output

1704312758 bin/build/deprecated.sh
1705347087 bin/build/tools.sh
1705442647 bin/build/build.json

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

