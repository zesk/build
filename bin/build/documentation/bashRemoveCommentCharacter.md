## `bashRemoveCommentCharacter`

> Extracts the first comment from a stream

### Usage

    bashRemoveCommentCharacter [ --help ]

Extracts the first comment from a stream

> Location: `bin/build/tools/bash.sh`

### Arguments

- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

- {SEE:fileReverseLines}
- sed
- cut
- grep
- {SEE:convertValue}

