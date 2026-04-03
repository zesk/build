## `fileModifiedRecently`

> List the most recently modified file in a directory prefixed

### Usage

    fileModifiedRecently directory [ findArgs ]

List the most recently modified file in a directory prefixed with the timestamp

### Arguments

- `directory - Directory. Required. Must exists` - directory to list.
- `findArgs` - Arguments. Optional. Optional additional arguments to modify the find query

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

