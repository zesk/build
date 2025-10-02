#!/usr/bin/env bash
#
# bash functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/bash.md
# Test: ./test/tools/bash-tests.sh

__bashLoader() {
  __functionLoader __bashGetRequires bash "$@"
}

# Sanitize bash files for code quality.
#
# Usage: {fn} [ --help ] [ --interactive ] [ --check checkDirectory ] ...
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: -- - Flag. Optional. Interactive mode on fixing errors.
# Argument: --home home - Optional. Directory. Sanitize files starting here. (Defaults to `buildHome`)
# Argument: --interactive - Flag. Optional. Interactive mode on fixing errors.
# Argument: --check checkDirectory - Optional. Directory. Check shell scripts in this directory for common errors.
# Argument: ... - Additional arguments are passed to `bashLintFiles` `validateFileContents`
# Placing a `.debugging` file in your project with a list of permitted files which contain debugging (`set` with `-x`)
# Configuration File: .debugging (list of file paths which are ok to allow debugging)
# Configuration File: .check-assertions (location determines check root)
# Configuration File: .skip-lint (file patterns to skip lint check, one per line)
# Configuration File: .skip-copyright (file patterns to skip copyright check, one per line)
# See: buildHome
bashSanitize() {
  __bashLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_bashSanitize() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} script ...
# Argument: script - File. Required. Bash script to fetch requires tokens from.
# Gets a list of the `Requires:` comments in a bash file
# Returns a unique list of tokens
bashGetRequires() {
  __bashLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_bashGetRequires() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} script
