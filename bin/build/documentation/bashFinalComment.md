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

- [fileReverseLines]({rel}tools/file.md#filereverselines) - Reverse output lines ([source](https://github.com/zesk/build/blob/main/bin/build/tools/platform.sh#L106))
- [`sed`]({rel}guide/command.md#sed)
- [`cut`]({rel}guide/command.md#cut)
- [`grep`]({rel}guide/command.md#grep)
- [convertValue]({rel}tools/sugar-core.md#convertvalue) - map a value from one value to another given from-to ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L161))

#### See Also

- [bashFirstComment]({rel}tools/bash.md#bashfirstcomment) - Extract first comment from a stream ([source](https://github.com/zesk/build/blob/main/bin/build/tools/bash.sh#L588))

