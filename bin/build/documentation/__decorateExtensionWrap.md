### `decorate wrap`

> Prefix output lines with a string

#### Usage

    decorate wrap [ --help ] [ --fill fillCharacter ] [ --width fillWidth ] prefix [ suffix ... ]

Wrap lines with a string, useful to format output or add color codes to
consoles which do not honor colors line-by-line. Intended to be used as a pipe.

> Location: `bin/build/tools/decorate/wrap.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `--fill fillCharacter` - Character. Optional. Fill entire line with this character.
- `--width fillWidth` - UnsignedInteger. Optional. Line width to fill with `fillCharacter`.
- `prefix` - EmptyString. Required. Prefix each line with this text
- `suffix ...` - String. Optional. Prefix each line with this text

#### Examples

    cat "$file" | decorate wrap "CODE> " " <EOL>"
    cat "$errors" | decorate wrap "    ERROR: [" "]"

#### Return codes

- `0` - stdout contains input wrapped with text
- `1` - Environment error
- `2` - Argument error

