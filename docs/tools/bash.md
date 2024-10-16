# Bash Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `bashLibrary` - Run or source a library

Run or source a library

- Location: `bin/build/tools/bash.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `bashLibraryHome` - Output the home for a library in the parent path

Output the home for a library in the parent path

- Location: `bin/build/tools/bash.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `bashSanitize` - Sanitize bash files for code quality.

Sanitize bash files for code quality.

Placing a `.debugging` file in your project with a list of permitted files which contain debugging (`set` with `-x`)

- Location: `bin/build/tools/bash.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--` - Flag. Optional. Interactive mode on fixing errors.
- `--home home` - Optional. Directory. Sanitize files starting here. (Defaults to `buildHome`)
- `--interactive` - Flag. Optional. Interactive mode on fixing errors.
- `--check checkDirectory` - Optional. Directory. Check shell scripts in this directory for common errors.
- `...` - Additional arguments are passed to `bashLintFiles` `validateFileContents`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `bashLintFiles` - Check files for the existence of a string

Run `bashLint` on a set of bash files.

- Location: `bin/build/tools/test.sh`

#### Usage

    bashLintFiles [ --exec binary ] [ file0 ... ]
    

#### Arguments

- `--interactive` - Flag. Optional. Interactive mode on fixing errors.
- `--exec binary` - Run binary with files as an argument for any failed files. Only works if you pass in item names.
- `--delay` - Optional. Integer. Delay between checks in interactive mode.
- `findArgs` - Additional find arguments for .sh files (or exclude directories).

#### Examples

    if bashLintFiles; then git commit -m "saving things" -a; fi

#### Sample Output

    This outputs `statusMessage`s to `stdout` and errors to `stderr`.
    

#### Exit codes

- `0` - All found files pass `shellcheck` and `bash -n`
- `1` - One or more files did not pass

#### Environment

This operates in the current working directory
### `bashLint` - Run `shellcheck` and `bash -n` on a set of bash

Run `shellcheck` and `bash -n` on a set of bash files.

This can be run on any directory tree to test scripts in any application.

Shell comments must not be immediately after a function end, e.g. this is invalid:

    myFunc() {
    }
    # Hey

- Location: `bin/build/tools/test.sh`

#### Arguments

- `script` - Shell script to validate

#### Examples

    bashLint goo.sh

#### Sample Output

    This outputs `statusMessage`s to `stdout` and errors to `stderr`.
    

#### Exit codes

- `0` - All found files pass `shellcheck` and `bash -n` and shell comment syntax
- `1` - One or more files did not pass
### `bashSourcePath` - Load a directory of `.sh` files using `source` to make

Load a directory of `.sh` files using `source` to make the code available.
Has security implications. Use with caution and ensure your directory is protected.

- Location: `bin/build/tools/bash.sh`

#### Arguments

- `directory ...` - Required. Directory. Directory to `source` all `.sh` files found.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Deprecated

### `bashLintFilesInteractive` - Run checks interactively until errors are all fixed.

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
