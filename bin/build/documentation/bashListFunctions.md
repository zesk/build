### `bashListFunctions`

> List functions in a bash file

#### Usage

    bashListFunctions [ --help ] [ file ] [ --help ]

List functions in a given bash file.

> Location: `bin/build/tools/bash.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `file` - File. Optional. File(s) to list bash functions defined within.
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [throwArgument]({rel}tools/sugar-core.md#throwargument) - Run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L215))
- [decorate]({rel}tools/decorate.md#decorate) - decorate text using colors and styles ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L144))
- usageArgumentFile

