## `urlOpener`

> Open URLs which appear in a stream

### Usage

    urlOpener [ --exec ]

Open URLs which appear in a stream
(but continue to output the stream)

### Arguments

- `--exec` - Executable. Optional. If not supplied uses `urlOpen`.

### Reads standard input

text

### Writes to standard output

text

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

