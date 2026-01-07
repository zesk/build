# Bash Coding Patterns

We follow various patterns in our `bash` coding to make life easier. These patterns are adopted to make coding in Bash
less error prone and more enjoyable.

## Clean deprecated code often

Code here has been written by evolution so older code shows signs of older patterns; know that the intent is to get
everything to the same standard. We use `cannon` liberally when changing code so it is considered a best practice to
run this against your code regularly, it must run against the entire codebase and have zero replacements prior to
release.

## Handle even the most mundane errors, love the `||` construct

And yes, talking about worrying about `date` not being installed. Or rather, not within the `PATH`.

The general code pattern should be:

    ! someCondition || catchReturn "$handler" someAction >"$tempFile" || returnUndo $? undoSomeAction || returnClean $? "$tempFile" || return $?

Yes, assignments and assignments within `if` statements capture errors as we want and output errors correctly:

    local home
    home=$(catchReturn "$handler" buildHome) || return $?
    
    if ! item=$(catchReturn "$handler" findItem "$home" "$itemIdentifier"); then
        ...
    fi

Note that usage of `catchReturn`, `catchEnvironment` and `catchArgument` should be used liberally and in front of any
function which is either native or does not have an error handler.

As a general rule, we follow the sense that normal code execution follows a string of `true` patterns on each line
unless it exits the function.

Remember that the `||` often reverses the logic in this case, so:

    [ ! -f "$f" ] || catchReturn "$handler" processTheFile "$f" || return $?

An `if` statement uses the reverse logic:

    if [ -f "$f" ]; then catchReturn "$handler" processTheFile "$f" || return $?; fi

The first version is preferred due to brevity, but either can be used and in many cases an `if` works best.

## Clean up after ourselves

Always delete temporary files and write tests which monitor the entire file system to ensure that all successes and
failures do not leave stray artifacts.

In cases where clean up is impossible, document that temporary directories will be polluted to
ensure that clean up occurs either by a background or maintenance task or by the operating system on reboot.

Our tests run `housekeeper` on the main project directory as well as the temporary directory *for all tests* so all
functions (unless marked otherwise) do not leak files.

## Be strict about local leaks

Bash has the problem that any variable declared anywhere, unless it is *explicitly* marked as `local` is then added to
the global scope. As a mundane example:

    logger() {
        for f in LOG_FILE EXTRA_LOG_FILE; do
            [ ! -f "${!f}" ] || printf "%s\n" "$@" >>"$f"
        done
    }

See the issue? `f` is leaked to the global scope. While in most cases not an issue, it's considered a bad practice and
as such all functions (unless they explicitly modify environment variables) are checked with the `plumber` function to
ensure they do not leak variables.

## Error Handlers via underscore functions

Simply this pattern is that every function which is exported has an error handler function which is the same name
prefixed with an underscore:

    usefulThing() {
      local handler="_${FUNCNAME[0]}"
      ...
       catchEnvironment "$handler" ...
    }
    _usefulThing() {
      # __IDENTICAL__ usageDocument 1
      usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }

The underscore error handler acts as an effective "pointer" which allows us to reference the source document where the
function resides and then do some magic to automatically output the documentation for a function.

## Use the `example.sh` and `IDENTICAL` tags

Our `example.sh` code is kept up to date and is literally copied regularly for new functions and the `IDENTICAL` (and
`_IDENTICAL_`/`__IDENTICAL__`) functionality helps to keep code synchronized. Use these patterns found in the
`identical` directories in your code as they have been adapted over time.

## Validate arguments

