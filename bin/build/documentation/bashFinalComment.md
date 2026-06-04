### `bashFinalComment`

> Extract final comment from a stream

#### Usage

    bashFinalComment [ --help ]

Extracts the final comment from a stream.
Excludes lines similarly to `bashFirstComment`.

> Location: `bin/build/tools/bash.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- {SEE:fileReverseLines}
- sed
- cut
- grep
- {SEE:convertValue}

#### See Also

- [bashFirstComment]({rel}tools/bash.md#bashfirstcomment) - Extracts the first comment from a stream ([source](https://github.com/zesk/build/blob/main/bin/build/tools/bash.sh#L578))

