#!/usr/bin/env bash
#
# documentation-index.sh
#
# Generate an index of our bash functions for faster documentation generation.
#
# Copyright: Copyright &copy; 2024 Market Acumen, Inc.
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
# See: documentationIndex_Generate
#
documentationIndex_Lookup() {
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
          if ! cacheDirectory="$(_documentationIndex_GeneratePath "$cacheDirectory")"; then
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
# Usage: fn cacheDirectory
# Outputs relative path to cacheDirectory for shared usage
# Exit Code: 1 - passed in directory must exist
#
_documentationIndex_GeneratePath() {
  cacheDirectory="$1"
  if [ ! -d "$cacheDirectory" ]; then
    consoleError "$cacheDirectory is not a directory" 1>&2
    return $errorEnvironment
  fi
  printf "%s" "${cacheDirectory%%/}/documentationIndex_Generate"
}

# Generate a function index for bash files
#
# cacheDirectory/code/bashFilePath/functionName
# cacheDirectory/index/functionName
# cacheDirectory/files/baseName
#
# Use with documentationIndex_Lookup
#
# Usage: {fn} [ --clean ] codePath cacheDirectory
#
# Argument: codePath - Required. Directory. Path where code is stored (should remain identical between invocations)
# Argument: cacheDirectory - Required. Directory. Store cached information
# See: documentationIndex_Lookup
documentationIndex_Generate() {
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
          if ! cacheDirectory="$(_documentationIndex_GeneratePath "$1")"; then
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
      if ! bashDocumentation_Extract "$shellFile" "$functionName" >"$fileCacheMarker/$functionName"; then
        rm -f "$fileCacheMarker/$functionName" || :
        clearLine
        consoleError "Documentation failed for $functionName" 1>&2
        return $errorEnvironment
      fi
      printf "%s\n%s\n" "$shellFile" "$lineNumber" >"$functionIndex/$functionName"
    done || :
    touch "$fileCacheMarker/.marker"
    count="$(find "$fileCacheMarker" -type f | wc -l | trimSpace)"
    count=$((count - 1))
    statusMessage consoleSuccess "Generated $count functions for $shellFile "
  done; then
    return $?
  fi
  clearLine
  printf "%s %s %s\n" "$(consoleInfo "Generated index for ")" "$(consoleCode "$codePath")" "$(reportTiming "$start" in)"
}

#
# Displays any functions which are not included in the documentation and the reason why.
#
# - Any functions beginning with an **underscore** (`_`) are ignored
# - Any function which contains ANY `ignore` directive in the comment is ignored
# - Any function which is unlinked in the source (call `documentationIndex_LinkDocumentationPaths` first)
#
# Within your function, add an ignore reason if you wish:
#
#     # Ignore: Internal only
#     userFunction() {
#     ...
#     }
#
# Usage: {fn} cacheDirectory
# Argument: cacheDirectory - Required. Directory. Index cache directory.
# See: documentationIndex_LinkDocumentationPaths
# See: documentationIndex_FunctionIterator
#
documentationIndex_ShowUnlinked() {
  local cacheDirectory=$1
  local functionName settingsFile
  local documentationPath documentationPathUnlinked ignore

  documentationIndex_FunctionIterator "$cacheDirectory" | while read -r functionName settingsFile; do
    if [ "$functionName" = "${functionName#_}" ]; then
      (
        set -a
        documentationPath=
        documentationPathUnlinked=
        ignore=
        # shellcheck source=/dev/null
        source "$settingsFile"
        if [ -n "$ignore" ]; then
          printf "%s %s %s\n" "$(consoleCode "$functionName")" "$(consoleWarning "ignored because")" "$(consoleMagenta "$ignore")"
        elif [ -z "$documentationPath" ] || [ -n "$documentationPathUnlinked" ]; then
          printf "%s %s\n" "$(consoleCode "$functionName")" "$(consoleError "not documented anywhere")"
        fi
      )
    else
      printf "%s %s %s\n" "$(consoleCode "$functionName")" "$(consoleWarning "ignored because")" "$(consoleBlue "begins with underscore")"
    fi
  done
}

#
# List of functions which are not linked to anywhere in the documentation index
#
# Usage: {fn} cacheDirectory target
# Argument: cacheDirectory - Required. Directory. Index cache directory.
# Argument: target - Required. String. Path to document path where unlinked functions should link.
#
documentationIndex_SetUnlinkedDocumentationPath() {
  local cacheDirectory="$1" target="$2"
  local functionName settingsFile
  documentationIndex_UnlinkedIterator "$cacheDirectory" | while read -r functionName settingsFile; do
    if ! grep -q "'documentationPath'" "$settingsFile"; then
      __dumpNameValue documentationPath "$(trimSpace "$target")" >>"$settingsFile"
      __dumpNameValue documentationPathUnlinked 1 >>"$settingsFile"
    fi
    printf '%s %s\n' "$functionName" "$settingsFile"
  done
}

#
# List of functions which are not linked to anywhere in the documentation index
#
# Usage: {fn} cacheDirectory
# Argument: cacheDirectory - Required. Directory. Index cache directory.
# Exit Code: 0 - The settings file is unlinked within the documentation (not defined anywhere)
# Exit Code: 1 - The settings file is linked within the documentation
#
documentationIndex_UnlinkedIterator() {
  local cacheDirectory
  local functionName settingsFile
  local flagUnderscore=
  while [ $# -gt 0 ]; do
    case $1 in
      --underscore)
        flagUnderscore=1
        ;;
      *)
        if ! cacheDirectory=$(usageArgumentDirectory _documentationIndex_UnlinkedIteratorUsage cacheDirectory "$1"); then
          return $?
        fi
        ;;
    esac
    shift
  done

  documentationIndex_FunctionIterator "$cacheDirectory" | while read -r functionName settingsFile; do
    # Skip functions beginning with underscores always
    if [ -z "$flagUnderscore" ] && [ "$functionName" != "${functionName#_}" ]; then
      continue
    fi
    if grep -q "'documentationPathUnlinked'" "$settingsFile"; then
      printf '%s %s\n' "$functionName" "$settingsFile"
    elif ! grep -E -q "'(ignore|documentationPath)'" "$settingsFile"; then
      printf '%s %s\n' "$functionName" "$settingsFile"
    fi
  done
}
_documentationIndex_UnlinkedIteratorUsage() {
  usageDocument "${BASH_SOURCE[0]}" documentationIndex_UnlinkedIterator "$@"
}

