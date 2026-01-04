#!/usr/bin/env bash
# see.sh
#
# See functionality
#
# Copyright: Copyright &copy; 2026 Market Acumen, Inc.

# Summary: Link `{SEE:name}` tokens in documentation
#
# Post-processes any documentation and replaces tokens in the form `{SEE:name}` with links to documentation.
#
# Usage: {fn} cacheDirectory documentationSource documentationTarget
# Run `__documentationSeeTokenTemplates` beforehand to configure target token types for:
# - environment
# - file
# - function
#
__documentationIndexSeeLinker() {
  local handler="_${FUNCNAME[0]}"

  local start
  start=$(timingStart)

  # Argument parsing
  local cacheDirectory="" documentationSource="" documentationTarget=""
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
      if [ -z "$cacheDirectory" ]; then
        cacheDirectory=$(usageArgumentDirectory "$handler" "cacheDirectory" "$argument") || return $?
      elif [ -z "$documentationSource" ]; then
        documentationSource=$(usageArgumentDirectory "$handler" "documentationSource" "$argument") || return $?
      elif [ -z "$documentationTarget" ]; then
        documentationTarget=$(usageArgumentDirectory "$handler" "documentationTarget" "$argument") || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  local arg
  for arg in cacheDirectory documentationSource documentationTarget; do
    [ -n "${!arg}" ] || throwArgument "$handler" "$arg is required" || return $?
  done

  local home
  home=$(catchReturn "$handler" buildHome) || return $?
  documentationSource="${documentationSource#"$home"}"
  documentationSource="${documentationSource#/}"

  local seePattern='\{SEE:([^}]+)\}'

  local seeVariablesFile clean=()
  seeVariablesFile=$(fileTemporaryName "$handler") || return $?
  local linkPatternFile="$seeVariablesFile.linkPatterns"
  local variablesSedFile="$seeVariablesFile.variablesSedFile"
  local matchingFile matchingPrefix
  clean+=("$seeVariablesFile" "$linkPatternFile" "$variablesSedFile")
  if ! find "$documentationTarget" -name '*.md' -type f "$@" -print0 | xargs -0 "$(__pcregrepBinary)" -l "$seePattern" | while read -r matchingFile; do
    statusMessage decorate success "$matchingFile Found"
    matchingPrefix=${matchingFile#"$documentationTarget"}
    matchingPrefix="$(dirname "$matchingPrefix")"
    # Remove everything but slashes
    matchingPrefix="${matchingPrefix//[^\/]/}"
    # Length is number of dot-dots to the root
    matchingPrefix=$(repeat "${#matchingPrefix}" "../")

    local matchingToken
    while read -r matchingToken; do
      ! $debugFlag || statusMessage decorate success "$matchingFile: $(decorate cyan "$matchingToken") Found"
      local cleanToken
      cleanToken=$(printf "%s" "$matchingToken" | sed 's/[^A-Za-z0-9_]/_/g')
      local tokenName="SEE_$cleanToken"
      sedReplacePattern "{SEE:$matchingToken}" "{$tokenName}" >>"$variablesSedFile"
      tokenValue=$(__documentationSeeTokenGenerate "$handler" "$cacheDirectory" "$matchingToken") || return $?
      ! $debugFlag || statusMessage decorate pair "$tokenName" "$(newlineHide "$tokenValue")"
      local rel="{rel}"
      if [ "$tokenValue" != "${tokenValue#*"$rel"}" ]; then
        tokenValue="$(rel="$matchingPrefix" mapEnvironment rel <<<"$tokenValue")"
      fi
      catchEnvironment "$handler" __dumpNameValue "$tokenName" "$tokenValue" >>"$seeVariablesFile" || returnClean $? "${clean[@]}" || return $?
    done < <(__pcregrep -o1 "$seePattern" "$matchingFile")

    clean+=("$matchingFile.new")
    if ! (
      set -a # UNDO ok
      # shellcheck source=/dev/null
      if ! source "$seeVariablesFile" || ! sed -f "$variablesSedFile" <"$matchingFile" | mapEnvironment >"$matchingFile.new" || ! mv "$matchingFile.new" "$matchingFile"; then
        set +a
        rm -f "$seeVariablesFile" "$linkPatternFile" "$variablesSedFile" 2>/dev/null || :
        return "1"
      fi
      set +a
    ); then
      rm -f "${clean[@]}" "$seeVariablesFile" "$linkPatternFile" "$variablesSedFile" 2>/dev/null || :
      return 1
    fi
  done; then
    statusMessage --last decorate warning "No matching see directives found" || :
  fi
  rm -f "$seeVariablesFile" "$linkPatternFile" "$variablesSedFile" 2>/dev/null || :
  statusMessage --last timingReport "$start" "See completed in" || :
}

___documentationIndexSeeLinker() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
