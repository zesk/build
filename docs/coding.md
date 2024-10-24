# Bash Coding Standards for Zesk Build

[⬅ Return to index](index.md)

So, as we've been coding here it's starting to make sense to follow various patterns in our `bash` coding.

## Avoid depending on `set -eou pipefail`

Again, this is good for testing scripts but should be avoided in production as it does not work as a good method to catch errors; code should catch errors itself using the `|| return $?` structures you see everywhere.

In short - good for debugging but scripts internally should NOT depend on this behavior unless they set it and unset it.

## Clean up after ourselves

Use `_clean` and `_undo` to back out of functions.

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
      # IDENTICAL usageDocument 1
      usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }

Typically, any defined function `deployApplication` has a mirror underscore-prefixed `usageDocument` function used for error handling:

    deployApplication() {
        ...
    }
    _deployApplication() {
      # IDENTICAL usageDocument 1
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

    tempFile=(__usageEnvironment "$usage" mktemp) || return $?
    __failEnvironment "$usage" "No deployment application directory exists" || return $?

See:

- [`_environment`](./tools/sugar.md#_environment)
- [`__environment`](./tools/sugar.md#__environment)
- [`__failEnvironment`](./tools/sugar.md#__failEnvironment)
- [`__usageEnvironment`](./tools/sugar.md#__usageEnvironment)

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

    __usageArgument "$usage" isInteger "$argument" || return $?
    __failArgument "$usage" "No deployment application directory exists" || return $?

### Argument utilities

- [`usageArgumentDirectory`](./tools/usage.md#usageArgumentDirectory) - Argument must be a valid directory
- [`usageArgumentFile`](./tools/usage.md#usageArgumentFile) - Argument must be a valid file
- [`usageArgumentFileDirectory`](./tools/usage.md#usageArgumentFileDirectory) - Argument must be a file which may or may not exist in a directory which exists

### See 

- [`_argument`](./tools/sugar.md#_argument)
- [`__argument`](./tools/sugar.md#__argument)
- [`__failArgument`](./tools/sugar.md#__failArgument)
- [`__usageArgument`](./tools/sugar.md#__usageArgument)


Code:

    myFile=$(usageArgumentFile "_${FUNCNAME[0]}" "myFile" "${1-}") || return $?

## Appendix - `simpleBashFunction`

A simple example to show some patterns:

    #!/usr/bin/env bash
    #
    # Example code and patterns
    #
    # Copyright &copy; 2024 Market Acumen, Inc.
    #
    # Docs: ./docs/_templates/tools/example.md
    # Test: ./test/tools/example-tests.sh
    
    # Current Code Cleaning:
    #
    # - use `a || b || c || return $?` format when possible
    # - Any code unwrap functions add a `_` to function beginning (see `deployment.sh` for example)
    
    # IDENTICAL __source 17
    # Usage: {fn} source relativeHome  [ command ... ] ]
    # Load a source file and run a command
    # Argument: source - Required. File. Path to source relative to application root..
    # Argument: relativeHome - Required. Directory. Path to application root.
    # Argument: command ... - Optional. Callable. A command to run and optional arguments.
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
    
    # IDENTICAL __tools 7
    # Usage: {fn} [ relativeHome [ command ... ] ]
    # Load build tools and run command
    # Argument: relativeHome - Required. Directory. Path to application root.
    # Argument: command ... - Optional. Callable. A command to run and optional arguments.
    __tools() {
      __source bin/build/tools.sh "$@"
    }
    
    # IDENTICAL _return 19
    # Usage: {fn} [ exitCode [ message ... ] ]
    # Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
    # Argument: message ... - Optional. String. Message to output to stderr.
    # Exit Code: exitCode
    _return() {
      local r="${1-:1}" && shift
      _integer "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
      printf "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
    }
    
    # Is this an unsigned integer?
    # Usage: {fn} value
    # Exit Code: 0 - if value is an unsigned integer
    # Exit Code: 1 - if value is not an unsigned integer
    _integer() {
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
      local argument nArguments argumentIndex saved
      local start name easyFlag width
    
      # IDENTICAL startBeginTiming 1
      start=$(__usageEnvironment "$usage" beginTiming) || return $?
    
      width=50
      name=
      easyFlag=false
      target=
      path=
      saved=("$@")
      nArguments=$#
      while [ $# -gt 0 ]; do
        argumentIndex=$((nArguments - $# + 1))
        argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
        case "$argument" in
          # IDENTICAL --help 4
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
            # IDENTICAL argumentUnknown 1
            __failArgument "$usage" "unknown argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
            ;;
        esac
        # IDENTICAL argument-esac-shift 1
        shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
      done
    
      # Load MANPATH environment
      export MANPATH
      __usageEnvironment "$usage" buildEnvironmentLoad MANPATH || return $?
    
      ! $easyFlag || __usageEnvironment "$usage" consoleNameValue "$width" "$name: Easy mode enabled" || return $?
      ! $easyFlag || __usageEnvironment "$usage" consoleNameValue "path" "$path" || return $?
      ! $easyFlag || __usageEnvironment "$usage" consoleNameValue "target" "$target" || return $?
    
      # Trouble debugging
    
      whichExists library-which-should-be-there || __failEnvironment "$usage" "missing thing" || return $?
    
      # DEBUG LINE
      printf -- "%s:%s\n" "$(consoleCode "${BASH_SOURCE[0]}")" "$(consoleMagenta "$LINENO")" # DEBUG LINE
    
      reportTiming "$start" "Completed in"
    }
    _exampleFunction() {
      # IDENTICAL usageDocument 1
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
    
      __usageEnvironment "$usage" gitInstallHook post-commit || return $?
    
      __usageEnvironment "$usage" gitMainly || return $?
      __usageEnvironment "$usage" git push origin || return $?
    }
    ___hookGitPostCommit() {
      # IDENTICAL usageDocument 1
      usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }
    
    # __tools ../.. __hookGitPostCommit "$@"

[⬅ Return to index](index.md)
