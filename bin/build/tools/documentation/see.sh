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

# Summary: Link `{SEE:name}` tokens in documentation
#
# Post-processes any documentation and replaces tokens in the form `{SEE:name}` with links to documentation.
#
# Usage: {fn} cacheDirectory documentationDirectory seeFunctionTemplate seeFunctionLink seeFileTemplate seeFileLink
#
__documentationIndex_SeeLinker() {
  local handler="_${FUNCNAME[0]}"

  local start
  start=$(timingStart)

  # Argument parsing
  local cacheDirectory="" documentationDirectory="" seeFunctionTemplate="" seeFunctionLink="" seeFileTemplate="" seeFileLink=""

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
        cacheDirectory=$(usageArgumentDirectory "$handler" "cacheDirectory" "${1%%/}") || return $?
      elif [ -z "$documentationDirectory" ]; then
        documentationDirectory=$(usageArgumentDirectory "$handler" "documentationDirectory" "${1%%/}") || return $?
      elif [ -z "$seeFunctionTemplate" ]; then
        seeFunctionTemplate=$(usageArgumentFile "$handler" seeFunctionTemplate "${1##./}") || return $?
        shift || :
        seeFunctionLink="$1"
      elif [ -z "$seeFileTemplate" ]; then
        seeFileTemplate=$(usageArgumentFile "$handler" seeFileTemplate "${1##./}") || return $?
        shift || __throwArgument "$handler" "seeFileLink required" || return $?
        seeFileLink="$1"
      else
        break
      fi
      ;;
    esac
    shift
  done

  local seePattern='\{SEE:([^}]+)\}'

  local arg
  for arg in cacheDirectory documentationDirectory seeFunctionTemplate seeFileTemplate seeFunctionLink seeFileLink; do
    [ -n "${!arg}" ] || __throwArgument "$handler" "$arg is required" || return $?
  done
  local seeVariablesFile
  seeVariablesFile=$(fileTemporaryName "$handler") || return $?
  local linkPatternFile="$seeVariablesFile.linkPatterns"
  local variablesSedFile="$seeVariablesFile.variablesSedFile"
  local matchingFile
  if ! find "$documentationDirectory" -name '*.md' -type f "$@" -print0 | xargs -0 "$(__pcregrepBinary)" -l "$seePattern" | while read -r matchingFile; do
    statusMessage decorate success "$matchingFile Found"
    local matchingToken
    __pcregrep -o1 "$seePattern" "$matchingFile" | while read -r matchingToken; do
      statusMessage decorate success "$matchingFile: $(decorate cyan "$matchingToken") Found"
      local cleanToken
      cleanToken=$(printf "%s" "$matchingToken" | sed 's/[^A-Za-z0-9_]/_/g')
      local tokenName="SEE_$cleanToken"
      sedReplacePattern "{SEE:$matchingToken}" "{$tokenName}" >>"$variablesSedFile"
      {
        local settingsFile linkPattern templateFile
        if settingsFile=$(__documentationIndex_Lookup --settings "$cacheDirectory" "$matchingToken"); then
          cat "$settingsFile"
          linkPattern="$seeFunctionLink"
          templateFile="$seeFunctionTemplate"
          __dumpNameValue "linkType" "function"
          # __dumpNameValue "file" "$(__documentationIndex_Lookup --file "$cacheDirectory" "$matchingToken")"
          __dumpNameValue "line" "$(__documentationIndex_Lookup --line "$cacheDirectory" "$matchingToken")"
        elif settingsFile=$(__documentationIndex_Lookup --file "$cacheDirectory" "$matchingToken"); then
          linkPattern="$seeFileLink"
          templateFile="$seeFileTemplate"
          __dumpNameValue "linkType" "file"
          __dumpNameValue "file" "$settingsFile"
        else
          linkPattern=""
          templateFile=""
          __dumpNameValue "linkType" "unknown"
        fi
        __dumpNameValue "fn" "$matchingToken"
      } >"$linkPatternFile"

      # shellcheck disable=SC2094
      __dumpNameValue "sourceLink" "$(mapValueTrim "$linkPatternFile" "$linkPattern")" >>"$linkPatternFile"
      if [ -z "$templateFile" ]; then
        __dumpNameValue "$tokenName" "Not found" >>"$seeVariablesFile"
      else
        __dumpNameValue "$tokenName" "$(mapValue "$linkPatternFile" "$(cat "$templateFile")")" >>"$seeVariablesFile"
      fi
    done
    if ! (
      statusMessage decorate info "Linking $matchingFile ..."
      set -a
      # shellcheck source=/dev/null
      if ! source "$seeVariablesFile" ||
        ! sed -f "$variablesSedFile" <"$matchingFile" | mapEnvironment >"$matchingFile.new" ||
        ! mv "$matchingFile.new" "$matchingFile"; then
        rm -f "$seeVariablesFile" "$linkPatternFile" "$variablesSedFile" 2>/dev/null || :
        return "1"
      fi
    ); then
      rm -f "$seeVariablesFile" "$linkPatternFile" "$variablesSedFile" 2>/dev/null || :
      return "1"
    fi
  done; then
    statusMessage --last decorate warning "No matching see directives found" || :
  fi
  rm -f "$seeVariablesFile" "$linkPatternFile" "$variablesSedFile" 2>/dev/null || :
  statusMessage --last timingReport "$start" "See completed in" || :
}
___documentationIndex_SeeLinker() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
