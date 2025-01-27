# Bash Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Loading

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

- `libraryRelativePath` - String. Required. Path of file to find from the home directory.
- `startDirectory` - Directory. Optional. Place to start searching. Uses `pwd` if not specified.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
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

## Linting

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

### `bashCheckDepends` - Checks a bash script to ensure all dependencies are met,

Checks a bash script to ensure all dependencies are met, outputs a list of unmet dependencies
Scans a bash script for lines which look like:


Each dependency token is:

- a bash function which MUST be defined
- a shell script (executable) which must be present

If all dependencies are met, exit status of 0.
If any dependencies are not met, exit status of 1 and a list of unmet dependencies are listed

- Location: `bin/build/tools/bash.sh`

#### Arguments

- `--require` - Flag. Optional. Requires at least one or more dependencies to be listed and met to pass

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Depends

    token1 token2
    

## Debug

### `bashDebugInterruptFile` - Adds a trap to capture the debugging stack on interrupt

Adds a trap to capture the debugging stack on interrupt
Use this in a bash script which runs forever or runs in an infinite loop to
determine where the problem or loop exists.

- Location: `bin/build/tools/debug.sh`

[92mUsage[0m: [38;5;20misMappable[0m [94m[ --prefix ] [94m[ --suffix ] [94m[ --token ] [94m[ text ]

    [94m--prefix  [1;40;97mOptional. String. Token prefix defaults to [1;97;44m{[0m.[0m
    [94m--suffix  [1;40;97mOptional. String. Token suffix defaults to [1;97;44m}[0m.[0m
    [94m--token   [1;40;97mOptional. String. Classes permitted in a token[0m
    [94mtext      [1;40;97mOptional. String. Text to search for mapping tokens.[0m

Check if text contains mappable tokens
If any text passed contains a token which can be mapped, succeed.
#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `bashRecursionDebug` - Place this in code where you suspect an infinite loop

Place this in code where you suspect an infinite loop occurs
It will fail upon a second call; to reset call with `--end`
When called twice, fails on the second invocation and dumps a call stack to stderr.

- Location: `bin/build/tools/debug.sh`

#### Arguments

- `--end` - Flag. Optional. Stop testing for recursion.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

__BUILD_RECURSION

## Simple comment extraction

### `bashFunctionComment` - Extract a bash comment from a file

Extract a bash comment from a file

- Location: `bin/build/identical/bashFunctionComment.sh`

#### Arguments

- `source` - File. Required. File where the function is defined.
- `functionName` - String. Required. The name of the bash function to extract the documentation for.

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