#
# Output a list of all functions in the index as pairs:
#
#     functionName functionSettings
#
# Usage: {fn} cacheDirectory
#
# Argument: cacheDirectory - Required. Directory. Index cache directory.
# See: documentationIndex_Lookup
# See: documentationIndex_LinkDocumentationPaths
#
documentationIndex_FunctionIterator() {
  local cacheDirectory functionIndexPath
  local functionName settingsFile
  local cleanFlag=

  cacheDirectory=
  while [ $# -gt 0 ]; do
    case $1 in
      --clean)
        cleanFlag=1
        ;;
      *)
        if [ -z "$cacheDirectory" ]; then
          cacheDirectory="$1"
          if [ ! -d "$cacheDirectory" ]; then
            _documentationIndex_FunctionIteratorUsage "$errorArgument" "cacheDirectory must be a directory"
            return $?
          fi
          if ! functionIndexPath="$(_documentationIndex_GeneratePath "$cacheDirectory")"; then
            _documentationIndex_FunctionIteratorUsage "$errorArgument"
            return $?
          fi
        else
          _documentationIndex_FunctionIteratorUsage "$errorArgument" "Unknown argument $1"
          return $?
        fi
        ;;
    esac
    shift
  done
  if [ -z "$cacheDirectory" ]; then
    _documentationIndex_FunctionIteratorUsage "$errorArgument" "cacheDirectory required"
    return $?
  fi
  find "$functionIndexPath/index" -type f -print | sort | while read -r functionName; do
    functionName=$(basename "$functionName")
    if ! settingsFile="$(documentationIndex_Lookup --settings "$cacheDirectory" "$functionName")"; then
      settingsFile='-'
    fi
    printf "%s %s\n" "$functionName" "$settingsFile"
  done
}
_documentationIndex_FunctionIteratorUsage() {
  usageDocument "${BASH_SOURCE[0]}" documentationIndex_UnlinkedIterator "$@"
}

