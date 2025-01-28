# Bash Coding Standards for Zesk Build

[⬅ Return to index](index.md)

So, as we've been coding here it's starting to make sense to follow various patterns in our `bash` coding.

## Use the `example.sh` and `IDENTICAL` tags

Our `example.sh` code is kept up to date and is literally copied regularly for new functions and the `IDENTICAL` functionality helps to keep code synchronized. Use these patterns here in your code as they have been adapted over time.

## `local` stays local

Upon first using `bash` it made sense to put `local` a the top of a function to have them in one place. Unfortunately this leads to moving declarations far away from usages at times and so we have shifted to doing `local` declarations at the scope needed as well as as near to its initial usage as possible. This leads to easier refactorings and better
readability all around.

## Avoid depending on `set -eou pipefail`

Again, this is good for testing scripts but should be avoided in production as it does not work as a good method to catch errors; code should catch errors itself using the `|| return $?` structures you see everywhere.

In short - good for debugging but scripts internally should NOT depend on this behavior unless they set it and unset it.

## Do not leave `set -x` around in code

So much so there is a `pre-commit` filter set up to avoid doing this. (For `.sh` files)

## Avoid exit like the plague

`exit` in bash functions is not recommended largely because it can exit the shell or another program inadvertently when `exit` is called incorrectly or a file is `source`d when it should be run as a subprocess.

The use of `return` to pass exit status is always preferred; and when `exit` is required the addition of a function to wrap it (see above) can avoid `exit` again.

## Clean up after ourselves, `||` statements to fail are more succinct

Use `_clean` and `_undo` to back out of functions. If you create temp files, create them as close as possible to needing them and make sure to delete them on return.

Commands typically are:

    condition || action || _undo $? command ... || _clean $? fileToDelete directoryToDelete || return $?

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

