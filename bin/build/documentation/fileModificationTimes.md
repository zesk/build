## `fileModificationTimes`

> Lists files in a directory recursively along with their modification

### Usage

    fileModificationTimes directory [ findArgs ]

Lists files in a directory recursively along with their modification time in seconds.
Output is unsorted.

### Arguments

- `directory - Directory. Required. Must exists` - directory to list.
- `findArgs` - Arguments. Optional. Optional additional arguments to modify the find query

### Examples

fileModificationTimes $myDir ! -path "*/.*/*"

### Sample Output

1705347087 bin/build/tools.sh
1704312758 bin/build/deprecated.sh
1705442647 bin/build/build.json

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