# Update the documentationPath for all functions defined in documentTemplate
# Usage: {fn} cacheDirectory documentTemplate documentationPath
# Argument: cacheDirectory - Required. Cache directory where the indexes live.
# Argument: documentTemplate - Required. The document template containing functions to index
# Argument: documentationPath - Required. The path to store as the documentation path.
#
# This updates
#
#     cacheDirectory/index/functionName
#
# and adds the `documentationPath` to it
#
# Use with documentationIndex_Lookup
#
# Exit Code: 0 - If success
# Exit Code: 1 - Issue with file generation
# Exit Code: 2 - Argument error
#
documentationIndex_LinkDocumentationPaths() {
  local this
  local argument
  local start documentTemplate cacheDirectory checkFiles
  local settingsFile
  local documentTokensFile modifiedCountFile processed total

  this="${FUNCNAME[0]}"

  start=$(beginTiming) || _environment "beginTiming failed" || return $?
  cacheDirectory=
  documentTemplate=
  documentationPath=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || _argument "blank argument" || return $?
    case "$argument" in
      --force) ;;
      *)
        if [ -z "$cacheDirectory" ]; then
          cacheDirectory="$1"
          [ -d "$cacheDirectory" ] || _argument "$this: cacheDirectory documentTemplate - $cacheDirectory not a directory" || return $?
          cacheDirectory="${cacheDirectory%%/}"
        elif [ -z "$documentTemplate" ]; then
          documentTemplate="$1"
          [ -f "$documentTemplate" ] || _argument "$this: cacheDirectory documentTemplate - $documentTemplate not a file" || return $?
        elif [ -z "$documentationPath" ]; then
          documentationPath="$1"
        else
          _argument "$this cacheDirectory documentTemplate - unknown argument" || return $?
        fi
        ;;
    esac
    shift || _argument "shift $argument failed" || return $?
  done
  [ -n "$cacheDirectory" ] || _argument "$this - cacheDirectory required" || return $?
  [ -n "$documentTemplate" ] || _argument "$this - documentTemplate required" || return $?
  [ -n "$documentationPath" ] || _argument "$this - documentationPath required" || return $?

  if ! documentTokensFile=$(mktemp) || ! modifiedCountFile=$(mktemp); then
    rm -f "$documentTokensFile" "$modifiedCountFile" 2>/dev/null || :
    _argument "mktemp failed" || return $?
  fi
  # subshell to hide environment tokens
  if ! listTokens <"$documentTemplate" >"$documentTokensFile"; then
    rm -f "$documentTokensFile" "$modifiedCountFile" 2>/dev/null || :
    _environment "listTokens failed" || return $?
  fi
  checkFiles=("$documentTemplate")
  while read -r token; do
    if ! settingsFile=$(documentationIndex_Lookup --settings "$cacheDirectory" "$token"); then
      continue
    fi
    if ! grep -q "'documentationPath'" "$settingsFile"; then
      statusMessage consoleInfo "Adding documentationPath to $(consoleValue "[$token]") settings" || :
      if ! __dumpNameValue documentationPath "$(trimSpace "$documentationPath")" >>"$settingsFile"; then
        consoleError "Error writing documentationPath to $settingsFile" 1>&2
        break
      fi
      if ! printf x >>"$modifiedCountFile"; then
        consoleError "Error writing count file: $modifiedCountFile" 1>&2
        break
      fi
    fi
    checkFiles+=("$settingsFile")
  done <"$documentTokensFile"
  if ! processed=$(fileSize "$modifiedCountFile" 2>/dev/null); then
    processed=0
  fi
  total="$(trimSpace "$(wc -l <"$documentTokensFile")")"
  rm "$documentTokensFile" "$modifiedCountFile" 2>/dev/null || :
  clearLine || :
  statusMessage consoleInfo "$(printf "%s %s %s %s %s %s %s %s\n" "$(consoleCyan Indexed)" "$(consoleBoldRed "$processed")" "$(consoleGreen "of $total")" "$(consoleCyan "$(plural "$processed" function functions)")" for "$(consoleCode "$documentationPath")" in "$(reportTiming "$start")")"
}
