#!/usr/bin/env bash
#
# documentation-index.sh
#
# Generate an index of our bash funtions for faster documentation generation.
#
# Copyright: Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh text.sh prefixLines
#
# Docs: o ./docs/_templates/tools/documentation.md
# Test: o ./test/tools/documentation-tests.sh

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

errorNotFound=3

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
# See: documentationFunctionIndex
#
documentationFunctionLookup() {
  local mode cacheDirectory shellFile functionName lineNumber indexRoot sourceFile resultFile

  cacheDirectory=
  mode=settings
  while [ $# -gt 0 ]; do
    case "$1" in
      --file) mode="file" ;;
      --combined) mode="combined" ;;
      --settings) mode="settings" ;;
      --source) mode="source" ;;
      --line) mode="line" ;;
      *)
        if [ -z "$cacheDirectory" ]; then
          cacheDirectory="${1%%/}"
          shift || return "$errorArgument"
          if ! cacheDirectory="$(_documentationFunctionIndexPath "$cacheDirectory")"; then
            return $?
          fi
        fi
        break
        ;;
    esac
    shift
  done
  if [ -z "$cacheDirectory" ]; then
    consoleError "${FUNCNAME[0]} cacheDirectory function - missing cacheDirectory" 1>&2
    return $errorArgument
  fi
  if [ "$mode" = "file" ]; then
    indexRoot="$cacheDirectory/files"
    if [ ! -d "$indexRoot" ]; then
      consoleError "No index exists" 1>&2
      return "$errorEnvironment"
    fi
    if [ ! -f "$indexRoot/$1" ]; then
      return "$errorNotFound"
    fi
    cat "$indexRoot/$1"
    return 0
  fi
  indexRoot="$cacheDirectory/index"
  if [ ! -d "$indexRoot" ]; then
    consoleError "No index exists" 1>&2
    return "$errorEnvironment"
  fi
  if [ $# -eq 0 ]; then
    consoleError "${FUNCNAME[0]} cacheDirectory function - missing function" 1>&2
    return $errorArgument
  fi
  if [ ! -f "$indexRoot/$1" ]; then
    return "$errorNotFound"
  fi
  sourceFile="$(head -n 1 "$indexRoot/$1")"
  lineNumber="$(tail -n 1 "$indexRoot/$1")"
  resultFile="$(printf "%s/%s/%s\n" "$cacheDirectory/code" "${sourceFile##./}" "$1")"
  if [ ! -f "$resultFile" ]; then
    consoleError "Index is corrupt, file $resultFile is not found. regenerate" 1>&2
    return "$errorEnvironment"
  fi
  case $mode in
    combined)
      printf "%s:%d\n" "$sourceFile" "$lineNumber"
      ;;
    settings)
      printf "%s\n" "$resultFile"
      ;;
    source)
      printf "%s\n" "$sourceFile"
      ;;
    line)
      printf "%d\n" "$lineNumber"
      ;;
  esac
  return 0

}

#
# Usage: fn cacheDirectroy
# Outputs relative path to cacheDirectory for shared usage
# Exit Code: 1 - passed in directory must exist
#
_documentationFunctionIndexPath() {
  cacheDirectory="$1"
  if [ ! -d "$cacheDirectory" ]; then
    consoleError "$cacheDirectory is not a directory" 1>&2
    return $errorEnvironment
  fi
  printf "%s" "${cacheDirectory%%/}/documentationFunctionIndex"
}

