# Tests Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />


### `validateFileContents` - Check files for the existence of a string or strings

Search for item extensions and ensure that text is found in each item.

This can be run on any directory tree to test files in any application.

By default, any directory which begins with a dot `.` will be ignored.

- Location: `bin/build/tools/test.sh`

#### Arguments

- `file0 - Required` - a item to look for matches in. Use `-` to read file list from `stdin`.
- `--` - Required. Separates files from text
- `text0` - Required. Text which must exist in each item

#### Examples

    validateFileContents foo.sh my.sh -- "Copyright 2024" "Company, LLC"

#### Exit codes

- `0` - All found files contain all text string or strings
- `1` - One or more files does not contain all text string or strings
- `2` - Arguments error (missing extension or text)

### `findUncaughtAssertions` - Search bash files for assertions which do not terminate a

Search bash files for assertions which do not terminate a function and are likely an error

- Location: `bin/build/tools/test.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Test Subsystem


#### Arguments

- `--one test` - Optional. Add one test suite to run.
- `--show` - Optional. Flag. List all test suites.
- `-l` - Optional. Flag. List all test suites.
- `--help` - Optional. This help.
- `--clean` - Optional. Delete test artifact files and exit. (No tests run)
- `--continue` - Optional. Flag. Continue from last successful test.
- `-c` - Optional. Flag. Continue from last successful test.
- `--verbose` - Optional. Flag. Be verbose.
- `--coverage - Optional. Flag. Feature in progress` - generate a coverage file for tests.
- `--no-stats` - Optional. Flag. Do not generate a test.stats file showing test timings when completed.
- `--list` - Optional. Flag. List all test names (which match if applicable).
- `--messy` - Optional. Do not delete test artifact files afterwards.
- `--fail executor` - Optional. Callable. One or more programs to run on the failed test files.
- `--env-file environmentFile` - Optional. EnvironmentFile. Load one ore more environment files prior to running tests
- `testFunctionPattern` - Optional. String. Test function (or substring of function name) to run.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Mocking help


### `__mockConsoleAnimation` - Fake `hasConsoleAnimation` for testing

Fake `hasConsoleAnimation` for testing

- Location: `bin/build/tools/colors.sh`

#### Arguments

- `--end` - Flag. Optional. Resets the value for console animation to the saved value.
- true |- ` false` - Boolean. Force the value of hasConsoleAnimation to this value temporarily. Saves the original value.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
