# Bash Coding

It makes sense to follow various patterns in our `bash` coding.

Code here has been written by evolution so older code shows signs of older patterns; know that the intent is to get
everything to the same standard.

## Use the `example.sh` and `IDENTICAL` tags

Our `example.sh` code is kept up to date and is literally copied regularly for new functions and the `IDENTICAL` (and
`_IDENTICAL_`) functionality helps to keep code synchronized. Use these patterns found in the `identical` directories in
your code as they have been adapted over time.

## Validate arguments

For most external functions, validate your argument with an argument spinner:

    while [ $# -gt 0 ]; do
        local argument="$1" 
        case "$argument" in
            --help)
                "$usage" 0
                return $?
                ;;
            *)
                ...
                ;;
        esac
        shift
    done

For internal functions (usually prefixed with one or more underscores `_`)

## `pre-commit` Filters

Run `pre-commit` filters on all code which formats and cleans it up and checks for errors. Every project should have
this TBH. You can add this to any project here by doing:

    `gitInstallHooks`

And then add your own `bin/hooks/pre-commit.sh` to run anything you want on the incoming files.
See [git tools](../tools/git.md) and specifically [`gitPreCommitHasExtension`](../tools/git.md#gitPreCommitHasExtension)
amd [`gitPreCommitListExtension`](../tools/git.md#gitPreCommitListExtension) to process files (this has been already
called when `pre-commit`
is run).

## `local` stays local

Upon first using `bash` it made sense to put `local` a the top of a function to have them in one place. Unfortunately
this leads to moving declarations far away from usages at times and so we have shifted to doing `local` declarations at
the scope needed as well as as near to its initial usage as possible. This leads to easier refactorings and better
readability all around.

## Avoid depending on `set -eou pipefail`

Again, this is good for testing scripts but should be avoided in production as it does not work as a good method to
catch errors; code should catch errors itself using the `|| return $?` structures you see everywhere.

In short - good for debugging but scripts internally should NOT depend on this behavior unless they set it and unset it.

## Do not leave `set -x` around in code

So much so there is a `pre-commit` filter set up to avoid doing this. (For `.sh` files)

## Avoid exit like the plague

`exit` in bash functions is not recommended largely because it can exit the shell or another program inadvertently when
`exit` is called incorrectly or a file is `source`d when it should be run as a subprocess.

The use of `return` to pass exit status is always preferred; and when `exit` is required the addition of a function to
wrap it (see above) can avoid `exit` again.

## Check *all* results

Even commands piped to a file - if the file descriptor becomes invalid or *gasp* the disk becomes full – it will fail.
The sooner it gets handled the cleaner things are.

So just do:

    foo=$(__catchEnvironment "$usage" thingWhichFails) || return $?

or

    __catchEnvironment "$usage" thingWhichFails || return $?

**MOST** of the time. When not to?

- some `statusMessage` and `decorate` calls can be safely ignored
- when the error will occur anyway very soon (next statement or so)

## Clean up after ourselves, `||` statements to fail are more succinct

Use `_clean` and `_undo` to back out of functions. If you create temp files, create them as close as possible to needing
them and make sure to delete them on return.

Commands typically are:

    condition || action || returnUndo $? command ... || returnClean $? fileToDelete directoryToDelete || return $?

## Standard usage and error handling with underscore usage function

Using the `usageDocument` function we can automatically report errors and usage for any `bash` function:

Pattern:

    # Usage: {fn}
    # This describes the usage
    # Argument: file - Required. File. Description of file argument.
    functionName() {
        local usage="_${FUNCNAME[0]}"
       ...
        if ! trySomething; then
            __throwEnvironment "$usage" "Error message why" || return $?
        fi
    }
    _functionName() {
      # _IDENTICAL_ usageDocument 1
      usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }

Typically, any defined function `deployApplication` has a mirror underscore-prefixed `usageDocument` function used for
error handling:

    deployApplication() {
        ...
    }
    _deployApplication() {
      # _IDENTICAL_ usageDocument 1
      usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }

The function signature is identical:

    _usageFunction exitCode [ message ... ]

And it **ALWAYS** returns the `exitCode` passed into it, so you can guaranteed a non-zero exit code will fail and this
pattern will always work:

    _usageFunction "$errorEnvironment" "S N A F U" || return $?

The above code **MUST always** return `$errorEnvironment` - coding your usage function in any other way will cause
problems.

## Standard error codes

Two types of errors prevail in `Zesk Build` and those are:

- **Environment errors** - anything having to do with the system environment, file system, or resources in the system
- **Argument errors** - anything having to do with bash functions being called incorrectly or with the wrong parameters

Additional errors typically extend these two types with more specific information or specific error codes for specific
applications.

### Environment errors (Exit Code `1`)

Examples:

- File is not found
- Directories not found
- Files are not where they should be
- Environment values are not configured correctly
- System requirements are not sufficient

Code:

    return "$(_code environment)"

Usage:

    tempFile=(fileTemporaryName "$usage") || return $?
    __throwEnvironment "$usage" "No deployment application directory exists" || return $?

See:

- [`_environment`](./tools/sugar.md#_environment)
- [`__environment`](./tools/sugar.md#__environment)
- [`__throwEnvironment`](./tools/sugar.md#__throwEnvironment)
- [`__catchEnvironment`](./tools/sugar.md#__catchEnvironment)

### Argument errors (Exit Code `2`)

Examples:

- Missing or blank arguments
- Unknown arguments
- Arguments are formatted incorrectly
- Arguments should be valid directories and are not
- Arguments should be a file path which exists and does not
- Arguments should match a specific pattern
- Invalid argument semantics

Code:

    return "$(_code argument)"

Usage:

    __catchArgument "$usage" isInteger "$argument" || return $?
    __throwArgument "$usage" "No deployment application directory exists" || return $?

### Argument utilities

- [`usageArgumentDirectory`](./tools/usage.md#usageArgumentDirectory) - Argument must be a valid directory
- [`usageArgumentFile`](./tools/usage.md#usageArgumentFile) - Argument must be a valid file
- [`usageArgumentFileDirectory`](./tools/usage.md#usageArgumentFileDirectory) - Argument must be a file which may or may
  not exist in a directory which exists
- [`usageArgumentDirectory`](./tools/usage.md#usageArgumentDirectory) - Argument must be a directory
- [`usageArgumentRealDirectory`](./tools/usage.md#usageArgumentRealDirectory) - Argument must be a directory and
  converted to the real path
- [`usageArgumentFile`](./tools/usage.md#usageArgumentFile) - Argument must be a valid file
- [`usageArgumentFileDirectory`](./tools/usage.md#usageArgumentFileDirectory) - Argument must be a file path which is a
  directory that exists
- [`usageArgumentInteger`](./tools/usage.md#usageArgumentInteger) - Argument must be an integer
- [`usageArgumentPositiveInteger`](./tools/usage.md#usageArgumentPositiveInteger) - Argument must be a positive
  integer (1 or greater)
- [`usageArgumentUnsignedInteger`](./tools/usage.md#usageArgumentUnsignedInteger) - Argument must be an unsigned
  integer (0 or greater)
- [`usageArgumentLoadEnvironmentFile`](./tools/usage.md#usageArgumentLoadEnvironmentFile) - Argument must be an
  environment file which is also loaded immediately.
- [`usageArgumentMissing`](./tools/usage.md#usageArgumentMissing) - Fails with an argument is missing error
- [`usageArgumentString`](./tools/usage.md#usageArgumentString) - Argument must be a non-blank string
- [`usageArgumentEmptyString`](./tools/usage.md#usageArgumentEmptyString) - Argument may be anything
- [`usageArgumentBoolean`](./tools/usage.md#usageArgumentBoolean) - Argument must be a boolean value (`true` or `false`)
- [`usageArgumentEnvironmentVariable`](./tools/usage.md#usageArgumentEnvironmentVariable) - Argument must be a valid
  environment variable name
- [`usageArgumentURL`](./tools/usage.md#usageArgumentURL) - Argument must be a valid URL
- [`usageArgumentUnknown`](./tools/usage.md#usageArgumentUnknown) - Fails with an unknown argument error
- [`usageArgumentCallable`](./tools/usage.md#usageArgumentCallable) - Argument must be callable (a function or
  executable)
- [`usageArgumentFunction`](./tools/usage.md#usageArgumentFunction) - Argument must be a function
- [`usageArgumentExecutable`](./tools/usage.md#usageArgumentExecutable) - Argument must be a binary which can be
  executed

### See

- [Usage functions](./tools/usage.md)
- [`_argument`](./tools/sugar.md#_argument)
- [`__argument`](./tools/sugar.md#__argument)
- [`__throwArgument`](./tools/sugar.md#__throwArgument)
- [`__catchArgument`](./tools/sugar.md#__catchArgument)

Code:

    myFile=$(usageArgumentFile "_${FUNCNAME[0]}" "myFile" "${1-}") || return $?

## Appendix - `simpleBashFunction`

A simple example to show some standard patterns:

{example}

[⬅ Return to index](index.md)
