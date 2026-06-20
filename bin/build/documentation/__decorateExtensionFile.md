### `__decorateExtensionFile`

> decorate file links

#### Usage

    __decorateExtensionFile [ --no-app ] fileName [ text ]

decorate extension for `file`

> Location: `bin/build/tools/console.sh`

#### Arguments

- `--no-app` - Flag. Optional. Do not map the application path in `decoratePath`
- `fileName` - Required. File path to output.
- `text` - String. Optional. Text to output linked to file.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- [`BUILD_HOME` Build Home Directory]({rel}env/#build_configuration) – **Directory**. `BUILD_HOME` is `.` when this code is installed - at TMPDIR HOME

#### See Also

- [decoratePath]({rel}tools/decoration.md#decoratepath) - Display file paths and replace prefixes with icons ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/path.sh#L21))