Typically, any defined function `deployApplication` has a mirror underscore-prefixed `usageDocument` function used for error handling:

    deployApplication() {
        ...
    }
    _deployApplication() {
      # _IDENTICAL_ usageDocument 1
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

    tempFile=(__catchEnvironment "$usage" mktemp) || return $?
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
- [`usageArgumentFileDirectory`](./tools/usage.md#usageArgumentFileDirectory) - Argument must be a file which may or may not exist in a directory which exists
- [`usageArgumentDirectory`](./tools/usage.md#usageArgumentDirectory) - Argument must be a directory
- [`usageArgumentRealDirectory`](./tools/usage.md#usageArgumentRealDirectory) - Argument must be a directory and converted to the real path
- [`usageArgumentFile`](./tools/usage.md#usageArgumentFile) - Argument must be a valid file
- [`usageArgumentFileDirectory`](./tools/usage.md#usageArgumentFileDirectory) - Argument must be a file path which is a directory that exists
- [`usageArgumentInteger`](./tools/usage.md#usageArgumentInteger) - Argument must be an integer
- [`usageArgumentPositiveInteger`](./tools/usage.md#usageArgumentPositiveInteger) - Argument must be a positive integer (1 or greater)
- [`usageArgumentUnsignedInteger`](./tools/usage.md#usageArgumentUnsignedInteger) - Argument must be an unsigned integer (0 or greater)
- [`usageArgumentLoadEnvironmentFile`](./tools/usage.md#usageArgumentLoadEnvironmentFile) - Argument must be an environment file which is also loaded immediately.
- [`usageArgumentMissing`](./tools/usage.md#usageArgumentMissing) - Fails with an argument is missing error
- [`usageArgumentString`](./tools/usage.md#usageArgumentString) - Argument must be a non-blank string
- [`usageArgumentEmptyString`](./tools/usage.md#usageArgumentEmptyString) - Argument may be anything
- [`usageArgumentBoolean`](./tools/usage.md#usageArgumentBoolean) - Argument must be a boolean value (`true` or `false`)
- [`usageArgumentEnvironmentVariable`](./tools/usage.md#usageArgumentEnvironmentVariable) - Argument must be a valid environment variable name
- [`usageArgumentURL`](./tools/usage.md#usageArgumentURL) - Argument must be a valid URL
- [`usageArgumentUnknown`](./tools/usage.md#usageArgumentUnknown) - Fails with an unknown argument error
- [`usageArgumentCallable`](./tools/usage.md#usageArgumentCallable) - Argument must be callable (a function or executable)
- [`usageArgumentFunction`](./tools/usage.md#usageArgumentFunction) - Argument must be a function
- [`usageArgumentExecutable`](./tools/usage.md#usageArgumentExecutable) - Argument must be a binary which can be executed

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

    #!/usr/bin/env bash
    #
    # Example code and patterns
    #
    # Copyright &copy; 2025 Market Acumen, Inc.
    #
    # Docs: ./docs/_templates/tools/example.md
    # Test: ./test/tools/example-tests.sh
    
    # Current Code Cleaning:
    #
    # - use `a || b || c || return $?` format when possible
    # - Any code unwrap functions add a `_` to function beginning (see `deployment.sh` for example)
    
    _usageFunction() {
      # _IDENTICAL_ usageDocument 1
      usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }
    
    # IDENTICAL __source 20
    
    # Usage: {fn} source relativeHome  [ command ... ] ]
    # Load a source file and run a command
    # Argument: source - Required. File. Path to source relative to application root..
    # Argument: relativeHome - Required. Directory. Path to application root.
    # Argument: command ... - Optional. Callable. A command to run and optional arguments.
    # Requires: _return
    # Security: source
    __source() {
      local me="${BASH_SOURCE[0]}" e=253
      local here="${me%/*}" a=()
      local source="$here/${2:-".."}/${1-}" && shift 2 || _return $e "missing source" || return $?
      [ -d "${source%/*}" ] || _return $e "${source%/*} is not a directory" || return $?
      [ -f "$source" ] && [ -x "$source" ] || _return $e "$source not an executable file" "$@" || return $?
      while [ $# -gt 0 ]; do a+=("$1") && shift; done
      # shellcheck source=/dev/null
      source "$source" || _return $e source "$source" "$@" || return $?
      [ ${#a[@]} -gt 0 ] || return 0
      "${a[@]}" || return $?
    }
    
    # IDENTICAL __tools 9
    
    # Usage: {fn} [ relativeHome [ command ... ] ]
    # Load build tools and run command
    # Argument: relativeHome - Required. Directory. Path to application root.
    # Argument: command ... - Optional. Callable. A command to run and optional arguments.
    # Requires: __source _return
    __tools() {
      __source bin/build/tools.sh "$@"
    }
    
    # IDENTICAL _return 26
    
    # Usage: {fn} [ exitCode [ message ... ] ]
    # Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
    # Argument: message ... - Optional. String. Message to output to stderr.
    # Exit Code: exitCode
    # Requires: isUnsignedInteger printf _return
    _return() {
      local r="${1-:1}" && shift
      isUnsignedInteger "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
      printf -- "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
    }
    
    # Test if an argument is an unsigned integer
    # Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
    # Credits: F. Hauri - Give Up GitHub (isnum_Case)
    # Original: is_uint
    # Usage: {fn} argument ...
    # Exit Code: 0 - if it is an unsigned integer
    # Exit Code: 1 - if it is not an unsigned integer
    # Requires: _return
    isUnsignedInteger() {
      [ $# -eq 1 ] || _return 2 "Single argument only: $*" || return $?
      case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
    }
    
    # <-- END of IDENTICAL _return
    
    #
    # Usage: {fn}
    # DOC TEMPLATE: --help 1
    # Argument: --help - Optional. Flag. Display this help.
    # Argument: --easy - Optional. Flag. Easy mode.
    # Argument: binary - Required. String. The binary to look for.
    # Argument: remoteUrl - Required. URL. Remote URL.
    # Argument: --target target - Optional. File. File to create. File must exist.
    # Argument: --path path - Optional. Directory. Directory of path of thing.
    # Argument: --title title - Optional. String. Title of the thing.
    # Argument: --name name - Optional. String. Name of the thing.
    # Argument: --url url - Optional. URL. URL to download.
    # Argument: --callable callable - Optional. Callable. Function to call when url is downloaded.
    # This is a sample function with example code and patterns used in Zesk Build.
    #
    exampleFunction() {
      local usage="_${FUNCNAME[0]}"
      local name="" easyFlag=false width=50 target=""
    
      # _IDENTICAL_ argument-case-header 5
      local __saved=("$@") __count=$#
      while [ $# -gt 0 ]; do
        local argument="$1" __index=$((__count - $# + 1))
        [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
        case "$argument" in
          # _IDENTICAL_ --help 4
          --help)
            "$usage" 0
            return $?
            ;;
          --easy)
            easyFlag=true
            ;;
          --name)
            # shift here never fails as [ #$ -gt 0 ]
            shift
            name="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
            ;;
          --path)
            shift
            path="$(usageArgumentDirectory "$usage" "$argument" "${1-}")" || return $?
            ;;
          --target)
            shift
            target="$(usageArgumentFileDirectory "$usage" "$argument" "${1-}")" || return $?
            ;;
          *)
            # _IDENTICAL_ argumentUnknown 1
            __throwArgument "$usage" "unknown #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
            ;;
        esac
        # _IDENTICAL_ argument-esac-shift 1
        shift || __throwArgument "$usage" "missing #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
      done
    
      local start
    
      # IDENTICAL startBeginTiming 1
      start=$(__catchEnvironment "$usage" beginTiming) || return $?
    
    
      # Load MANPATH environment
      export MANPATH
      __catchEnvironment "$usage" buildEnvironmentLoad MANPATH || return $?
    
      ! $easyFlag || __catchEnvironment "$usage" decorate pair "$width" "$name: Easy mode enabled" || return $?
      ! $easyFlag || __catchEnvironment "$usage" decorate pair "path" "$path" || return $?
      ! $easyFlag || __catchEnvironment "$usage" decorate pair "target" "$target" || return $?
    
      # Trouble debugging
    
      whichExists library-which-should-be-there || __throwEnvironment "$usage" "missing thing" || return $?
    
      # DEBUG LINE
      printf -- "%s:%s %s\n" "$(decorate code "${BASH_SOURCE[0]}")" "$(decorate magenta "$LINENO")" "$(decorate each code "$@")" # DEBUG LINE
      reportTiming "$start" "Completed in"
    }
    _exampleFunction() {
      # _IDENTICAL_ usageDocument 1
      usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }
    
    __tools ../.. exampleFunction "$@"
    
    #
    # How to load arguments until -- found
    #
    __testFunction() {
      local exceptions=()
    
      # Load variables until "--" is found
      while [ $# -gt 0 ]; do [ "$1" = "--" ] && shift && break || exceptions+=("$1") && shift; done
      printf "%s\n" "${exceptions[@]+"${exceptions[@]}"}"
    }
    
    # Post-commit hook code
    
    #
    # The `git-post-commit` hook will be installed as a `git` post-commit hook in your project and will
    # overwrite any existing `post-commit` hook.
    #
    # Merges `main` and `staging` and pushes to `origin`
    #
    # fn: {base}
    __hookGitPostCommit() {
      local usage="_${FUNCNAME[0]}"
    
      # _IDENTICAL_ argument-case-header-blank 4
      local __saved=("$@") __count=$#
      while [ $# -gt 0 ]; do
        local argument="$1" __index=$((__count - $# + 1))
        case "$argument" in
          # _IDENTICAL_ --help 4
          --help)
            "$usage" 0
            return $?
            ;;
          *)
            # _IDENTICAL_ argumentUnknown 1
            __throwArgument "$usage" "unknown #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
            ;;
        esac
        # _IDENTICAL_ argument-esac-shift 1
        shift || __throwArgument "$usage" "missing #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
      done
    
      reportTiming "$start" "Completed in"
      __catchEnvironment "$usage" gitInstallHook post-commit || return $?
    
      __catchEnvironment "$usage" gitMainly || return $?
      __catchEnvironment "$usage" git push origin || return $?
    }
    ___hookGitPostCommit() {
      # _IDENTICAL_ usageDocument 1
      usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }
    
    # __tools ../.. __hookGitPostCommit "$@"

[⬅ Return to index](index.md)
