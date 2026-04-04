## `assertFileDoesNotExist`

> Test that a file does not exist

### Usage

    assertFileDoesNotExist item [ message ... ] [ --help ] [ --handler handler ] [ --display ] [ --debug ] [ --line lineNumber ] [ --line-depth depth ] [ --stdout-match ] [ --stdout-no-match ] [ --stderr-ok ] [ --stderr-match ] [ --stderr-no-match ] [ --dump ] [ --dump-binary ] [ --plumber ] [ --leak globalName ] [ --skip-plumber ] [ --head ] [ --tail ]

Test that a file does not exist

### Arguments

- `item` - String. Required. File that should NOT exist
- `message ...` - String. Optional. An error message if this fails
- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--display` - String. Optional. Display name for the condition.
- `--debug` - Flag. Optional. Debugging enabled for the assertion function.
- `--line lineNumber` - Integer. Optional. Line number of calling function. Typically this is not required as it is computed from the calling function using `--line-depth`.
- `--line-depth depth` - Integer. Optional. The depth in the stack of function calls to find the line number of the calling function.
- `--stdout-match` - String. Optional. One or more strings which must match `stdout` output.
- `--stdout-no-match` - String. Optional. One or more strings which must match `stdout` output.
- `--stderr-ok` - Flag. Optional. Output to `stderr` will not cause the test to fail.
- `--stderr-match` - String. Optional. One or more strings which must match `stderr` output. Implies `--stderr-ok`
- `--stderr-no-match` - String. Optional. One or more strings which must match NOT `stderr` output. Implies `--stderr-ok`
- `--dump` - Flag. Optional. Output `stderr` and `stdout` after test regardless.
- `--dump-binary` - Flag. Optional. Output `stderr` and `stdout` after test regardless, displayed as binary.
- `--plumber` - Flag. Optional. Wrap the test call with the `plumber` call to detect local leaks.
- `--leak globalName` - Zero or more. String. Allow global leaks for these globals when `--plumber` is enabled.
- `--skip-plumber` - Flag. Optional. Skip plumber check for function calls. When specified with `--plumber` the last occurrence on the command line is effective.
- `--head` - Flag. Optional. When outputting `stderr` or `stdout`, output the head of the file.
- `--tail` - Flag. Optional. When outputting `stderr` or `stdout`, output the tail of the file. (Default)

### Return codes

- `0` - If the assertion succeeds
- `1` - If the assertion fails

### Environment

- - This fails if `file` is anything at all, even a non-file (such as a link)

### Review Status

File `bin/build/tools/test.sh`, function `assertFileDoesNotExist` was reviewed 2023-11-12
.

