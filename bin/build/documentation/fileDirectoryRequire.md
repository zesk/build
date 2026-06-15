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

#### Reads standard input

{stdin}

#### Writes to standard output

{stdout}

#### Writes to standard error

{stderr}

#### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

{build_debug}

#### Examples

    logFile=./.build/$me.log
    fileDirectoryRequire "$logFile"


#### Sample Output

{output}

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Local cache

{local_cache}

#### Environment

{environment}

#### Requires

- chmod
- - [throwArgument]({rel}tools/sugar-core.md#throwargument) - Run \`handler\` with an argument error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L215))- [decorate]({rel}tools/decorate.md#decorate) - Singular decoration function ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L89))- [catchEnvironment]({rel}tools/sugar-core.md#catchenvironment) - Run \`command\`, upon failure run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L247))dirname

#### See Also

{see}

#### Credits

Thanks to [{credits}]({source}).

#### Review Status

File `bin/build/tools/directory.sh`, function `fileDirectoryRequire` was reviewed {reviewed}.

#### Errors

{error}
