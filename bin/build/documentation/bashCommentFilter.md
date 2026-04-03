## `bashCommentFilter`

> Filter comments from a bash stream

### Usage

    bashCommentFilter [ --help ] [ --only ] [ file ]

Filter comments from a bash stream

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--only` - Flag. Optional. Show ONLY comment lines. (Reverse of lines when not specified.)
- `file` - File. Optional. File(s) to filter.

### Reads standard input

a bash file

### Writes to standard output

bash file without line-comments `#`

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

