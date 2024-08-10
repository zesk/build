# Tests Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `validateShellScripts` - Check files for the existence of a string

validateShellScripts

Requires shellcheck so should be later in the testing process to have a cleaner build
This can be run on any directory tree to test scripts in any application.

- Location: `bin/build/tools/test.sh`

#### Usage

    validateShellScripts [ --exec binary ] [ file0 ... ]
    

#### Arguments

- `--interactive` - Flag. Optional. Interactive mode on fixing errors.
- `--exec binary` - Run binary with files as an argument for any failed files. Only works if you pass in item names.
- `--delay` - Optional. Integer. Delay between checks in interactive mode.
- `findArgs` - Additional find arguments for .sh files (or exclude directories).

#### Examples

    if validateShellScripts; then git commit -m "saving things" -a; fi

#### Sample Output

    This outputs `statusMessage`s to `stdout` and errors to `stderr`.
    

#### Exit codes

- `0` - All found files pass `shellcheck` and `bash -n`
- `1` - One or more files did not pass

#### Environment

This operates in the current working directory
### `validateShellScript` - Requires shellcheck so should be later in the testing process

Requires shellcheck so should be later in the testing process to have a cleaner build
This can be run on any directory tree to test scripts in any application.
Shell comments must not be immediately after a function end, e.g. this is invalid:

    myFunc() {
    }
    # Hey

- Location: `bin/build/tools/test.sh`

#### Arguments

- `script` - Shell script to validate

#### Examples

    validateShellScript goo.sh

#### Sample Output

    This outputs `statusMessage`s to `stdout` and errors to `stderr`.
    

#### Exit codes

- `0` - All found files pass `shellcheck` and `bash -n` and shell comment syntax
- `1` - One or more files did not pass
### `validateShellScriptsInteractive` - Run checks interactively until errors are all fixed.

Run checks interactively until errors are all fixed.

- Location: `bin/build/tools/test.sh`

#### Usage

    [ fileToCheck ... ]
    

#### Arguments

- `--exec binary` - Optional. Callable. Run binary with files as an argument for any failed files. Only works if you pass in item names.
- `--delay delaySeconds` - Optional. Integer. Delay in seconds between checks in interactive mode.
- `fileToCheck ...` - Optional. File. Shell file to validate.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `validateFileExtensionContents` - Check files for the existence of a string

Search for item extensions and ensure that text is found in each item.

This can be run on any directory tree to test files in any application.

By default, any directory which begins with a dot `.` will be ignored.

- Location: `bin/build/tools/test.sh`

#### Usage

    validateFileExtensionContents extension0 [ extension1 ... ] -- text0 [ text1 ... ] [ -- findArgs ]
    

#### Arguments

- `extension0 - Required` - the extension to search for (`*.extension`)
- `--` - Required. Separates extensions from text
- `text0` - Required. Text which must exist in each item with the extension given.
- `--` - Optional. Final delimiter to specify find arguments.
- `findArgs` - Optional. Limit find to additional conditions.

#### Examples

    validateFileContents sh php js -- 'Widgets LLC' 'Copyright &copy; 2024'

#### Exit codes

- `0` - All found files contain all text strings
- `1` - One or more files does not contain all text strings
- `2` - Arguments error (missing extension or text)

#### Environment

This operates in the current working directory
### `validateFileContents` - Check files for the existence of a string or strings

Search for item extensions and ensure that text is found in each item.

This can be run on any directory tree to test files in any application.

By default, any directory which begins with a dot `.` will be ignored.

- Location: `bin/build/tools/test.sh`

#### Arguments

- `file0 - Required` - a item to look for matches in
- `--` - Required. Separates files from text
- `text0` - Required. Text which must exist in each item

#### Examples

    validateFileContents foo.sh my.sh -- "Copyright 2024" "Company, LLC"

#### Exit codes

- `0` - All found files contain all text string or strings
- `1` - One or more files does not contain all text string or strings
- `2` - Arguments error (missing extension or text)
#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Test Subsystem

### `testTools` - Load test tools and make `testSuite` function available

Load test tools and make `testSuite` function available

- Location: `bin/build/tools/test.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `binary` - Optional. Callable. Run this program after loading test tools.
- `...` - Optional. Arguments for binary.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
#### Arguments

- `--one test` - Optional. Add one test suite to run.
- `--show` - Optional. Flag. List all test suites.
- `-l` - Optional. Flag. List all test suites.
- `--help` - Optional. This help.
- `--clean` - Optional. Delete test artifact files and exit. (No tests run)
- `--continue` - Optional. Flag. Continue from last successful test.
- `-c` - Optional. Flag. Continue from last successful test.
- `--messy` - Optional. Do not delete test artifact files afterwards.
- `--fail executor` - Optional. Callable. One or more programs to run on the failed test files.
- `testFunctionPattern` - Optional. String. Test function (or substring of function name) to run.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
