## `fileDirectoryRequire`

> Given a list of files, ensure their parent directories exist

### Usage

    fileDirectoryRequire [ --handler handler ] [ --help ] [ --mode fileMode ] [ --owner ownerName ] fileDirectory ...

Given a list of files, ensure their parent directories exist
Creates the directories for all files passed in.

### Arguments

- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--help` - Flag. Optional. Display this help.
- `--mode fileMode` - String. Optional. Enforce the directory mode for `mkdir --mode` and `chmod`. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to `-` to reset to no value.
- `--owner ownerName` - String. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to `-` to reset to no value.
- `fileDirectory ...` - FileDirectory. Required. Test if file directory exists (file does not have to exist)

### Examples

    logFile=./.build/$me.log
    fileDirectoryRequire "$logFile"

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

