## `outputTrigger`

> Check output for content and trigger environment error if found

### Usage

    outputTrigger [ --help ] [ --verbose ] [ --name name ] [ message ... ]

Check output for content and trigger environment error if found

### Arguments

- `--help` - Help
- `--verbose` - Flag. Optional. Verbose messages when no errors exist.
- `--name name` - String. Optional. Name for verbose mode.
- `message ...` - Optional. Optional. Message for verbose mode.

### Reads standard input

Any content

### Writes to standard output

Same content

### Examples

    source "$include" > >(outputTrigger source "$include") || return $?

### Return codes

- `0` - If no content is read from `stdin`
- `1` - If any content is read from `stdin` (and output to `stdout`)
- `2` - Argument error

