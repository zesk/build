#!/usr/bin/env bash
#
# documentation-index.sh
#
# Generate an index of our bash functions for faster documentation generation.
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/documentation.md
# Test: o ./test/tools/documentation-tests.sh

# Summary: Link `{SEE:name}` tokens in documentation
#
# Post-processes any documentation and replaces tokens in the form `{SEE:name}` with links to documentation.
#
# Usage: {fn} cacheDirectory documentationDirectory seeFunctionTemplate seeFunctionLink seeFileTemplate seeFileLink
#
documentationIndex_SeeLinker() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex
  local cacheDirectory documentationDirectory seeFunctionTemplate seeFunctionLink seeFileTemplate seeFileLink
  local start linkPattern linkPatternFile
  local matchingFile matchingToken cleanToken
  local seePattern='\{SEE:([^}]+)\}'

  start=$(beginTiming)
  # Argument parsing
  cacheDirectory=
  documentationDirectory=
  seeFunctionTemplate=
  seeFunctionLink=
  seeFileTemplate=
  seeFileLink=
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        if [ -z "$cacheDirectory" ]; then
          cacheDirectory=$(usageArgumentDirectory _documentationIndex_SeeLinker "cacheDirectory" "${1%%/}") || return $?
        elif [ -z "$documentationDirectory" ]; then
          documentationDirectory=$(usageArgumentDirectory _documentationIndex_SeeLinker "documentationDirectory" "${1%%/}") || return $?
        elif [ -z "$seeFunctionTemplate" ]; then
          seeFunctionTemplate=$(usageArgumentFile _documentationIndex_SeeLinker seeFunctionTemplate "${1##./}") || return $?
          shift || :
          seeFunctionLink="$1"
        elif [ -z "$seeFileTemplate" ]; then
          seeFileTemplate=$(usageArgumentFile _documentationIndex_SeeLinker seeFileTemplate "${1##./}") || return $?
          shift || __failArgument "$usage" "seeFileLink required" || return $?
          seeFileLink="$1"
        else
          break
        fi
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || return $?
  done
  for arg in cacheDirectory documentationDirectory seeFunctionTemplate seeFileTemplate seeFunctionLink seeFileLink; do
    [ -n "${!arg}" ] || __failArgument "$usage" "$arg is required" || return $?
  done
  seeVariablesFile=$(fileTemporaryName "$usage") || return $?
  linkPatternFile="$seeVariablesFile.linkPatterns"
  variablesSedFile="$seeVariablesFile.variablesSedFile"
  if ! find "$documentationDirectory" -name '*.md' -type f "$@" -print0 | xargs -0 pcregrep -l "$seePattern" | while read -r matchingFile; do
    statusMessage decorate success "$matchingFile Found"
    pcre2grep -o1 "$seePattern" "$matchingFile" | while read -r matchingToken; do
      statusMessage decorate success "$matchingFile: $(decorate cyan "$matchingToken") Found"
      cleanToken=$(printf "%s" "$matchingToken" | sed 's/[^A-Za-z0-9_]/_/g')
      tokenName="SEE_$cleanToken"
      sedReplacePattern "{SEE:$matchingToken}" "{$tokenName}" >>"$variablesSedFile"
      {
        if settingsFile=$(documentationIndex_Lookup --settings "$cacheDirectory" "$matchingToken"); then
          cat "$settingsFile"
          linkPattern="$seeFunctionLink"
          templateFile="$seeFunctionTemplate"
          __dumpNameValue "linkType" "function"
          # __dumpNameValue "file" "$(documentationIndex_Lookup --file "$cacheDirectory" "$matchingToken")"
          __dumpNameValue "line" "$(documentationIndex_Lookup --line "$cacheDirectory" "$matchingToken")"
        elif settingsFile=$(documentationIndex_Lookup --file "$cacheDirectory" "$matchingToken"); then
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
  statusMessage --last reportTiming "$start" "See completed in" || :
}
_documentationIndex_SeeLinker() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
