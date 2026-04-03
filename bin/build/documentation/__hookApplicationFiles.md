## `hookRun application-files`

> `application-files` hook default implementation

### Usage

    hookRun application-files [ ... ] [ --debug ] [ --not ]

Get a complete list of files which make up an application's state. Should include anything which is code, not design. (fine line)

### Arguments

- `...` - Arguments. Optional. Arguments are passed to the find command.
- `--debug` - Flag. Optional. Show debugging information.
- `--not` - Flag. Optional. Show list of files which are still excluded by APPLICATION_CODE_IGNORE but show files which are NOT included by extension.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

