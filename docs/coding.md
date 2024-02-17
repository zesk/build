# Bash Coding Standards for Zesk Build

[⬅ Return to index](index.md)

So, as we've been coding here it's starting to make sense to follow various patterns in our `bash` coding.

## Always `cd` to the application root somehow

Context is important when running code as is the concept that a script should be able to *self-orient itself* based on its current location to find things. When writing scripts and functions, the intent is that the **current working directory** is initially set to the application root. This is done using `${BASH_SOURCE[0]}` in most scripts to self-orient.

Code:

    errorEnvironment=1

    deployCoolApp() {
        cd "$(dirname "${BASH_SOURCE[0]}")/.." || return $errorEnvironment
    
        if ! source "bin/build/tools.sh"; then
            printf "%s\n" "Unable to load tools.sh" 1>&2
            # was exit, prefer return
            return $errorEnvironment;
        fi
        deployApplication --id "$1" --application /var/www/coolApp --home /var/www/DEPLOY/coolApp "$@"
    }

    deployCoolApp "$@"

Alternately, single-function scripts can invoke Zesk Build Tools directly without any `cd` required:

Code:

    #!/usr/bin/env bash
    "$(dirname "${BASH_SOURCE[0]}")/../bin/build/tools.sh" deployApplication --id "$1" --application /var/www/coolApp --home /var/www/DEPLOY/coolApp

## Always `set -eou pipefail`

All code in Zesk Build has the settings `set -eou pipefail` for all scripts when run internally; the goal being that no errors should ever occur due to these handlers.

Despite having these items set, the standard is to **ALWAYS** check return values for **ALL** `bash` code and explicitly dampen errors using `|| :` when required.

Code will at times look like this:

    doSomeCommand arg1 arg2 "$var3" || return $?
    doAnotherCommand arg1 arg2 "$var2" || return $?

Which terminates the function

## Despite `set -eou pipefail` do not depend on it

Check all return codes **always** and handle all errors **always** for everything in the code, regardless, with a few minor exceptions:

- `bash` code which is guaranteed to succeed
- checking errors on failed operations which are absolutely going to cause an error later and be caught

A simple example is checking errors on `shift` to capture missing arguments:

For example, this is allowed and absolutely fine:

    shift || :
    if [ -z "${1-}" ]; then
      "_${FUNCNAME[0]}" "$errorArgument" "Blank --id"
    fi
    id="$1"

While this gives even more details and is preferred:

    shift || "_${FUNCNAME[0]}" "$errorArgument" "--id id missing" || return $?
    if [ -z "$1" ]; then
      "_${FUNCNAME[0]}" "$errorArgument" "Blank --id"
    fi
    id="$1"

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
       ...
        if somethingFails; then
            _functionName "$errorEnvironment" "Error message why" || return $?
        fi
    }
    _functionName() {
      usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }

Typically any defined function `deployApplication` has a mirror underscore-prefixed `usageDocument` function used for error handling:

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

### Environment errors `errorEnvironment` (Exit Code `1`)

Examples:

- File is not found
- Directories not found
- Files are not where they should be
- Environment values are not configured correctly
- System requirements are not sufficient

Code:

    # IDENTICAL errorEnvironment 1
    errorEnvironment=1

Usage:

    _myCoolFunction "$errorEnvironment" "No deployment application directory exists" || return $?

### Argument errors `errorArgument` (Exit Code `2`)

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

    # IDENTICAL errorArgument 2
    errorArgument=1

    if myFile=$(usageArgumentFile "_${FUNCNAME[0]}" "myFile" "$1"; then
        return $errorArgument
    fi

## Appendix - `simpleBashFunction`

    # A contrived function to show some features and patterns.
    #
    # Usage: {fn} [ --debug ] [ --cleanup ] [ --undo ] [ --id id ] --home home --target target --application application
    # Argument: --debug - Flag. Optional. Debugging mode.
    # Argument: --cleanup - Flag. Optional. Debugging mode.
    # Argument: --undo - Flag. Optional. Debugging mode.
    # Argument: --home homePath - Required. Directory. Home path to show off directory validation.
    # Argument: --target target - Required. File. Target file to show off file validation.
    # Argument: --id id - Optional. String. Just an argument with a value.
    # Argument: --application applicationPath - Required. Directory. Application path to show off directory validation.
    #
    simpleBashFunction() {
      local debuggingFlag cleanupFlag revertFlag homePath target id applicationPath
    
      # --debug
      debuggingFlag=
      # --cleanup
      cleanupFlag=
      # --undo
      revertFlag=
    
      # --home
      homePath=
      # --target
      target=
      # --id
      id=
      # --application
      applicationPath=
    
      while [ $# -gt 0 ]; do
        if [ -z "$1" ]; then
          "_${FUNCNAME[0]}" "$errorArgument" "Blank argument $1" || return $?
        fi
        case "$1" in
          --debug)
            debuggingFlag=1
            ;;
          --cleanup)
            cleanupFlag=1
            ;;
          --revert)
            revertFlag=1
            ;;
          --home)
            shift || :
            if ! homePath=$(usageArgumentDirectory "_${FUNCNAME[0]}" homePath "${1-}"); then
              return "$errorArgument"
            fi
            ;;
          --id)
            shift || "_${FUNCNAME[0]}" "$errorArgument" "--id id missing" || return $?
            if [ -z "$1" ]; then
              "_${FUNCNAME[0]}" "$errorArgument" "Blank --id"
            fi
            id="$1"
            ;;
          --application)
            shift || "_${FUNCNAME[0]}" "$errorArgument" "--application applicationPath missing" || return $?
            if ! applicationPath=$(usageArgumentDirectory "_${FUNCNAME[0]}" application "$1"); then
              return "$errorArgument"
            fi
            ;;
          --target)
            shift || "_${FUNCNAME[0]}" "$errorArgument" "--target target missing" || return $?
            if ! target=$(usageArgumentFile "_${FUNCNAME[0]}" target "$1"); then
              return "$errorArgument"
            fi
            ;;
          *)
            "_${FUNCNAME[0]}" "$errorArgument" "Unknown argument $1" || return $?
            ;;
        esac
        shift || "_${FUNCNAME[0]}" "$errorArgument" "shift failed" || return $?
      done
      # Check arguments are non-blank and actually supplied
      for name in home application target; do
        if [ -z "${!name}" ]; then
          "_${FUNCNAME[0]}" "$errorArgument" "$name is required" || return $?
        fi
      done
    
      consoleNameValue 30 "debuggingFlag" "$debuggingFlag"
      consoleNameValue 30 "cleanupFlag" "$cleanupFlag"
      consoleNameValue 30 "homePath" "$homePath"
      consoleNameValue 30 "revertFlag" "$revertFlag"
      consoleNameValue 30 "homePath" "$homePath"
      consoleNameValue 30 "id" "$id"
      consoleNameValue 30 "applicationPath" "$applicationPath"
      consoleNameValue 30 "target" "$target"
    }
    _simpleBashFunction() {
      usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }


[⬅ Return to index](index.md)
