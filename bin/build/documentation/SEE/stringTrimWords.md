## `stringTrimWords`

> Remove words from the end of a phrase

### Usage

    stringTrimWords [ wordCount ] [ word0 ... ]

Remove words from the end of a phrase

> Location: `bin/build/tools/text.sh`

### Arguments

- `wordCount` - PositiveInteger. Words to output
- `word0 ...` - EmptyString. One or more words to output

### Examples

    printf "%s: %s\n" "Summary:" "$(stringTrimWords 10 $description)"

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

