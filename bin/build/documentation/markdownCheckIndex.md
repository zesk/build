## `markdownCheckIndex`

> Displays any markdown files next to the given index file

### Usage

    markdownCheckIndex indexFile ... [ --help ] [ --handler handler ]

Displays any markdown files next to the given index file which are not found within the index file as links.

### Arguments

- `indexFile ...` - File. Required. One or more index files to check.
- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

