#!/usr/bin/env bash
#
# bash functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./docs/_templates/tools/bash.md
# Test: ./test/tools/bash-tests.sh

# Output the home for a library in the parent path
# Usage: {fn} libraryRelativePath [ startDirectory ]
# Argument: libraryRelativePath - String. Required. Path of file to find from the home directory.
# Argument: startDirectory - Directory. Optional. Place to start searching. Uses `pwd` if not specified.
# stdout: Parent path where `libraryRelativePath` exists
# Example:     libFound=$(bashLibraryHome "bin/watcher/server.py")
bashLibraryHome() {
  local usage="_${FUNCNAME[0]}"
  local home run startDirectory="${2-}"
  run=$(usageArgumentString "$usage" "libraryRelativePath" "${1-}") || return $?
  [ -n "$startDirectory" ] || startDirectory=$(__catchEnvironment "$usage" pwd) || return $?
  startDirectory=$(usageArgumentDirectory "$usage" "startDirectory" "$startDirectory") || return $?
  home=$(__catchEnvironment "$usage" directoryParent --pattern "$run" --test -f --test -x "$startDirectory") || return $?
  printf "%s\n" "$home"
}
_bashLibraryHome() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run or source a library
# Usage: {fn} libraryRelativePath [ command ... ]
bashLibrary() {
  local usage="_${FUNCNAME[0]}"

  local home run="" verboseFlag=false

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --verbose)
        verboseFlag=true
        ;;
      *)
        run="$argument"
        shift
        break
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "$run" ] || __throwArgument "$usage" "Missing libraryRelativePath" || return $?
  home=$(bashLibraryHome "$run") || return $?
  if [ $# -eq 0 ]; then
    export HOME
    # shellcheck source=/dev/null
    source "$home/$run" || __throwEnvironment "$usage" "source ${run//${HOME-}/~} failed" || return $?
    ! $verboseFlag || decorate info "Reloaded $(decorate code "$run") @ $(decorate info "${home//${HOME-}/~}")"
  else
    ! $verboseFlag || decorate info "Running $(decorate file "$home/$run")" "$(decorate each code "$@")"
    __execute "$home/$run" "$@" || return $?
  fi
  return 0
}
_bashLibrary() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} [ directory ... ]
# Argument: directory ... - Required. Directory. Directory to `source` all `.sh` files used.
# Security: Loads bash files
# Load a directory of `.sh` files using `source` to make the code available.
# Has security implications. Use with caution and ensure your directory is protected.
bashSourcePath() {
  local usage="_${FUNCNAME[0]}"

  [ $# -gt 0 ] || __throwArgument "$usage" "Requires a directory" || return $?

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        local path
        path=$(usageArgumentDirectory "$usage" "directory" "$argument") || return $?
        # shellcheck disable=SC2015
        while read -r tool; do
          local tool="${tool#./}"
          [ -f "$path/$tool" ] || __throwEnvironment "$usage" "$path/$tool is not a bash source file" || return $?
          [ -x "$path/$tool" ] || __throwEnvironment "$usage" "$path/$tool is not executable" || return $?
          # shellcheck source=/dev/null
          source "$path/$tool" || __throwEnvironment "$usage" "source $path/$tool" || return $?
        done < <(cd "$path" && find "." -type f -name '*.sh' ! -path "*/.*/*" || :)
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
}
_bashSourcePath() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} functionName file1 ...
bashFunctionDefined() {
  local usage="_${FUNCNAME[0]}"

  local files=() function=""

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        if [ -z "$function" ]; then
          function="$(usageArgumentString "$usage" "functionName" "${1-}")" || return $?
        else
          files+=("$(usageArgumentFile "$usage" "file" "${1-}")") || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  [ -n "$function" ] || __throwArgument "$usage" "functionName is required" || retrun $?
  [ ${#files[@]} -gt 0 ] || __throwArgument "$usage" "Requires at least one file" || retrun $?

  grep -q -e "^$(quoteGrepPattern "$function")() {" "${files[@]}"
}
_bashFunctionDefined() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Pipe to strip comments from a bash file
bashStripComments() {
  sed '/^\s*#/d'
}

# Show function usage in files
# Argument: functionName - String. Required. Function which should be called somewhere within a file.
# Argument: file - File. Required. File to search for function usage.
# Exit code: 0 - Function is used within the file
# Exit code: 1 - Function is *not* used within the file
# This check is simplistic and does not verify actual coverage or code paths.
# Requires: __throwArgument decorate usageArgumentString usageArgumentFile quoteGrepPattern bashStripComments cat grep
bashShowUsage() {
  local usage="_${FUNCNAME[0]}"

  local functionName="" files=() checkFlags=()

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --check)
        checkFlags=(-q)
        ;;
      *)
        if [ -z "$functionName" ]; then
          functionName=$(usageArgumentString "$usage" "functionName" "$1") || return $?
        else
          files+=("$(usageArgumentFile "$usage" "file" "$1")") || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  local quoted
  quoted=$(quoteGrepPattern "$functionName")
  set +o pipefail
  cat "${files[@]+"${files[@]}"}" | bashStripComments | grep -v "^${quoted}()" | grep "${checkFlags[@]+"${checkFlags[@]}"}" -e "\b${quoted}\b"
}
_bashShowUsage() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List functions in a given shell file
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: file - File. Optional. File(s) to list bash functions defined within.
# Requires: __bashListFunctions __throwArgument decorate usageArgumentFile
bashListFunctions() {
  local usage="_${FUNCNAME[0]}"

  # stdin
  [ $# -gt 0 ] || __bashListFunctions

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        local file
        file=$(usageArgumentFile "$usage" "file" "$1") || return $?
        __bashListFunctions <"$file"
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
}
_bashListFunctions() {
  # _IDENTICAL_ usageDocument 1
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

# IDENTICAL bashFunctionComment 18

# Extract a bash comment from a file
# Argument: source - File. Required. File where the function is defined.
# Argument: functionName - String. Required. The name of the bash function to extract the documentation for.
# Requires: grep cut reverseFileLines __help
# Requires: usageDocument
bashFunctionComment() {
  local source="${1-}" functionName="${2-}"
  local maxLines=1000
  __help "_${FUNCNAME[0]}" "$@" || return 0
  grep -m 1 -B $maxLines "$functionName() {" "$source" | grep -v -e '( IDENTICAL | _IDENTICAL_ |DOC TEMPLATE:|Internal:)' |
    reverseFileLines | grep -B "$maxLines" -m 1 -E '^\s*$' |
    reverseFileLines | grep -E '^#' | cut -c 3-
}
_bashFunctionComment() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
