## `isCharacterClasses`

> Does this character match one or more character classes?

### Usage

    isCharacterClasses character [ class ... ] [ --help ]

Does this character match one or more character classes?

### Arguments

- `character` - Required. Single character to test.
- `class ...` - String. Optional. A class name or a character to match. If more than is supplied, a single value must match to succeed (any).
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

