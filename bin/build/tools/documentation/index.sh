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
  local usage="_${FUNCNAME[0]}"
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
          shift
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
    _argument "${FUNCNAME[0]} cacheDirectory function - missing cacheDirectory" || return $?
  fi
  if [ "$mode" = "file" ]; then
    indexRoot="$cacheDirectory/files"
    if [ ! -d "$indexRoot" ]; then
      __failEnvironment "$usage" "No index exists" || return $?
    fi
    if [ ! -f "$indexRoot/$1" ]; then
      return "$(_code exit)"
    fi
    cat "$indexRoot/$1"
    return 0
  fi
  indexRoot="$cacheDirectory/index"
  if [ ! -d "$indexRoot" ]; then
    __failEnvironment "$usage" "No index exists" || return $?
  fi
  if [ $# -eq 0 ]; then
    _argument "${FUNCNAME[0]} cacheDirectory function - missing function" || return $?
  fi
  if [ ! -f "$indexRoot/$1" ]; then
    return "$(_code exit)"
  fi
  sourceFile="$(head -n 1 "$indexRoot/$1")"
  lineNumber="$(tail -n 1 "$indexRoot/$1")"
  resultFile="$(printf -- "%s/%s/%s\n" "$cacheDirectory/code" "${sourceFile##./}" "$1")"
  if [ ! -f "$resultFile" ]; then
    __failEnvironment "$usage" "Index is corrupt, file $(decorate error "$resultFile") is not found. regenerate" || return $?
  fi
  case $mode in
    combined)
      printf -- "%s:%d\n" "$sourceFile" "$lineNumber"
      ;;
    settings)
      printf -- "%s\n" "$resultFile"
      ;;
    source)
      printf -- "%s\n" "$sourceFile"
      ;;
    line)
      printf -- "%d\n" "$lineNumber"
      ;;
  esac
  return 0
}
_documentationIndex_Lookup() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: fn cacheDirectory
# Outputs relative path to cacheDirectory for shared usage
# Exit Code: 1 - passed in directory must exist
#
_documentationIndex_GeneratePath() {
  local usage="_${FUNCNAME[0]}"
  cacheDirectory="$1"
  if [ ! -d "$cacheDirectory" ]; then
    __failEnvironment "$usage" "$cacheDirectory is not a directory" || return $?
  fi
  printf -- "%s" "${cacheDirectory%%/}/documentationIndex_Generate"
}
__documentationIndex_GeneratePath() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved
  local codePath cacheDirectory
  local start shellFile functionName lineNumber fileCacheMarker functionIndex fileIndex

  codePath=
  cacheDirectory=
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
      *)
        if [ -z "$codePath" ]; then
          codePath="$1"
          if [ ! -d "$codePath" ]; then
            __failEnvironment "$usage" "$codePath is not a directory" || return $?
          fi
          codePath="${codePath#./}"
          codePath="${codePath%/}"
        elif [ -z "$cacheDirectory" ]; then
          cacheDirectory="$(__usageEnvironment "$usage" _documentationIndex_GeneratePath "$1")" || return $?
        else
          # IDENTICAL argumentUnknown 1
          __failArgument "$usage" "unknown argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
        fi
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
  done
  if [ -z "$codePath" ]; then
    __failArgument "$usage" "codePath required" || return $?
    return $?
  fi
  if [ -z "$cacheDirectory" ]; then
    __failArgument "$usage" "cacheDirectory required"
    return $?
  fi
  if ! start=$(beginTiming); then
    return $?
  fi
  functionIndex="$cacheDirectory/index"
  if [ ! -d "$functionIndex" ]; then
    __usageEnvironment "$usage" mkdir -p "$functionIndex" || return $?
  fi
  if [ ! -d "$cacheDirectory/files" ]; then
    __usageEnvironment "$usage" mkdir -p "$cacheDirectory/files" || return $?
  fi
  if ! find "$codePath" -type f -name '*.sh' ! -path '*/.*/*' | while read -r shellFile; do
    fileIndex="$cacheDirectory/files/$(basename "$shellFile")"
    if [ ! -f "$fileIndex" ] || ! grep -q "$shellFile" "$fileIndex"; then
      printf -- "%s\n" "$shellFile" >>"$fileIndex"
    fi
    fileCacheMarker="$cacheDirectory/code/${shellFile#/}"
    if [ ! -d "$fileCacheMarker" ]; then
      __usageEnvironment "$usage" mkdir -p "$fileCacheMarker" || return $?
    elif isNewestFile "$fileCacheMarker/.marker" "$shellFile"; then
      statusMessage decorate info "$(decorate file "$shellFile") is already cached"
      continue
    fi
    pcregrep -n -o1 -M '\n([a-zA-Z_][a-zA-Z_0-9]+)\(\)\s+\{\s*\n' "$shellFile" | while read -r functionName; do
      lineNumber="${functionName%%:*}"
      functionName="${functionName#*:}"
      statusMessage decorate info "$(printf -- "Found %s at %s:%s\n" "$(decorate code "$functionName")" "$(decorate magenta "$(decorate file "$shellFile")")" "$(decorate red "$lineNumber")")"
      if ! bashDocumentation_Extract "$shellFile" "$functionName" >"$fileCacheMarker/$functionName"; then
        rm -f "$fileCacheMarker/$functionName" || :
        statusMessage --last decorate error bashDocumentation_Extract "$shellFile" "$functionName"
        __failEnvironment "$usage" "Documentation failed for $functionName" || return $?
      fi
      printf "%s\n%s\n" "$shellFile" "$lineNumber" >"$functionIndex/$functionName"
    done || :
    touch "$fileCacheMarker/.marker"
    count="$(find "$fileCacheMarker" -type f | wc -l | trimSpace)"
    count=$((count - 1))
    statusMessage decorate success "Generated $count functions for $shellFile "
  done; then
    __failEnvironment "$usage" "No shell files found in $(decorate file "$codePath")" || return $?
  fi
  statusMessage --last printf -- "%s %s %s\n" "$(decorate info "Generated index for ")" "$(decorate code "$(decorate file "$codePath")")" "$(reportTiming "$start" in)"
}
_documentationIndex_Generate() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
          printf "%s %s %s\n" "$(decorate code "$functionName")" "$(decorate warning "ignored because")" "$(decorate magenta "$ignore")"
        elif [ -z "$documentationPath" ] || [ -n "$documentationPathUnlinked" ]; then
          printf "%s %s\n" "$(decorate code "$functionName")" "$(decorate error "not documented anywhere")"
        fi
      )
    else
      printf "%s %s %s\n" "$(decorate code "$functionName")" "$(decorate warning "ignored because")" "$(decorate blue "begins with underscore")"
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
  target="$(trimSpace "$target")"
  documentationIndex_UnlinkedIterator "$cacheDirectory" | while read -r functionName settingsFile; do
    if ! grep -q "'documentationPath'" "$settingsFile"; then
      __dumpNameValue documentationPath "$target" >>"$settingsFile"
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
  local usage="_${FUNCNAME[0]}"

  local cacheDirectory="" functionIndexPath=""
  while [ $# -gt 0 ]; do
    case "$1" in
      *)
        if [ -z "$cacheDirectory" ]; then
          cacheDirectory="$1"
          if [ ! -d "$cacheDirectory" ]; then
            __failArgument "$usage" "cacheDirectory must be a directory"
            return $?
          fi
          if ! functionIndexPath="$(_documentationIndex_GeneratePath "$cacheDirectory")"; then
            __failArgument "$usage" "Unable to generate index at path $(decorate file "$cacheDirectory")" || return $?
          fi
        else
          __failArgument "$usage" "Unknown argument $1" || return $?
        fi
        ;;
    esac
    shift
  done
  if [ -z "$cacheDirectory" ]; then
    __failArgument "$usage" "cacheDirectory required" || return $?
    return $?
  fi
  local functionName settingsFile
  find "$functionIndexPath/index" -type f -print | sort | while read -r functionName; do
    functionName=$(basename "$functionName")
    if ! settingsFile="$(documentationIndex_Lookup --settings "$cacheDirectory" "$functionName")"; then
      settingsFile='-'
    fi
    printf "%s %s\n" "$functionName" "$settingsFile"
  done
}
_documentationIndex_FunctionIterator() {
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
  local usage="_${FUNCNAME[0]}"
  local start checkFiles
  local settingsFile
  local documentTokensFile modifiedCountFile processed total

  start=$(beginTiming) || __usageEnvironment "$usage" "beginTiming failed" || return $?
  local cacheDirectory="" documentTemplate="" documentationPath=""
  local saved=("$@") nArguments=$#
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --force) ;;
      *)
        if [ -z "$cacheDirectory" ]; then
          cacheDirectory="$1"
          [ -d "$cacheDirectory" ] || __failArgument "$usage" "cacheDirectory documentTemplate - $cacheDirectory not a directory" || return $?
          cacheDirectory="${cacheDirectory%%/}"
        elif [ -z "$documentTemplate" ]; then
          documentTemplate="$1"
          [ -f "$documentTemplate" ] || __failArgument "$usage" "cacheDirectory documentTemplate - $documentTemplate not a file" || return $?
        elif [ -z "$documentationPath" ]; then
          documentationPath="$1"
        else
          # IDENTICAL argumentUnknown 1
          __failArgument "$usage" "unknown argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
        fi
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done
  [ -n "$cacheDirectory" ] || __failArgument "$usage" "cacheDirectory required" || return $?
  [ -n "$documentTemplate" ] || __failArgument "$usage" "documentTemplate required" || return $?
  [ -n "$documentationPath" ] || __failArgument "$usage" "documentationPath required" || return $?

  local documentTemplate
  if ! documentTokensFile=$(__usageEnvironment "$usage" mktemp) || ! modifiedCountFile=$(__usageEnvironment "$usage" mktemp); then
    rm -f "$documentTokensFile" "$modifiedCountFile" 2>/dev/null || :
    __failEnvironment "$usage" "mktemp failed" || return $?
  fi
  # subshell to hide environment tokens
  if ! listTokens <"$documentTemplate" >"$documentTokensFile"; then
    rm -f "$documentTokensFile" "$modifiedCountFile" 2>/dev/null || :
    __failEnvironment "$usage" "listTokens failed" || return $?
  fi
  checkFiles=("$documentTemplate")
  __usageEnvironment "$usage" touch "$modifiedCountFile" || return $?
  while read -r token; do
    if ! settingsFile=$(documentationIndex_Lookup --settings "$cacheDirectory" "$token"); then
      statusMessage --last decorate error "Function $(decorate code "$token") $(decorate error "not defined")" 1>&2
      continue
    fi
    if ! grep -q "'documentationPath'" "$settingsFile"; then
      statusMessage decorate info "Adding documentationPath to $(decorate value "[$token]") settings" || :
      if ! __dumpNameValue documentationPath "$(trimSpace "$documentationPath")" >>"$settingsFile"; then
        decorate error "Error writing documentationPath to $settingsFile" 1>&2
        break
      fi
      if ! printf x >>"$modifiedCountFile"; then
        decorate error "Error writing count file: $modifiedCountFile" 1>&2
        break
      fi
    fi
    checkFiles+=("$settingsFile")
  done <"$documentTokensFile"
  if ! processed=$(__usageEnvironment "$usage" fileSize "$modifiedCountFile"); then
    processed=0
  fi
  total="$(trimSpace "$(wc -l <"$documentTokensFile")")"
  rm "$documentTokensFile" "$modifiedCountFile" 2>/dev/null || :
  statusMessage decorate info "$(printf "%s %s %s %s %s %s %s %s\n" "$(decorate cyan Indexed)" "$(decorate bold-red "$processed")" "$(decorate green "of $total")" "$(decorate cyan "$(plural "$processed" function functions)")" "for" "$(decorate code "$documentationPath")" "in" "$(reportTiming "$start")")"
}
_documentationIndex_LinkDocumentationPaths() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
