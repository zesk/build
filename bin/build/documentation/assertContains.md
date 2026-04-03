## `assertContains`

> Assert one string contains another (case-sensitive)

### Usage

    assertContains [ needle ] [ haystack ... ] [ --help ] [ --handler handler ] [ --display ] [ --debug ] [ --line lineNumber ] [ --line-depth depth ] [ --stdout-match ] [ --stdout-no-match ] [ --stderr-ok ] [ --stderr-match ] [ --stderr-no-match ] [ --dump ] [ --dump-binary ] [ --plumber ] [ --leak globalName ] [ --skip-plumber ] [ --head ] [ --tail ]

Assert one string contains another (case-sensitive)

### Arguments

- `needle` - String. Text we are looking for.
- `haystack ... - String. One or more strings to find `needle` in` - it must be found in all haystacks.
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

- `0` - The assertion succeeded
- `1` - Assertion failed
- `2` - Bad arguments