# Generate a function index for bash files
#
# cacheDirectory/code/bashFilePath/functionName
# cacheDirectory/index/functionName
# cacheDirectory/files/baseName
#
# Use with documentationFunctionLookup
#
# Usage: {fn} [ --clean ] codePath cacheDirectory
#
# Argument: codePath - Required. Directory. Path where code is stored (should remain identical between invocations)
# Argument: cacheDirectory - Required. Directory. Store cached information
# See: documentationFunctionLookup
documentationFunctionIndex() {
  local codePath cacheDirectory
  local start shellFile functionName lineNumber fileCacheMarker functionIndex fileIndex
  local cleanFlag=

  codePath=
  cacheDirectory=
  while [ $# -gt 0 ]; do
    case $1 in
      --clean)
        cleanFlag=1
        ;;
      *)
        if [ -z "$codePath" ]; then
          codePath="$1"
          if [ ! -d "$codePath" ]; then
            consoleError "$codePath is not a directory" 1>&2
            return $errorEnvironment
          fi
          codePath="${codePath#./}"
          codePath="${codePath%/}"
        elif [ -z "$cacheDirectory" ]; then
          if ! cacheDirectory="$(_documentationFunctionIndexPath "$1")"; then
            return $?
          fi
        else
          _buildBuildDocumentationUsage "$errorArgument" "Unknown argument $1"
          return $?
        fi
        ;;
    esac
    shift
  done
  if [ -z "$codePath" ]; then
    _buildBuildDocumentationUsage "$errorArgument" "codePath required"
    return $?
  fi
  if [ -z "$cacheDirectory" ]; then
    _buildBuildDocumentationUsage "$errorArgument" "cacheDirectory required"
    return $?
  fi
  if ! start=$(beginTiming); then
    return $?
  fi
  if test $cleanFlag; then
    rm -rf "$cacheDirectory"
  fi
  functionIndex="$cacheDirectory/index"
  if [ ! -d "$functionIndex" ]; then
    if ! mkdir -p "$functionIndex"; then
      consoleError "Unable to create $functionIndex" 1>&2
      return $errorEnvironment
    fi
  fi
  if [ ! -d "$cacheDirectory/files" ]; then
    if ! mkdir -p "$cacheDirectory/files"; then
      consoleError "Unable to create files index" 1>&2
      return $errorEnvironment
    fi
  fi
  if ! find "$codePath" -type f -name '*.sh' | while read -r shellFile; do
    fileIndex="$cacheDirectory/files/$(basename "$shellFile")"
    if [ ! -f "$fileIndex" ] || ! grep -q "$shellFile" "$fileIndex"; then
      printf "%s\n" "$shellFile" >>"$fileIndex"
    fi
    fileCacheMarker="$cacheDirectory/code/$shellFile"
    if [ ! -d "$fileCacheMarker" ]; then
      if ! mkdir -p "$fileCacheMarker"; then
        consoleError "Unable to create $fileCacheMarker" 1>&2
        return $errorEnvironment
      fi
    elif isNewestFile "$fileCacheMarker/.marker" "$shellFile"; then
      statusMessage consoleInfo "$shellFile is already cached"
      continue
    fi
    pcregrep -n -o1 -M '\n([a-zA-Z_][a-zA-Z_0-9]+)\(\)\s+\{\s*\n' "$shellFile" | while read -r functionName; do
      lineNumber="${functionName%%:*}"
      functionName="${functionName#*:}"
      statusMessage consoleInfo "$(printf "Found %s at %s:%s\n" "$(consoleCode "$functionName")" "$(consoleMagenta "$shellFile")" "$(consoleRed "$lineNumber")")"
      if ! bashExtractDocumentation "$shellFile" "$functionName" >"$fileCacheMarker/$functionName"; then
        rm -f "$fileCacheMarker/$functionName" || :
        clearLine
        consoleError "Documentation failed for $functionName" 1>&2
        return $errorEnvironment
      fi
      printf "%s\n%s\n" "$shellFile" "$lineNumber" >"$functionIndex/$functionName"
    done || :
    touch "$fileCacheMarker/.marker"
    count="$(find "$fileCacheMarker" -type f | wc -l | trimSpacePipe)"
    count=$((count - 1))
    clearLine
    consoleInfo -n "Generated $count functions for $shellFile "
  done; then
    return $?
  fi
  clearLine
  reportTiming "$start" "$(printf "%s: %s %s %s" "$(consoleRed "${FUNCNAME[0]}")" Completed "$(consoleCode "$codePath")" in)"
}
