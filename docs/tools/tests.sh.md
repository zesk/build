# Tests Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `testShellScripts` - testShellScripts [ findArgs ]

testShellScripts [ findArgs ]

Requires shellcheck so should be later in the testing process to have a cleaner build
This can be run on any directory tree to test scripts in any application.

#### Exit codes

- `0` - Always succeeds

### `validateShellScripts` - Check files for the existence of a string

validateShellScripts

Requires shellcheck so should be later in the testing process to have a cleaner build
This can be run on any directory tree to test scripts in any application.

#### Usage

    validateShellScripts [ findArgs ]

#### Arguments

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

### `validateFileContents` - Check files for the existence of a string

Search for file extensions and ensure that text is found in each file.

This can be run on any directory tree to test files in any application.

By default, any directory which begins with a dot `.` will be ignored.

#### Usage

    validateFileContents extension0 [ extension1 ... ] -- text0 [ text1 ... ] [ -- findArgs ]

#### Arguments

- `extension0 - Required` - the extension to search for (`*.extension`)
- `--` - Required. Separates extensions from text
- `text0` - Required. Text which must exist in each file with the extension given.
- `--` - Optional. Final delimiter to specify find arguments.
- `findArgs` - Optional. Limit find to additional conditions.

#### Exit codes

- `0` - All found files contain all text strings
- `1` - One or more files does not contain all text strings
- `2` - Arguments error (missing extension or text)

#### Environment

This operates in the current working directory

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
