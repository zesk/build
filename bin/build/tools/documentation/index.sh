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
# See: _documentationIndex_Generate
#
__documentationIndex_Lookup() {
  local handler="_${FUNCNAME[0]}"
  local mode cacheDirectory shellFile functionName lineNumber indexRoot sourceFile resultFile

  cacheDirectory=
  mode=settings
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --file) mode="file" ;;
    --combined) mode="combined" ;;
    --settings) mode="settings" ;;
    --source) mode="source" ;;
    --line) mode="line" ;;
    *)
      if [ -z "$cacheDirectory" ]; then
        cacheDirectory="${1%%/}"
        shift
        if ! cacheDirectory="$(__documentationIndex_GeneratePath "$cacheDirectory")"; then
          return $?
        fi
      fi
      break
      ;;
    esac
    shift
  done
  if [ -z "$cacheDirectory" ]; then
    __throwArgument "$handler" "${FUNCNAME[0]} cacheDirectory function - missing cacheDirectory" || return $?
  fi
  if [ "$mode" = "file" ]; then
    indexRoot="$cacheDirectory/files"
    if [ ! -d "$indexRoot" ]; then
      __throwEnvironment "$handler" "No index exists" || return $?
    fi
    if [ ! -f "$indexRoot/$1" ]; then
      return "$(returnCode exit)"
    fi
    cat "$indexRoot/$1"
    return 0
  fi
  indexRoot="$cacheDirectory/index"
  if [ ! -d "$indexRoot" ]; then
    __throwEnvironment "$handler" "No index exists" || return $?
  fi
  if [ $# -eq 0 ]; then
    __throwArgument "$handler" "${FUNCNAME[0]} cacheDirectory function - missing function" || return $?
  fi
  if [ ! -f "$indexRoot/$1" ]; then
    return "$(returnCode exit)"
  fi
  sourceFile="$(head -n 1 "$indexRoot/$1")"
  lineNumber="$(tail -n 1 "$indexRoot/$1")"
  resultFile="$(printf -- "%s/%s/%s\n" "$cacheDirectory/code" "${sourceFile##./}" "$1")"
  if [ ! -f "$resultFile" ]; then
    __throwEnvironment "$handler" "Index is corrupt, file $(decorate error "$resultFile") is not found. regenerate" || return $?
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
___documentationIndex_Lookup() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: fn cacheDirectory
# Outputs relative path to cacheDirectory for shared handler
# Return Code: 1 - passed in directory must exist
#
__documentationIndex_GeneratePath() {
  local handler="_${FUNCNAME[0]}"
  cacheDirectory="$1"
  if [ ! -d "$cacheDirectory" ]; then
    __throwEnvironment "$handler" "$cacheDirectory is not a directory" || return $?
  fi
  printf -- "%s" "${cacheDirectory%%/}/_documentationIndex_Generate"
}
___documentationIndex_GeneratePath() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Generate a function index for bash files
#
# cacheDirectory/code/bashFilePath/functionName
# cacheDirectory/index/functionName
# cacheDirectory/files/baseName
#
# Use with __documentationIndex_Lookup
#
# Usage: {fn} [ --clean ] codePath cacheDirectory
#
# Argument: codePath - Required. Directory. Path where code is stored (should remain identical between invocations)
# Argument: cacheDirectory - Required. Directory. Store cached information
# See: __documentationIndex_Lookup
_documentationIndex_Generate() {
  local handler="_${FUNCNAME[0]}"

  local forceFlag=false verboseFlag=false

  local codePath="" cacheDirectory="" filterArgs=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --force)
      forceFlag=true
      ;;
    --verbose)
      verboseFlag=true
      ;;
    --filter)
      shift
      while [ $# -gt 0 ] && [ "$1" != "--" ]; do filterArgs+=("$1") && shift; done
      ;;
    *)
      if [ -z "$codePath" ]; then
        codePath="$1"
        if [ ! -d "$codePath" ]; then
          __throwEnvironment "$handler" "$codePath is not a directory" || return $?
        fi
        codePath="${codePath#./}"
        codePath="${codePath%/}"
      elif [ -z "$cacheDirectory" ]; then
        cacheDirectory="$(__catch "$handler" __documentationIndex_GeneratePath "$1")" || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done
  if [ -z "$codePath" ]; then
    __throwArgument "$handler" "codePath required" || return $?
    return $?
  fi
  if [ -z "$cacheDirectory" ]; then
    __throwArgument "$handler" "cacheDirectory required" || return $?
    return $?
  fi

  local start
  start=$(timingStart) || return $?

  local functionIndex="$cacheDirectory/index"
  [ -d "$functionIndex" ] || __catchEnvironment "$handler" mkdir -p "$functionIndex" || return $?

  [ -d "$cacheDirectory/files" ] || __catchEnvironment "$handler" mkdir -p "$cacheDirectory/files" || return $?

  local fileNewestState="$cacheDirectory/newest" cachedSavedNewestFileModified fileNewest

  [ -f "$fileNewestState" ] || __catchEnvironment "$handler" touch "$fileNewestState" || return $?
  cachedSavedNewestFileModified="$(head -n 1 "$fileNewestState")"

  if fileNewest=$(directoryNewestFile --find -name '*.sh' -- "$codePath") && ! $forceFlag; then
    local fileNewestModified seconds
    if fileNewestModified=$(fileModificationTime "$fileNewest") && isUnsignedInteger "$cachedSavedNewestFileModified"; then
      if isInteger "$cachedSavedNewestFileModified" && [ "$fileNewestModified" -lt "$cachedSavedNewestFileModified" ]; then
        statusMessage decorate info "$(decorate file "$codePath") nothing changed"
        return 0
      fi
    fi
    seconds=$(fileModificationSeconds "$fileNewest")
    ! $verboseFlag || statusMessage decorate info "Newest file is $(decorate file "$fileNewest") modified $seconds $(plural "$seconds" second seconds) ago" || return $?
    printf "%s\n" "$fileNewestModified" "$fileNewest" >"$fileNewestState"
  fi

  local shellFile foundOne=false
  while read -r shellFile; do
    [ -n "$shellFile" ] || continue
    local fileIndex
    foundOne=true
    fileIndex="$cacheDirectory/files/$(basename "$shellFile")"
    if [ ! -f "$fileIndex" ] || ! grep -q "$shellFile" "$fileIndex"; then
      printf -- "%s\n" "$shellFile" >>"$fileIndex"
    fi
    local fileCacheMarker="$cacheDirectory/code/${shellFile#/}"
    if [ ! -d "$fileCacheMarker" ]; then
      __catchEnvironment "$handler" mkdir -p "$fileCacheMarker" || return $?
    elif fileIsNewest "$fileCacheMarker/.marker" "$shellFile"; then
      statusMessage decorate info "$(decorate file "$shellFile") is already cached"
      continue
    fi
    __pcregrep -n -o1 -M '\n([a-zA-Z_][a-zA-Z_0-9]+)\(\)\s+\{\s*\n' "$shellFile" | while read -r functionName; do
      local lineNumber="${functionName%%:*}" functionName="${functionName#*:}"
      statusMessage decorate info "$(printf -- "Found %s at %s:%s\n" "$(decorate code "$functionName")" "$(decorate magenta "$(decorate file "$shellFile")")" "$(decorate red "$lineNumber")")"
      if ! bashDocumentation_Extract "$shellFile" "$functionName" >"$fileCacheMarker/$functionName"; then
        rm -f "$fileCacheMarker/$functionName" || :
        statusMessage --last decorate error bashDocumentation_Extract "$shellFile" "$functionName"
        __throwEnvironment "$handler" "Documentation failed for $functionName" || return $?
      fi
      printf "%s\n%s\n" "$shellFile" "$lineNumber" >"$functionIndex/$functionName"
    done || :
    local count
    touch "$fileCacheMarker/.marker"
    count="$(find "$fileCacheMarker" -type f | __catch "$handler" fileLineCount)" || return $?
    count=$((count - 1))
    statusMessage decorate success "Generated $count functions for $shellFile "
  done < <(find "$codePath" -type f -name '*.sh' ! -path '*/.*/*')

  if ! $foundOne; then
    __throwEnvironment "$handler" "No shell files found in $(decorate file "$codePath")" || return $?
  fi
  statusMessage --last printf -- "%s %s %s\n" "$(decorate info "Generated index for ")" "$(decorate code "$(decorate file "$codePath")")" "$(timingReport "$start" in)"
}
__documentationIndex_Generate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Displays any functions which are not included in the documentation and the reason why.
#
# - Any functions beginning with an **underscore** (`_`) are ignored
# - Any function which contains ANY `ignore` directive in the comment is ignored
# - Any function which is unlinked in the source (call `_documentationIndex_LinkDocumentationPaths` first)
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
# See: _documentationIndex_LinkDocumentationPaths
# See: _documentationIndex_FunctionIterator
#
_documentationIndex_ShowUnlinked() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local cacheDirectory=$1
  local functionName settingsFile
  local documentationPath documentationPathUnlinked ignore

  _documentationIndex_FunctionIterator "$cacheDirectory" | while read -r functionName settingsFile; do
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
__documentationIndex_ShowUnlinked() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Set the unlinked documentation path
#
# Usage: {fn} cacheDirectory target
# Argument: cacheDirectory - Required. Directory. Index cache directory.
# Argument: target - Required. String. Path to document path where unlinked functions should link.
#
_documentationIndex_SetUnlinkedDocumentationPath() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local cacheDirectory target
  cacheDirectory=$(usageArgumentDirectory "$handler" "cacheDirectory" "${1-}") && shift || return $?
  target=$(usageArgumentString "$handler" "cacheDirectory" "${1-}") && shift || return $?
  local functionName settingsFile
  target="$(trimSpace "$target")"
  _documentationIndex_UnlinkedIterator "$cacheDirectory" | while read -r functionName settingsFile; do
    if ! grep -q "'documentationPath'" "$settingsFile"; then
      __dumpNameValue documentationPath "$target" >>"$settingsFile"
      __dumpNameValue documentationPathUnlinked 1 >>"$settingsFile"
    fi
    printf '%s %s\n' "$functionName" "$settingsFile"
  done
}
__documentationIndex_SetUnlinkedDocumentationPath() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# List of functions which are not linked to anywhere in the documentation index
#
# Argument: cacheDirectory - Required. Directory. Index cache directory.
# Argument: --underscore - Flag. Optional. List underscore functions.
_documentationIndex_UnlinkedIterator() {
  local handler="_${FUNCNAME[0]}"

  local cacheDirectory=""
  local flagUnderscore=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --underscore)
      flagUnderscore=true
      ;;
    *)
      if ! cacheDirectory=$(usageArgumentDirectory "$handler" "cacheDirectory" "$1"); then
        return $?
      fi
      ;;
    esac
    shift
  done

  [ -n "$cacheDirectory" ] || __throwArgument "$handler" "Need cacheDirectory" || return $?

  local functionName settingsFile

  _documentationIndex_FunctionIterator "$cacheDirectory" | while read -r functionName settingsFile; do
    # Skip functions beginning with underscores always
    if ! $flagUnderscore && [ "$functionName" != "${functionName#_}" ]; then
      continue
    fi
    if grep -q "'documentationPathUnlinked'" "$settingsFile"; then
      printf '%s %s\n' "$functionName" "$settingsFile"
    elif ! grep -E -q "'(ignore|documentationPath)'" "$settingsFile"; then
      printf '%s %s\n' "$functionName" "$settingsFile"
    fi
  done
}
__documentationIndex_UnlinkedIterator() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Output a list of all functions in the index as pairs:
#
#     functionName functionSettings
#
# Usage: {fn} cacheDirectory
#
# Argument: cacheDirectory - Required. Directory. Index cache directory.
# See: __documentationIndex_Lookup
# See: _documentationIndex_LinkDocumentationPaths
#
_documentationIndex_FunctionIterator() {
  local handler="_${FUNCNAME[0]}"

  local cacheDirectory="" functionIndexPath=""
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
      if [ -z "$cacheDirectory" ]; then
        cacheDirectory="$1"
        if [ ! -d "$cacheDirectory" ]; then
          __throwArgument "$handler" "cacheDirectory must be a directory" || return $?
        fi
        if ! functionIndexPath="$(__documentationIndex_GeneratePath "$cacheDirectory")"; then
          __throwArgument "$handler" "Unable to generate index at path $(decorate file "$cacheDirectory")" || return $?
        fi
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done
  if [ -z "$cacheDirectory" ]; then
    __throwArgument "$handler" "cacheDirectory required" || return $?
  fi
  local functionName settingsFile
  find "$functionIndexPath/index" -type f -print | sort | while read -r functionName; do
    functionName=$(basename "$functionName")
    if ! settingsFile="$(__documentationIndex_Lookup --settings "$cacheDirectory" "$functionName")"; then
      settingsFile='-'
    fi
    printf "%s %s\n" "$functionName" "$settingsFile"
  done
}
__documentationIndex_FunctionIterator() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
# Use with __documentationIndex_Lookup
#
# TODO This should probably be a generic "set variable function" and then use it for documentationPath
#
# Return Code: 0 - If success
# Return Code: 1 - Issue with file generation
# Return Code: 2 - Argument error
#
_documentationIndex_LinkDocumentationPaths() {
  local handler="_${FUNCNAME[0]}"
  local start checkFiles
  local settingsFile
  local documentTokensFile modifiedCountFile processed total

  start=$(timingStart) || __catchEnvironment "$handler" "timingStart failed" || return $?
  local cacheDirectory="" documentTemplate="" documentationPath=""
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --force) ;;
    *)
      if [ -z "$cacheDirectory" ]; then
        cacheDirectory="$1"
        [ -d "$cacheDirectory" ] || __throwArgument "$handler" "cacheDirectory documentTemplate - $cacheDirectory not a directory" || return $?
        cacheDirectory="${cacheDirectory%%/}"
      elif [ -z "$documentTemplate" ]; then
        documentTemplate="$1"
        [ -f "$documentTemplate" ] || __throwArgument "$handler" "cacheDirectory documentTemplate - $documentTemplate not a file" || return $?
      elif [ -z "$documentationPath" ]; then
        documentationPath="$1"
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done
  [ -n "$cacheDirectory" ] || __throwArgument "$handler" "cacheDirectory required" || return $?
  [ -n "$documentTemplate" ] || __throwArgument "$handler" "documentTemplate required" || return $?
  [ -n "$documentationPath" ] || __throwArgument "$handler" "documentationPath required" || return $?

  local documentTemplate
  if ! documentTokensFile=$(fileTemporaryName "$handler") || ! modifiedCountFile=$(fileTemporaryName "$handler"); then
    rm -f "$documentTokensFile" "$modifiedCountFile" 2>/dev/null || :
    __throwEnvironment "$handler" "Creating temporary file failed" || return $?
  fi
  # subshell to hide environment tokens
  if ! mapTokens <"$documentTemplate" >"$documentTokensFile"; then
    rm -f "$documentTokensFile" "$modifiedCountFile" 2>/dev/null || :
    __throwEnvironment "$handler" "mapTokens failed" || return $?
  fi
  checkFiles=("$documentTemplate")
  __catchEnvironment "$handler" touch "$modifiedCountFile" || return $?
  while read -r token; do
    if ! settingsFile=$(__documentationIndex_Lookup --settings "$cacheDirectory" "$token"); then
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
  if ! processed=$(__catch "$handler" fileSize "$modifiedCountFile"); then
    processed=0
  fi
  total="$(__catch "$handler" fileLineCount "$documentTokensFile")" || return $?
  rm "$documentTokensFile" "$modifiedCountFile" 2>/dev/null || :
  statusMessage decorate info "$(printf "%s %s %s %s %s %s %s %s\n" "$(decorate cyan Indexed)" "$(decorate bold-red "$processed")" "$(decorate green "of $total")" "$(decorate cyan "$(plural "$processed" function functions)")" "for" "$(decorate code "$documentationPath")" "in" "$(timingReport "$start")")"
}
__documentationIndex_LinkDocumentationPaths() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
