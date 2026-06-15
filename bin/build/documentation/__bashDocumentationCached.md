### `__bashDocumentationCached`

> Display cached usage for a function

#### Usage

    __bashDocumentationCached handler [ home ] [ functionName ] [ returnCode ] [ message ... ]

Display cached usage for a function

> Location: `bin/build/tools/usage.sh`

#### Arguments

- `handler` - Function. Required.
- `home` - Directory. `BUILD_HOME`
- `functionName` - String. Function to display usage for
- `returnCode - UnsignedInteger. Optional. Exit code to display. Defaults to 0` - no error.
- `message ...` - String. Optional. Display this message which describes why `exitCode` occurred.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- [`BUILD_HOME` Build Home Directory]({rel}env/#build_configuration) – **Directory**. `BUILD_HOME` is `.` when this code is installed - at [`BUILD_COLORS` Build Colors Flag]({rel}env/#decoration) – **Boolean**. If true then colors are shown, blank means guess the [`BUILD_DOCUMENTATION_PATH` Build Documentation Path List]({rel}env/#bash) – **DirectoryList**. Search path for documentation settings file.

#### Requires

- [decorateThemed]({rel}tools/decoration.md#decoratethemed) - Applies the current theme to text rendered using \`decorateThemelessMode\` ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/theme.sh#L70))
- [catchEnvironment]({rel}tools/sugar-core.md#catchenvironment) - Run \`command\`, upon failure run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L247))
- {SEE:__usageMessage}
- [decorate]({rel}tools/decorate.md#decorate) - Singular decoration function ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L89))
- {SEE:__functionSettings}