# Checks a bash script to ensure all requirements are met, outputs a list of unmet requirements
# Scans a bash script for lines which look like:
#
# Requires: token1 token2
#
# Each requirement token is:
#
# - a bash function which MUST be defined
# - a shell script (executable) which must be present
#
# If all requirements are met, exit status of 0.
# If any requirements are not met, exit status of 1 and a list of unmet requirements are listed
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --ignore prefix. String. Optional. Ignore exact function names.
# Argument: --ignore-prefix prefix. String. Optional. Ignore function names which match the prefix and do not check them.
# Argument: --report - Flag. Optional. Output a report of various functions and handler after processing is complete.
# Argument: --require - Flag. Optional. Requires at least one or more requirements to be listed and met to pass
# Argument: --unused - Flag. Optional. Check for unused functions and report on them.
bashCheckRequires() {
  __bashLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_bashCheckRequires() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List bash buildin functions, one per line
# stdout: line:function
bashBuiltins() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf "%s\n" ":" "." "[" "alias" "bg" "bind" "break" "builtin" "case" "cd" "command" "compgen" "complete" "continue" "declare" "dirs" "disown" "echo" "enable" "eval" "exec" "exit" "export" "fc" "fg" "getopts" \
    "hash" "help" "history" "if" "jobs" "kill" "let" "local" "logout" "popd" "printf" "pushd" "pwd" "read" "readonly" "return" "set" "shift" "shopt" "source" "suspend" "test" "times" "trap" "type" "typeset" \
    "ulimit" "umask" "unalias" "unset" "until" "wait" "while"
}
_bashBuiltins() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: builtin - String. Required. String to check if it's a bash builtin.
# Return Code: 0 - Yes, this string is a bash builtin command.
# Return Code: 1 - No, this is not a bash builtin command
isBashBuiltin() {
  local handler="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || __throwArgument "$handler" "Need builtin" || return $?
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  case "${1-}" in
  ":" | "." | "[" | "alias" | "bg" | "bind" | "break" | "builtin" | "case" | "cd" | "command" | "compgen" | "complete" | "continue" | "declare" | "dirs" | "disown" | "echo" | "enable" | "eval" | "exec" | "exit" | "export" | "fc" | "fg" | "getopts")
    return 0
    ;;
  "hash" | "help" | "history" | "if" | "jobs" | "kill" | "let" | "local" | "logout" | "popd" | "printf" | "pushd" | "pwd" | "read" | "readonly" | "return" | "set" | "shift" | "shopt" | "source" | "suspend" | "test" | "times" | "trap" | "type" | "typeset")
    return 0
    ;;
  "ulimit" | "umask" | "unalias" | "unset" | "until" | "wait" | "while")
    return 0
    ;;
  *)
    return 1
    ;;
  esac
}
_isBashBuiltin() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output the home for a library in the parent path
# Usage: {fn} libraryRelativePath [ startDirectory ]
# Argument: libraryRelativePath - String. Required. Path of file to find from the home directory.
# Argument: startDirectory - Directory. Optional. Place to start searching. Uses `pwd` if not specified.
# stdout: Parent path where `libraryRelativePath` exists
# Example:     libFound=$(bashLibraryHome "bin/watcher/server.py")
bashLibraryHome() {
  local handler="_${FUNCNAME[0]}"
  local home run startDirectory="${2-}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  run=$(usageArgumentString "$handler" "libraryRelativePath" "${1-}") || return $?
  [ -n "$startDirectory" ] || startDirectory=$(__catchEnvironment "$handler" pwd) || return $?
  startDirectory=$(usageArgumentDirectory "$handler" "startDirectory" "$startDirectory") || return $?
  home=$(__catch "$handler" directoryParent --pattern "$run" --test -f --test -x "$startDirectory") || return $?
  printf "%s\n" "$home"
}
_bashLibraryHome() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run or source a library
# Usage: {fn} libraryRelativePath [ command ... ]
# Argument: libraryRelativePath - Path. Required. Path to library source file.
# Argument: command - Callable. Optional. Command to run after loading the library.
bashLibrary() {
  local handler="_${FUNCNAME[0]}"

  local home run="" verboseFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose)
      verboseFlag=true
      ;;
    *)
      run="$argument"
      shift
      break
      ;;
    esac
    shift
  done

  [ -n "$run" ] || __throwArgument "$handler" "Missing libraryRelativePath" || return $?
  home=$(bashLibraryHome "$run") || return $?
  if [ $# -eq 0 ]; then
    export HOME
    # shellcheck source=/dev/null
    source "$home/$run" || __throwEnvironment "$handler" "source ${run//${HOME-}/~} failed" || return $?
    ! $verboseFlag || decorate info "Reloaded $(decorate code "$run") @ $(decorate info "${home//${HOME-}/~}")"
  else
    ! $verboseFlag || decorate info "Running $(decorate file "$home/$run")" "$(decorate each code "$@")"
    __execute "$home/$run" "$@" || return $?
  fi
  return 0
}
_bashLibrary() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: --exclude pattern - Optional. String. String passed to `! -path pattern` in `find`
# Argument: directory ... - Required. Directory. Directory to `source` all `.sh` files used.
# Security: Loads bash files
# Load a directory of `.sh` files using `source` to make the code available.
# Has security implications. Use with caution and ensure your directory is protected.
bashSourcePath() {
  local handler="_${FUNCNAME[0]}"

  local ff=() foundOne=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --exclude)
      shift
      ff+=("!" "-path" "$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    *)
      local path tool

      foundOne=true
      path=$(usageArgumentDirectory "$handler" "directory" "$argument") || return $?
      # shellcheck disable=SC2015
      while read -r tool; do
        local tool="${tool#./}"
        [ -f "$path/$tool" ] || __throwEnvironment "$handler" "$path/$tool is not a bash source file" || return $?
        [ -x "$path/$tool" ] || __throwEnvironment "$handler" "$path/$tool is not executable" || return $?
        # shellcheck source=/dev/null
        source "$path/$tool" || __throwEnvironment "$handler" "source $path/$tool" || return $?
      done < <(cd "$path" && find "." -type f -name '*.sh' ! -path "*/.*/*" "${ff[@]+"${ff[@]}"}" | sort || :)
      ;;
    esac
    shift
  done
  $foundOne || __throwArgument "$handler" "Requires a directory" || return $?
}
_bashSourcePath() {
  # __IDENTICAL__ usageDocumentSimple 1
  usageDocumentSimple "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} functionName file1 ...
# Argument: functionName - String. Required. Name of function to check.
# Argument: file ... - File. Required. One or more files to check if a function is defined within.
bashFunctionDefined() {
  local handler="_${FUNCNAME[0]}"

  local files=() function=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      if [ -z "$function" ]; then
        function="$(usageArgumentString "$handler" "functionName" "${1-}")" || return $?
      else
        files+=("$(usageArgumentFile "$handler" "file" "${1-}")") || return $?
      fi
      ;;
    esac
    shift
  done
  [ -n "$function" ] || __throwArgument "$handler" "functionName is required" || retrun $?
  [ ${#files[@]} -gt 0 ] || __throwArgument "$handler" "Requires at least one file" || retrun $?

  grep -q -e "^\s*$(quoteGrepPattern "$function")() {" "${files[@]}"
}
_bashFunctionDefined() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Pipe to strip comments from a bash file
bashStripComments() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  sed '/^\s*#/d'
}
_bashStripComments() {
  true || bashStripComments --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Show function handler in files
# Argument: functionName - String. Required. Function which should be called somewhere within a file.
# Argument: file - File. Required. File to search for function handler.
# Return Code: 0 - Function is used within the file
# Return Code: 1 - Function is *not* used within the file
# This check is simplistic and does not verify actual coverage or code paths.
# Requires: __throwArgument decorate usageArgumentString usageArgumentFile quoteGrepPattern bashStripComments cat grep
bashShowUsage() {
  local handler="_${FUNCNAME[0]}"

  local functionName="" files=() checkFlags=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --check)
      checkFlags=(-q)
      ;;
    *)
      if [ -z "$functionName" ]; then
        functionName=$(usageArgumentString "$handler" "functionName" "$1") || return $?
      else
        files+=("$(usageArgumentFile "$handler" "file" "$1")") || return $?
      fi
      ;;
    esac
    shift
  done

  local quoted
  quoted=$(quoteGrepPattern "$functionName")
  set +o pipefail
  cat "${files[@]+"${files[@]}"}" | bashStripComments | grep -v "^${quoted}()" | grep "${checkFlags[@]+"${checkFlags[@]}"}" -e "\b${quoted}\b"
}
_bashShowUsage() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List functions in a given shell file
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: file - File. Optional. File(s) to list bash functions defined within.
# Requires: __bashListFunctions __throwArgument decorate usageArgumentFile
bashListFunctions() {
  local handler="_${FUNCNAME[0]}"

  # stdin
  [ $# -gt 0 ] || __bashListFunctions

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      local file
      file=$(usageArgumentFile "$handler" "file" "$1") || return $?
      __bashListFunctions <"$file"
      ;;
    esac
    shift
  done
}
_bashListFunctions() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Actually lists bash functions in a file
# Requires: grep read printf sort
__bashListFunctions() {
  local functionLine
  grep -e "^[A-Za-z_]*[A-Za-z0-9_]*() {$" | while read -r functionLine; do
    functionLine="${functionLine%() {}"
    printf "%s\n" "$functionLine"
  done | sort -u
}

# Argument: source - File. Required. File where the function is defined.
# Argument: functionName - String. Required. The name of the bash function to extract the documentation for.
# Argument: variableName - string. Required. Get this variable value
# Argument: --prefix - flag. Optional. Find variables with the prefix `variableName`
# Gets a list of the variable values from a bash function comment
bashFunctionCommentVariable() {
  local handler="_${FUNCNAME[0]}"

  local source="" functionName="" variableName="" prefixFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --prefix)
      prefixFlag=true
      ;;
    *)
      if [ -z "$source" ]; then
        source="$(usageArgumentFile "$handler" "source" "${1-}")" || return $?
      elif [ -z "$functionName" ]; then
        functionName=$(usageArgumentString "$handler" "functionName" "${1-}") || return $?
      elif [ -z "$variableName" ]; then
        variableName=$(usageArgumentString "$handler" "variableName" "${1-}") || return $?
      fi
      ;;
    esac
    shift
  done

  local matchLine grepSuffix="" trimSuffix=":"
  if $prefixFlag; then
    grepSuffix="[-_[:alnum:]]*"
    trimSuffix=""
  fi
  while read -r matchLine; do
    matchLine="${matchLine#*"$variableName$trimSuffix"}"
    matchLine=${matchLine# }
    printf "%s\n" "${matchLine}"
  done < <(bashFunctionComment "$source" "$functionName" | grep -e "[[:space:]]*$variableName$grepSuffix:[[:space:]]*" | trimSpace || :)
}

_bashFunctionCommentVariable() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Extract a bash comment from a file. Excludes lines containing the following tokens:
#
# - `" IDENTICAL "` or `"_IDENTICAL_"`
# - `"Internal:"` or `"INTERNAL:"`
# - `"DOC TEMPLATE:"`
#
# Argument: source - File. Required. File where the function is defined.
# Argument: lineNumber - String. Required. Previously computed line number of the function.
# Requires: head bashFinalComment
# Requires: __help usageDocument
bashFileComment() {
  local source="${1-}" lineNumber="${2-}"
  __help "_${FUNCNAME[0]}" "$@" || return 0
  head -n "$lineNumber" "$source" | bashFinalComment
}
_bashFileComment() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL bashFunctionComment 41

# Extracts the final comment from a stream
# Requires: fileReverseLines sed cut grep convertValue
bashFinalComment() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  grep -v -e '\( IDENTICAL \|_IDENTICAL_\|DOC TEMPLATE:\|Internal:\|INTERNAL:\)' | fileReverseLines | sed -n -e '1d' -e '/^#/!q; p' | fileReverseLines | cut -c 3- || :
}
_bashFinalComment() {
  false || bashFinalComment --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Extract a bash comment from a file. Excludes lines containing the following tokens:
#
# - `" IDENTICAL "` or `"_IDENTICAL_"`
# - `"Internal:"` or `"INTERNAL:"`
# - `"DOC TEMPLATE:"`
#
# Argument: source - File. Required. File where the function is defined.
# Argument: functionName - String. Required. The name of the bash function to extract the documentation for.
# Requires: grep cut fileReverseLines __help
# Requires: usageDocument
bashFunctionComment() {
  local source="${1-}" functionName="${2-}"
  local maxLines=1000
  __help "_${FUNCNAME[0]}" "$@" || return 0
  grep -m 1 -B $maxLines "^$functionName() {" "$source" | bashFinalComment
  # Explained:
  # - grep -m 1 ... - Finds the `function() {` string in the file and all lines afterwards
  # - grep -v ... - Removes internal documentation and anything we want to hide from the user
  # - fileReverseLines - First reversal to get that comment, file lines are reverse ordered
  # - sed 1d - Deletes the first line (e.g. the `function() { ` which was the LAST thing in the line and is now our first line
  # - sed -n '/^#/!q; p' - `-n` - disables automatic printing. /^#/!q quits when it does not match a '#' comment and prints all `#` lines (effectively outputting just the comment lines)
  # - fileReverseLines - File is back to normal
  # - cut -c 3- - Delete the first 2 characters on each line
}
_bashFunctionComment() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Filter comments from a bash stream
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --only - Optional. Flag. Show ONLY comment lines. (Reverse of lines when not specified.)
# Argument: file - Optional. File. File(s) to filter.
# stdin: a bash file
# stdout: bash file without line-comments `#`
bashCommentFilter() {
  local handler="_${FUNCNAME[0]}"
  local ff=(-v) files=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --only)
      ff=()
      ;;
    *)
      files+=("$(usageArgumentFile "$handler" "file" "$1")") || return $?
      ;;
    esac
    shift
  done

  grepSafe "${ff[@]+"${ff[@]}"}" -e '^[[:space:]]*#' "${files[@]+"${files[@]}"}"
}
_bashCommentFilter() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
