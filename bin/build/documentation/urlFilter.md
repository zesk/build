## `urlFilter`

> Open URLs which appear in a stream

### Usage

    urlFilter [ --show-file ] [ --file name ] [ file ]

Open URLs which appear in a stream
Takes a text file and outputs any `https://` or `http://` URLs found within.
URLs are explicitly trimmed at quote, whitespace and escape boundaries.

### Arguments

- `--show-file` - Boolean. Optional. Show the file name in the output (suffix with `: `)
- `--file name - String. Optional. The file name to display` - can be any text.
- `file` - File. Optional. A file to read and output URLs found.

### Reads standard input

text

### Writes to standard output

line:URL

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