For most external functions, validate your argument with an argument spinner:

    # _IDENTICAL_ argumentNonBlankLoopHandler 6
    local __saved=("$@") __count=$#
    while [ $# -gt 0 ]; do
        local argument="$1" __index=$((__count - $# + 1))
        # __IDENTICAL__ __checkBlankArgumentHandler 1
        [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
        case "$argument" in
            # _IDENTICAL_ helpHandler 1
            --help) "$handler" 0 && return $? || return $? ;;
            *)
                ...
                ;;
        esac
        shift
    done

For internal functions (usually prefixed with one or more underscores `_`) we assume inputs have already been validated
in many cases.

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

Upon first using `bash` it made sense to put `local` at the top of a function to have them in one place. Unfortunately
this leads to moving declarations far away from usages at times and so we have shifted to doing `local` declarations at
the scope needed as well as **as near to its initial usage** as possible. This leads to easier refactorings and better
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

## Check *all* results*

Even commands piped to a file - if the file descriptor becomes invalid or *gasp* the disk becomes full – it will fail.
The sooner it gets handled the cleaner things are.

So just do:

    foo=$(catchEnvironment "$handler" thingWhichFails) || return $?

or

    catchEnvironment "$handler" thingWhichFails || return $?

**MOST** of the time. When not to?

- `printf` command is internal and we assume it rarely if never fails
- some `statusMessage` and `decorate` calls can be safely ignored
- when the error will occur anyway very soon (next statement or so)

## Clean up after ourselves, `||` statements to fail are more succinct

Use `returnClean` and `returnUndo` to back out of functions. If you create temp files, create them as close as possible
to needing them and make sure to delete them prior to returning (unless part of a cache, for example.)

Commands typically are:

    condition || action || returnUndo $? undoActionCommand ... || returnClean $? fileToDelete directoryToDelete || return $?

## Standard handler and error handling with underscore handler function

Using the `usageDocument` function we can automatically report errors and handler for any `bash` function:

Pattern:

    # This describes the function's operation
    # Argument: file - Required. File. Description of file argument.
    functionName() {
        local handler="_${FUNCNAME[0]}"
       ...
        if ! trySomething; then
            throwEnvironment "$handler" "Error message why" || return $?
        fi
    }
    _functionName() {
      # __IDENTICAL__ usageDocument 1
      usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }

Typically, any defined function `deployApplication` has a mirror underscore-prefixed `usageDocument` function used for
error handling:

    deployApplication() {
        ...
    }
    _deployApplication() {
      # __IDENTICAL__ usageDocument 1
      usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }

Our handler function signature is identical:

    _usageFunction returnCode [ message ... ]

And it **ALWAYS** returns the `returnCode` passed into it, so you can guarantee a non-zero return code will fail and
this
pattern will always work:

    _usageFunction "1" "S N A F U" || return $?

The above code **MUST always** return `1` - **coding your handler function in any other way** is
unsupported and will cause problems.

## Use `__functionLoader` for more complex code

Zesk Build has grown in size over time and as such it makes sense to not load *the entire codebase* unless needed.

The function `__functionLoader` was added which runs an internal function which checks whether a primary function is
defined, and if it is NOT it then loads an entire directory at `./bin/build/tools/libraryName` where `libraryName` is
specified by the calling function. The pattern used here is a *loader function* defined in each module:

    __awsLoader() {
        __functionLoader __awsInstall aws "$@"
    }

And then the actual implementation for a function consists of:

    awsInstall() {
        __awsLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
    }

The arguments passed are the error handler (`_awsInstall` here as expanded via `${FUNCNAME[0]}`), and the actual
function to call (`__awsInstall` - defined in `./bin/build/tools/aws/install.sh`)

This allows us to defer loading of entire modules of code until needed.

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

handler:

    tempFile=(fileTemporaryName "$handler") || return $?
    throwEnvironment "$handler" "No deployment application directory exists" || return $?

See:

- [`_environment`](../tools/sugar.md#_environment)
- [`__environment`](../tools/sugar.md#__environment)
- [`throwEnvironment`](../tools/sugar.md#throwenvironment)
- [`catchEnvironment`](../tools/sugar.md#catchenvironment)

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

handler:

    catchArgument "$handler" isInteger "$argument" || return $?
    throwArgument "$handler" "No deployment application directory exists" || return $?

### Argument utilities

These will be replaced with [`validate`](../tools/validate.md) commands in an upcoming release.

- [`usageArgumentDirectory`](../tools/handler.md#usageArgumentDirectory) - Argument must be a valid directory
- [`usageArgumentFile`](../tools/handler.md#usageArgumentFile) - Argument must be a valid file
- [`usageArgumentFileDirectory`](../tools/handler.md#usageArgumentFileDirectory) - Argument must be a file which may or
  may
  not exist in a directory which exists
- [`usageArgumentDirectory`](../tools/handler.md#usageArgumentDirectory) - Argument must be a directory
- [`usageArgumentRealDirectory`](../tools/handler.md#usageArgumentRealDirectory) - Argument must be a directory and
  converted to the real path
- [`usageArgumentFile`](../tools/handler.md#usageArgumentFile) - Argument must be a valid file
- [`usageArgumentFileDirectory`](../tools/handler.md#usageArgumentFileDirectory) - Argument must be a file path which is
  a
  directory that exists
- [`usageArgumentInteger`](../tools/handler.md#usageArgumentInteger) - Argument must be an integer
- [`usageArgumentPositiveInteger`](../tools/handler.md#usageArgumentPositiveInteger) - Argument must be a positive
  integer (1 or greater)
- [`usageArgumentUnsignedInteger`](../tools/handler.md#usageArgumentUnsignedInteger) - Argument must be an unsigned
  integer (0 or greater)
- [`usageArgumentLoadEnvironmentFile`](../tools/handler.md#usageArgumentLoadEnvironmentFile) - Argument must be an
  environment file which is also loaded immediately.
- [`usageArgumentString`](../tools/handler.md#usageArgumentString) - Argument must be a non-blank string
- [`usageArgumentEmptyString`](../tools/handler.md#usageArgumentEmptyString) - Argument may be anything
- [`usageArgumentBoolean`](../tools/handler.md#usageArgumentBoolean) - Argument must be a boolean value (`true` or
  `false`)
- [`usageArgumentEnvironmentVariable`](../tools/handler.md#usageArgumentEnvironmentVariable) - Argument must be a valid
  environment variable name
- [`usageArgumentURL`](../tools/handler.md#usageArgumentURL) - Argument must be a valid URL
- [`usageArgumentCallable`](../tools/handler.md#usageArgumentCallable) - Argument must be callable (a function or
  executable)
- [`usageArgumentFunction`](../tools/handler.md#usageArgumentFunction) - Argument must be a function
- [`usageArgumentExecutable`](../tools/handler.md#usageArgumentExecutable) - Argument must be a binary which can be
  executed

### See

- [Usage functions](../tools/usage.md)
- [`_argument`](../tools/sugar.md#_argument)
- [`__argument`](../tools/sugar.md#__argument)
- [`throwArgument`](../tools/sugar.md#throwargument)
- [`catchArgument`](../tools/sugar.md#catchargument)

Code:

    myFile=$(usageArgumentFile "_${FUNCNAME[0]}" "myFile" "${1-}") || return $?

## `read` loops the right way

Instead of:

    while read -r item; do
        # something with item
    done 

Try:

    local finished=false
    while ! $finished; do
        local item
        read -r item || finished=true
        [ -n "$item" ] || continue
        # something with item
    done

This handles lines and **content without a trailing newline** better.

The first version is permitted when you can absolutely guarantee that **each line has a newline**.

## Appendix - `simpleBashFunction`

A simple example to show some standard patterns:

{example}

[⬅ Return to index](index.md)
