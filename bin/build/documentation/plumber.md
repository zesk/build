### `plumber`

> Run command and detect any global or local leaks

#### Usage

    plumber [ command ... ] [ --temporary tempPath ] [ --leak envName ... ] [ --verbose ] [ --help ]

Run command and detect any global or local leaks

> Location: `bin/build/tools/debug.sh`

#### Arguments

- `command ...` - Callable. Command to run
- `--temporary tempPath` - Directory. Optional. Use this for the temporary path.
- `--leak envName ...` - EnvironmentVariable. Variable name which is OK to leak.
- `--verbose` - Flag. Optional. Be verbose.
- `--help` - Flag. Optional. Display this help.

#### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `plumber-verbose` - The plumber outputs the exact variable captures before and after
- `plumber-verbose` - The plumber outputs the exact variable captures before and after

#### Return codes

- `0` - No leaks detected in the command
- `108` - A leak was detected in the command
- `1` - Argument error, plumber was called incorrectly.

#### Requires

- [`declare`]({rel}guide/builtin.md#declare)
- [`diff`]({rel}guide/command.md#diff)
- [`grep`]({rel}guide/command.md#grep)
- [throwArgument]({rel}tools/sugar-core.md#throwargument) - Run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L215))
- [decorate]({rel}tools/decorate.md#decorate) - decorate text using colors and styles ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L144))
- [validate]({rel}tools/validate.md#validate) - Validate a value by type ([source](https://github.com/zesk/build/blob/main/bin/build/tools/validate.sh#L95))
- [isCallable]({rel}tools/type.md#iscallable) - Test if all arguments are callable as a command ([source](https://github.com/zesk/build/blob/main/bin/build/tools/type.sh#L199))
- [fileTemporaryName]({rel}tools/file.md#filetemporaryname) - Wrapper for \`mktemp\`. Generate a temporary file name, and fail ([source](https://github.com/zesk/build/blob/main/bin/build/tools/file.sh#L944))
- [textRemoveFields]({rel}tools/text.md#textremovefields) - Remove fields from left to right from a text file ([source](https://github.com/zesk/build/blob/main/bin/build/tools/text.sh#L1104))

