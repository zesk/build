## `dumpPipe`

> Dump a pipe with a title and stats

### Usage

    dumpPipe [ --symbol symbol ] [ --tail ] [ --head ] [ --lines ] [ --vanish file ] [ name ]

Dump a pipe with a title and stats

### Arguments

- `--symbol symbol` - String. Optional. Symbol to place before each line. (Blank is ok).
- `--tail` - Flag. Optional. Show the tail of the file and not the head when not enough can be shown.
- `--head` - Flag. Optional. Show the head of the file when not enough can be shown. (default)
- `--lines` - UnsignedInteger. Optional. Number of lines to show.
- `--vanish file` - UnsignedInteger. Optional. Number of lines to show.
- `name` - String. Optional. The item name or title of this output.

### Reads standard input

text

### Writes to standard output

formatted text for debugging

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

