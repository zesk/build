## `decorate wrap`

> Prefix output lines with a string

### Usage

    decorate wrap prefix [ suffix ] [ --fill fillCharacter ]

Wrap lines with a string, useful to format output or add color codes to
consoles which do not honor colors line-by-line. Intended to be used as a pipe.

### Arguments

- `prefix` - EmptyString. Required. Prefix each line with this text
- `suffix` - String. Optional. Prefix each line with this text
- `--fill fillCharacter` - Character. Optional. Fill entire line with this character.

### Examples

    cat "$file" | decorate wrap "CODE> " " <EOL>"
    cat "$errors" | decorate wrap "    ERROR: [" "]"

### Return codes

- `0` - stdout contains input wrapped with text
- `1` - Environment error
- `2` - Argument error

