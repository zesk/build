#!/usr/bin/env bash
#
# documentation-index.sh
#
# Generate an index of our bash functions for faster documentation generation.
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/documentation.md
# Test: o ./test/tools/documentation-tests.sh

# Looks up information in the function index
#
# Usage: {fn} [ --settings | --source | --line | --combined | --file ] cacheDirectory lookupPattern
#
# Argument: --settings - `lookupPattern` is a function name. Outputs a file containing function settings
# Argument: --source - `lookupPattern` is a function name. Outputs the source code path to where the function is defined
# Argument: --line - `lookupPattern` is a function name. Outputs the source code line where the function is defined
# Argument: --combined - `lookupPattern` is a function name. Outputs the source code path and line where the function is defined as `path:line`
# Argument: --file - `lookupPattern` is a file name. Find files which match this base file name.
# Argument: cacheDirectory - Directory where we can store cached information
# Argument: lookupPattern - Token to look up in the index
# See: _documentationIndexGenerate
#
__documentationIndexLookup() {
  local handler="$1" && shift
  local mode="settings"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --file) mode="file" ;;
    --combined) mode="combined" ;;
    --settings) mode="settings" ;;
    --source) mode="source" ;;
    --documentation) mode="documentation" ;;
    --line) mode="line" ;;
    *)
      break
      ;;
    esac
    shift
  done
  local indexDirectory cacheDirectory
  indexDirectory="$(__documentationIndexCache)" || return $?
  cacheDirectory="$(documentationBuildCache)" || return $?

  if [ "$mode" = "file" ]; then
    indexRoot="$indexDirectory/files"
    if [ ! -d "$indexRoot" ]; then
      throwEnvironment "$handler" "No file index exists" || return $?
    fi
    if [ ! -f "$indexRoot/$1" ]; then
      return "$(returnCode exit)"
    fi
    cat "$indexRoot/$1"
    return 0
  fi
  if [ "$mode" = "documentation" ]; then
    indexRoot="$cacheDirectory/documentation.index"
    if [ ! -f "$indexRoot" ]; then
      throwEnvironment "$handler" "No documentation index exists" || return $?
    fi
    grep -e "^$(quoteGrepPattern "$1") " "$indexRoot" | removeFields 1 || return 1
    return 0
  fi
  indexRoot="$cacheDirectory/code.index"
  if [ ! -f "$indexRoot" ]; then
    throwEnvironment "$handler" "No index exists" || return $?
  fi
  if [ $# -eq 0 ]; then
    throwArgument "$handler" "${FUNCNAME[0]} cacheDirectory function - missing function" || return $?
  fi
  local functionName filePath lineNumber
  read -r functionName filePath lineNumber < <(grepSafe -m 1 -e "^$1 " <"$indexRoot")
  if [ -z "$functionName" ] || [ -z "$filePath" ] || ! isUnsignedInteger "$lineNumber"; then
    return 1
  fi
  home=$(catchReturn "$handler" buildHome) || return $?
  sourceFile="$home/$filePath"
  case $mode in
  source) printf -- "%s\n" "$sourceFile" ;;
  line) printf -- "%d\n" "$lineNumber" ;;
  combined) printf -- "%s:%d\n" "$sourceFile" "$lineNumber" ;;
  comment) __documentationIndexCommentFile "$handler" "$indexDirectory" "$functionName" bashFileComment "$sourceFile" "$lineNumber" ;;
  settings)
    local commentFile
    commentFile=$(__documentationIndexCommentFile "$handler" "$indexDirectory" "$functionName" bashFileComment "$sourceFile" "$lineNumber") || return $?
    local settingsFile="$indexDirectory/comment/$functionName.settings"
    if [ ! -f "$settingsFile" ] || ! fileIsNewest "$settingsFile" "$commentFile"; then
      __bashDocumentationExtract "$handler" "$functionName" <"$commentFile" >"$settingsFile" || return $?
      __bashDocumentationSettingsFileDetails "$handler" "$sourceFile" "$lineNumber" >>"$settingsFile"
    fi
    printf "%s\n" "$settingsFile"
    ;;
  esac
  return 0
}

__documentationIndexCommentFile() {
  local handler="$1" indexDirectory="$2" functionName="$3" sourceFile="$4" lineNumber="$5" && shift 5
  local commentFile="$indexDirectory/comment/$functionName"
  if [ ! -f "$commentFile" ]; then
    if ! bashFileComment "$sourceFile" "$lineNumber" >"$commentFile"; then
      throwEnvironment "$handler" "$* failed for $functionName" || returnClean $? "$commentFile" || return $?

    else
      printf "%s: %s\n" ":sourceFile" "$sourceFile"
      printf "%s: %s\n" ":sourceLine" "$lineNumber"
    fi
  fi
  printf -- "%s\n" "$commentFile"
}
