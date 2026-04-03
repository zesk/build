## `stringHideNewlines`

> Replace newlines in text with a replacement token for single-line output

### Usage

    stringHideNewlines [ --help ] text [ replace ]

Hide newlines in text (to ensure single-line output or other manipulation)
Without arguments, displays help.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `text` - String. Required. Text to replace.
- `replace` - String. Optional. Replacement string for newlines. Default is `␤`

### Writes to standard output

The text with the newline replaced with another character, suitable typically for single-line output

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

