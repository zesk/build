### `fileDirectoryRequire`

> Given a list of files, ensure their parent directories exist

#### Usage

    fileDirectoryRequire [ --handler handler ] [ --help ] [ --mode fileMode ] [ --owner ownerName ] fileDirectory ...

Given a list of files, ensure their parent directories exist

Creates the directories for all files passed in.

> Location: `bin/build/tools/directory.sh`

#### Arguments

- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--help` - Flag. Optional. Display this help.
- `--mode fileMode` - String. Optional. Enforce the directory mode for `mkdir --mode` and `chmod`. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to `-` to reset to no value.
- `--owner ownerName` - String. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to `-` to reset to no value.
- `fileDirectory ...` - FileDirectory. Required. Test if file directory exists (file does not have to exist)

#### Examples

    logFile=./.build/$me.log
    fileDirectoryRequire "$logFile"

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [`chmod`]({rel}guide/command.md#chmod)
- {SEE:throwArgument}
- [decorate]({rel}tools/decorate.md#decorate) - decorate text using colors and styles ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L144))
- [catchEnvironment]({rel}tools/sugar-core.md#catchenvironment) - Run \`command\`, upon failure run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L247))
- [`dirname`]({rel}guide/command.md#dirname)

