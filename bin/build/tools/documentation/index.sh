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

# Generate a function index for bash files
#
# cacheDirectory/comment/functionName
# cacheDirectory/files/baseName
#
# Use with __documentationIndexLookup
#
# Usage: {fn} [ --clean ] codePath cacheDirectory
#
# Argument: codePath - Required. Directory. Path where code is stored (should remain identical between invocations)
# See: __documentationIndexLookup
# Requires: __pcregrep
_documentationIndexGenerate() {
  local handler="_${FUNCNAME[0]}"

  local codePaths=() filterArgs=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose)
      verboseFlag=true
      ;;
    --filter)
      shift
      while [ $# -gt 0 ] && [ "$1" != "--" ]; do filterArgs+=("$1") && shift; done
      ;;
    *)
      codePaths+=("$(usageArgumentDirectory "$handler" "codePath" "$argument")") || return $?
      ;;
    esac
    shift
  done
  if [ ${#codePaths[@]} -eq 0 ]; then
    throwArgument "$handler" "at least one codePath required" || return $?
    return $?
  fi

  local start
  start=$(timingStart) || return $?

  local indexDirectory
  indexDirectory=$(catchReturn "$handler" __documentationIndexCache) || return $?
  catchReturn "$handler" muzzle directoryRequire "$indexDirectory" || return $?

  local cacheDirectory
  cacheDirectory=$(catchReturn "$handler" documentationBuildCache) || return $?

  local indexFile="$cacheDirectory/code.index"
  local foundOne=false
  catchEnvironment "$handler" rm -rf "$indexFile" "$indexFile.unsorted" "$indexDirectory/files/" || return $?
  catchReturn "$handler" muzzle directoryRequire "$indexDirectory/files/" "$indexDirectory/comment" || return $?
  local codePath
  local homeSlash
  homeSlash="$(catchReturn "$handler" buildHome)/" || return $?
  for codePath in "${codePaths[@]}"; do
    pathIsAbsolute "$codePath" || codePath="$homeSlash/$codePath"
    local fullPath
    while read -r fullPath; do
      local shellFile="${fullPath#"$homeSlash"}"
      if [ "$shellFile" = "$fullPath" ]; then
        decorate error "Unable to strip $homeSlash from $fullPath?" 1>&2
        continue
      fi
      foundOne=true
      printf -- "%s\n" "$shellFile" >>"$indexDirectory/files/$(basename "$shellFile")" || return $?

      local fileCacheMarker="$indexDirectory/code/${shellFile#/}"
      local functionsCache="$fileCacheMarker/.functions"
      if [ ! -f "$functionsCache" ]; then
        catchReturn "$handler" muzzle directoryRequire "$fileCacheMarker" || return $?
      elif fileIsNewest "$functionsCache" "$fullPath"; then
        ! $verboseFlag || statusMessage decorate info "$(decorate file "$shellFile") $(decorate bold-blue "(cached)")"
        cat "$functionsCache" >>"$indexFile.unsorted"
        continue
      fi
      local count=0
      ! $verboseFlag || statusMessage decorate info "Processing $(decorate file "$shellFile")"
      catchReturn "$handler" printf "%s" "" >"$functionsCache" || return $?
      while read -r functionName; do
        local lineNumber="${functionName%%:*}"
        functionName=$(trimSpace "${functionName#*:}")
        printf "%s %s %s\n" "$functionName" "$shellFile" "$lineNumber" | tee -a "$functionsCache" >>"$indexFile.unsorted"
        count=$((count + 1))
        if ! bashFileComment "$fullPath" "$lineNumber" >"$indexDirectory/comment/$functionName"; then
          throwEnvironment "$handler" "Documentation failed for $functionName" || return $?
        fi
      done < <(__pcregrep -n -o1 -M '\n\s*([a-zA-Z_][a-zA-Z_0-9]+)\(\)\s+\{\s*\n' "$fullPath")
      ! $verboseFlag || statusMessage decorate success "Generated $count functions for $shellFile"
    done < <(find "$codePath" -type f -name '*.sh' ! -path '*/.*/*' || :)
  done
  if ! $foundOne; then
    throwEnvironment "$handler" "No shell files found in $(decorate each file "${codePaths[@]}")" || return $?
  fi
  if [ ! -f "$indexFile.unsorted" ]; then
    throwEnvironment "$handler" "No functions found in $(decorate each file "${codePaths[@]}")" || return $?
  fi
  catchEnvironment "$handler" sort -u <"$indexFile.unsorted" >"$indexFile" || returnClean $? "$indexFile.sorted" "$indexFile" || return $?
  catchEnvironment "$handler" rm -f "$indexFile.unsorted" || return $?
  ! $verboseFlag || statusMessage --last printf -- "%s %s %s\n" "$(decorate info "Generated index for ")" "$(decorate code "$(decorate file "$codePath")")" "$(timingReport "$start" in)"
}
__documentationIndexGenerate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# List of functions which are not linked to anywhere in the documentation index
#
# Argument: cacheDirectory - Required. Directory. Index cache directory.
_documentationIndexUnlinkedFunctions() {
  local handler="_${FUNCNAME[0]}"

  local cacheDirectory=""

  local debugFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --debug) debugFlag=true ;;
    *)
      if ! cacheDirectory=$(usageArgumentDirectory "$handler" "cacheDirectory" "$1"); then
        return $?
      fi
      ;;
    esac
    shift
  done

  [ -n "$cacheDirectory" ] || throwArgument "$handler" "Need cacheDirectory" || return $?

  [ -f "$cacheDirectory/documentation.index" ] || throwEnvironment "$handler" "Need documentation index" || return $?
  [ -f "$cacheDirectory/code.index" ] || throwEnvironment "$handler" "Need code index" || return $?

  local tempFile clean=()
  tempFile=$(fileTemporaryName "$handler") || return $?
  clean+=("$tempFile")
  # shellcheck disable=SC2016
  catchEnvironment "$handler" awk '{ print $1 }' "$cacheDirectory/documentation.index" | sort -u >"$tempFile" || returnClean $? "${clean[@]}" || return $?
  # Things in `code.index` but not in `documentation.index`
  clean+=("$tempFile.code")
  # shellcheck disable=SC2016
  catchEnvironment "$handler" awk '{ print $1 }' "$cacheDirectory/code.index" | sort -u >"$tempFile.code" || returnClean $? "${clean[@]}" || return $?
  diff -U0 "$tempFile" "$tempFile.code" | grep -e '^[+][^+]' | cut -c 2- || :

  if $debugFlag; then
    dumpPipe --tail --lines 20 "documentation index" <"$tempFile" 1>&2
    dumpPipe --tail --lines 20 "code index" <"$tempFile.code" 1>&2
  fi
  catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
}
__documentationIndexUnlinkedFunctions() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Compute the documentationPath for all functions defined in documentationPath
# Argument: cacheDirectory - Required. Cache directory where the indexes live.
# Argument: documentationSource ... - OneOrMore. Documentation source path to find tokens and their definitions.
#
# Return Code: 0 - If success
# Return Code: 1 - Issue with file generation
# Return Code: 2 - Argument error
#
__documentationIndexDocumentation() {
  local handler="$1" && shift
  local start

  start=$(timingStart) || catchEnvironment "$handler" "timingStart failed" || return $?
  local cacheDirectory="" sourcePaths=() debugFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --debug) debugFlag=true ;;
    *)
      if [ -z "$cacheDirectory" ]; then
        cacheDirectory=$(usageArgumentDirectory "$handler" "cacheDirectory" "$argument") || return $?
      else
        sourcePaths+=("$(usageArgumentDirectory "$handler" "documentationSource" "$argument")") || return $?
      fi
      ;;
    esac
    shift
  done
  [ -n "$cacheDirectory" ] || throwArgument "$handler" "cacheDirectory required" || return $?
  [ 0 -lt "${#sourcePaths[@]}" ] || throwArgument "$handler" "documentationSource required" || return $?

  local indexFile="$cacheDirectory/documentation.index"
  local home
  home=$(catchReturn "$handler" buildHome) || return $?
  local sourcePath unsorted="$indexFile.unsorted"
  (
    catchEnvironment "$handler" rm -f "$indexFile" "$unsorted" || return $?
    catchEnvironment "$handler" muzzle pushd "$home" || return $?
    ! $debugFlag || decorate info "Moving to $home" 1>&2
    for sourcePath in "${sourcePaths[@]}"; do
      sourcePath="${sourcePath#"$home/"}"
      ! $debugFlag || decorate info "Indexing $sourcePath" 1>&2
      find "$sourcePath" -name '*.md' -print0 | xargs -0 grep -e "^{[_a-zA-Z][a-zA-Z0-9_]*}[[:space:]]*$" | sed 's/[{}]//g' | awk -F ":" "{ print \$2 \" \" \$1 }" >>"$unsorted" || :
      ! $debugFlag || decorate info "index is $(fileLineCount "$unsorted")" 1>&2
    done
    catchEnvironment "$handler" muzzle popd || returnClean $? "$indexFile" "$unsorted" || return $?
  )
  catchEnvironment "$handler" sort -u <"$unsorted" >"$indexFile" || returnClean $? "$indexFile" "$unsorted" || return $?
  total=$(fileLineCount "$indexFile")
  statusMessage decorate info "$(printf "%s %s %s %s %s %s\n" "$(decorate cyan Indexed)" "$(decorate cyan "$(pluralWord "$total" "function")")" "for" "$(decorate each file "${sourcePaths[@]}")" "in" "$(timingReport "$start")")"
}
___documentationIndexDocumentation() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: fn cacheDirectory
# Outputs relative path to cacheDirectory for shared handler
# Return Code: 1 - passed in directory must exist
#
__documentationIndexCache() {
  local handler="_${FUNCNAME[0]}"
  catchReturn "$handler" documentationBuildCache "index" || return $?
}
___documentationIndexCache() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
