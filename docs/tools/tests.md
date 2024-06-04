# Tests Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `validateShellScripts` - Check files for the existence of a string

validateShellScripts

Requires shellcheck so should be later in the testing process to have a cleaner build
This can be run on any directory tree to test scripts in any application.

#### Usage

    validateShellScripts [ --exec binary ] [ file0 ... ]
    

#### Arguments



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

#### Usage

    validateShellScript [ script ... ]
    

#### Arguments



#### Examples

    validateShellScript goo.sh

#### Sample Output

    This outputs `statusMessage`s to `stdout` and errors to `stderr`.
    

#### Exit codes

- `0` - All found files pass `shellcheck` and `bash -n` and shell comment syntax
- `1` - One or more files did not pass

#### Exit codes

- `0` - Always succeeds

### `validateFileExtensionContents` - Check files for the existence of a string

Search for file extensions and ensure that text is found in each file.

This can be run on any directory tree to test files in any application.

By default, any directory which begins with a dot `.` will be ignored.

#### Usage

    validateFileExtensionContents extension0 [ extension1 ... ] -- text0 [ text1 ... ] [ -- findArgs ]
    

#### Arguments



#### Examples

    validateFileContents sh php js -- 'Widgets LLC' 'Copyright &copy; 2024'

#### Exit codes

- `0` - All found files contain all text strings
- `1` - One or more files does not contain all text strings
- `2` - Arguments error (missing extension or text)

#### Environment

This operates in the current working directory

### `validateFileContents` - Check files for the existence of a string or strings

Search for file extensions and ensure that text is found in each file.

This can be run on any directory tree to test files in any application.

By default, any directory which begins with a dot `.` will be ignored.

#### Usage

    validateFileContents file0 [ file1 ... ] -- text0 [ text1 ... ]
    

#### Arguments



#### Examples

    validateFileContents foo.sh my.sh -- "Copyright 2024" "Company, LLC"

#### Exit codes

- `0` - All found files contain all text string or strings
- `1` - One or more files does not contain all text string or strings
- `2` - Arguments error (missing extension or text)

#### Exit codes

- `0` - Always succeeds

#### Usage

    findUncaughtAssertions [ --exec binary ] [ directory ]
    

#### Exit codes

- `0` - Always succeeds

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
