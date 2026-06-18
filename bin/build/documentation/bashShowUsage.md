### `bashShowUsage`

> Show function handler in files

#### Usage

    bashShowUsage functionName file [ --help ]

Show function handler in files
This check is simplistic and does not verify actual coverage or code paths.

> Location: `bin/build/tools/bash.sh`

#### Arguments

- `functionName` - String. Required. Function which should be called somewhere within a file.
- `file` - File. Required. File to search for function handler.
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Function is used within the file
- `1` - Function is *not* used within the file

#### Requires

- [throwArgument]({rel}tools/sugar-core.md#throwargument) - Run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L215))
- [decorate]({rel}tools/decorate.md#decorate) - Singular decoration function ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L89))
- [validate]({rel}tools/validate.md#validate) - Validate a value by type ([source](https://github.com/zesk/build/blob/main/bin/build/tools/validate.sh#L95))
- [quoteGrepPattern]({rel}tools/quote.md#quotegreppattern) - Quote grep -e patterns for shell use ([source](https://github.com/zesk/build/blob/main/bin/build/tools/quote.sh#L34))
- [bashStripComments]({rel}tools/bash.md#bashstripcomments) - Pipe to strip comments from a bash file ([source](https://github.com/zesk/build/blob/main/bin/build/tools/bash.sh#L297))
- [`cat`]({rel}guide/command.md#cat)
- [`grep`]({rel}guide/command.md#grep)

