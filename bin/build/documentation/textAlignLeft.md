## `textAlignLeft`

> align text left

### Usage

    textAlignLeft [ --help ] characterWidth [ text ... ]

Format text and align it left using spaces.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `characterWidth` - UnsignedInteger. Required. Number of characters to align left
- `text ...` - Text to align left.

### Examples

    printf "%s: %s\n" "$(textAlignLeft 14 Name)" "$name"
    printf "%s: %s\n" "$(textAlignLeft 14 Profession)" "$occupation"
    Name          : Tyrone
    Profession    : Engineer

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

