### `bashRemoveCommentCharacter`

> Remove comment character

#### Usage

    bashRemoveCommentCharacter [ --help ]

Remove comment character and leading spaces from lines.

> Location: `bin/build/tools/bash.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [fileReverseLines]({rel}tools/file.md#filereverselines) - Reverse output lines ([source](https://github.com/zesk/build/blob/main/bin/build/tools/platform.sh#L106))sed
- cut
- grep

