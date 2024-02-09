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

# Summary: Link `{SEE:name}` tokens in documentation
#
# Post-processes any documentation and replaces tokens in the form `{SEE:name}` with links to documentation.
#
# Usage: {fn} cacheDirectory documentationDirectory seeFunctionTemplate seeFunctionLink seeFileTemplate seeFileLink
#
documentationIndex_SeeLinker() {
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
    case $1 in
      --help)
        usageDocument 0 "$(basename "${BASH_SOURCE[0]}")" "${FUNCNAME[0]}"
        return $?
        ;;
      *)
        if [ -z "$cacheDirectory" ]; then
          cacheDirectory="${1%%/}"
        elif [ -z "$documentationDirectory" ]; then
          if [ ! -d "$1" ]; then
            consoleError "documentationDirectory is not a directory $documentationDirectory" 1>&2
            return $errorArgument
          fi
          documentationDirectory="${1%%/}"
        elif [ -z "$seeFunctionTemplate" ]; then
          seeFunctionTemplate="${1##./}"
          shift || :
          if [ $# -eq 0 ]; then
            consoleError "seeFunctionLink required" 1>&2
            return $errorArgument
          fi
          seeFunctionLink="$1"
        elif [ -z "$seeFileTemplate" ]; then
          seeFileTemplate="${1##./}"
          shift || :
          if [ $# -eq 0 ]; then
            consoleError "seeFileLink required" 1>&2
            return $errorArgument
          fi
          seeFileLink="$1"
        else
          break
        fi
        ;;
    esac
    shift
  done
  if [ -z "$cacheDirectory" ]; then
    consoleError "cacheDirectory is required" 1>&2
    return $errorArgument
  fi
  if [ ! -d "$cacheDirectory" ]; then
    consoleError "cacheDirectory is not a directory $cacheDirectory" 1>&2
    return $errorArgument
  fi
  if [ -z "$documentationDirectory" ]; then
    consoleError "documentationDirectory is required" 1>&2
    return $errorArgument
  fi
  if [ -z "$seeFunctionTemplate" ]; then
    consoleError "seeFunctionTemplate is required" 1>&2
    return $errorArgument
  fi
  if [ ! -f "$seeFunctionTemplate" ]; then
    consoleError "seeFunctionTemplate is not a file $seeFunctionTemplate" 1>&2
    return $errorArgument
  fi
  if [ -z "$seeFileTemplate" ]; then
    consoleError "seeFileTemplate is required" 1>&2
    return $errorArgument
  fi
  if [ ! -f "$seeFileTemplate" ]; then
    consoleError "$seeFileTemplate is not a file $seeFileTemplate" 1>&2
    return $errorArgument
  fi

  seeVariablesFile=$(mktemp)
  linkPatternFile=$(mktemp)
  variablesSedFile=$(mktemp)
  if ! find "$documentationDirectory" -name '*.md' -type f "$@" -print0 |
    xargs -0 pcre2grep -l "$seePattern" |
    while read -r matchingFile; do
      statusMessage consoleSuccess "$matchingFile Found"
      pcre2grep -o1 "$seePattern" "$matchingFile" | while read -r matchingToken; do
        statusMessage consoleSuccess "$matchingFile: $(consoleCyan "$matchingToken") Found"
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
        __dumpNameValue "sourceLink" "$(mapValue "$linkPatternFile" "$linkPattern")" >>"$linkPatternFile"
        if [ -z "$templateFile" ]; then
          __dumpNameValue "$tokenName" "Not found" >>"$seeVariablesFile"
        else
          __dumpNameValue "$tokenName" "$(mapValue "$linkPatternFile" "$(cat "$templateFile")")" >>"$seeVariablesFile"
        fi
      done
      if ! (
        statusMessage consoleInfo "Linking $matchingFile ..."
        set -a
        # shellcheck source=/dev/null
        if ! source "$seeVariablesFile" ||
          ! sed -f "$variablesSedFile" <"$matchingFile" | mapEnvironment >"$matchingFile.new" ||
          ! mv "$matchingFile.new" "$matchingFile"; then
          rm -f "$seeVariablesFile" "$linkPatternFile" "$variablesSedFile" 2>/dev/null || :
          return "$errorEnvironment"
        fi
      ); then
        rm -f "$seeVariablesFile" "$linkPatternFile" "$variablesSedFile" 2>/dev/null || :
        return "$errorEnvironment"
      fi
    done; then
    clearLine
    consoleWarning "No matching see directives found" 1>&2
  fi
  rm -f "$seeVariablesFile" "$linkPatternFile" "$variablesSedFile" 2>/dev/null || :
  clearLine
  reportTiming "$start" "See completed in"
}