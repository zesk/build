# Bash Coding Standards for Zesk Build

[⬅ Return to index](index.md)

So, as we've been coding here it's starting to make sense to follow various patterns in our `bash` coding.

## NO: Always `cd` to the application root somehow

We no longer require this except for scripts which require it. The recommendation is to `pushd` and `popd` to places you need to go.

## NO: Always `set -eou pipefail`

Again, this is good for testing scripts but should be avoided in production as it does not work as a good method to catch errors; code should catch errors itself using the `|| return $?` structures you see everywhere.

Additionally, use `_clean` and `_undo` to back out of functions.

## Avoid exit like the plague

`exit` in bash functions is not recommended largely because it can exit the shell or another program inadvertently when `exit` is called incorrectly or a file is `source`d when it should be run as a subprocess.

The use of `return` to pass exit status is always preferred; and when `exit` is required the addition of a function to wrap it (see above) can avoid `exit` again.

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
            __failEnvironment "$usage" "Error message why" || return $?
        fi
    }
    _functionName() {
      usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }

Typically, any defined function `deployApplication` has a mirror underscore-prefixed `usageDocument` function used for error handling:

    deployApplication() {
        ...
    }
    _deployApplication() {
      usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }

The function signature is identical:

    _usageFunction exitCode [ message ... ]

And it **ALWAYS** returns the `exitCode` passed into it, so you can guaranteed a non-zero exit code will fail and this pattern will always work:

    _usageFunction "$errorEnvironment" "S N A F U" || return $?

The above code **always** returns `$errorEnvironment` - coding your usage function in any other way will cause problems.

## Standard error codes

Two types of errors prevail in `Zesk Build` and those are:

- Environment errors - anything having to do with the system environment, file system, or resources in the system
- Argument errors - anything having to do with bash functions being called incorrectly or with the wrong parameters

Additional errors typically extend these two types with more specific information or specific error codes for specific applications.

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

    __failEnvironment "$usage" "No deployment application directory exists" || return $?

### Argument errors (Exit Code `2`)

- Missing or blank arguments
- Unknown arguments
- Arguments are formatted incorrectly
- Arguments should be valid directories and are not
- Arguments should be a file path which exists and does not
- Arguments should match a specific pattern
- Invalid argument semantics

#### Argument utilities

- `usageArgumentDirectory` - Argument must be a valid directory
- `usageArgumentFile` - Argument must be a valid file
- `usageArgumentFileDirectory` - Argument must be a file which may or may not exist in a directory which exists

Code:

    myFile=$(usageArgumentFile "_${FUNCNAME[0]}" "myFile" "${1-}") || return $?

## Appendix - `simpleBashFunction`

A simple example to show some patterns:

{example}

[⬅ Return to index](index.md)
