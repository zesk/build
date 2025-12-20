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
# Usage: {fn} cacheDirectory documentationSource documentationTarget seeFunctionTemplate seeFunctionLink seeFileTemplate seeFileLink
#
__documentationIndexSeeLinker() {
  local handler="_${FUNCNAME[0]}"

  local start
  start=$(timingStart)

  # Argument parsing
  local cacheDirectory="" documentationSource="" documentationTarget=""
  local seeFunctionTemplate="" seeFunctionLink="" seeFileTemplate="" seeFileLink=""
  local seeEnvironmentTemplate="" seeEnvironmentLink=""
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
      elif [ -z "$seeFunctionTemplate" ]; then
        seeFunctionTemplate=$(usageArgumentFile "$handler" seeFunctionTemplate "$argument") || return $?
        shift || :
        seeFunctionLink="${1-}"
      elif [ -z "$seeFileTemplate" ]; then
        seeFileTemplate=$(usageArgumentFile "$handler" seeFileTemplate "${1##./}") || return $?
      elif [ -z "$seeFileLink" ]; then
        seeFileLink=$(usageArgumentString "$handler" seeFileLink "${1-}") || return $?
      elif [ -z "$seeEnvironmentTemplate" ]; then
        seeEnvironmentTemplate=$(usageArgumentFile "$handler" seeFileLink "${1-}") || return $?
      elif [ -z "$seeEnvironmentLink" ]; then
        seeEnvironmentLink=$(usageArgumentString "$handler" seeFileLink "${1-}") || return $?
      else
        break
      fi
      ;;
    esac
    shift
  done

  local home
  home=$(catchReturn "$handler" buildHome) || return $?
  documentationSource="${documentationSource#"$home"}"
  documentationSource="${documentationSource#/}"

  local seePattern='\{SEE:([^}]+)\}'

  local arg
  for arg in cacheDirectory documentationTarget seeFunctionTemplate seeFileTemplate seeFunctionLink seeFileLink; do
    [ -n "${!arg}" ] || throwArgument "$handler" "$arg is required" || return $?
  done
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
      {
        local settingsFile linkPattern templateFile
        if settingsFile=$(__documentationIndexLookup "$handler" --settings "$matchingToken"); then
          cat "$settingsFile"
          linkPattern="$seeFunctionLink"
          templateFile="$seeFunctionTemplate"
          __dumpSimpleValue "linkType" "function"
          # __dumpSimpleValue "file" "$(__documentationIndexLookup "$handler" --file "$cacheDirectory" "$matchingToken")"
          __dumpSimpleValue "line" "$(__documentationIndexLookup "$handler" --line "$matchingToken")"
        elif settingsFile=$(__documentationIndexLookup "$handler" --file "$matchingToken"); then
          settingsFile="$(printf -- "%s\n" "$settingsFile" | sort | head -n 1)" || return $?
          __dumpSimpleValue "file" "$settingsFile"
          if stringBegins "$settingsFile" "bin/build/env" "bin/env"; then
            local variable
            variable="$(basename "$settingsFile")"
            variable="${variable%.sh}"
            __dumpSimpleValue "variable" "$variable"
            __dumpSimpleValue "linkType" "environment"
            __dumpSimpleValue "link" "$seeEnvironmentLink"
            templateFile="$seeEnvironmentTemplate"
            __documentationEnvironmentFileParse "$handler" "$settingsFile" || returnClean $? "${clean[@]}" || return $?
          else
            linkPattern="$seeFileLink"
            templateFile="$seeFileTemplate"
            __dumpSimpleValue "linkType" "file"
          fi
        else
          linkPattern=""
          templateFile=""
          __dumpSimpleValue "linkType" "unknown"
        fi
        __dumpSimpleValue "fn" "$matchingToken"
      } >"$linkPatternFile"

      local vv=(
        fn usage applicationHome applicationFile file
        base return_code description example argument linkType file line summary
        sourceLink documentationPath
      )
      export sourceLink documentationPath
      set -a # UNDO ok
      # shellcheck source=/dev/null
      source "$linkPatternFile"
      set +a
      handler="_${FUNCNAME[0]}"
      sourceLink="$(catchEnvironment "$handler" mapEnvironment "${vv[@]}" <<<"$linkPattern")" >>"$linkPatternFile" || returnClean $? "${clean[@]}" || return $?
      documentationPath="$(__documentationIndexLookup "$handler" --documentation "$matchingToken" | head -n 1 || :)"
      if [ -n "$documentationPath" ]; then
        documentationPath="${documentationPath#"$home"}"
        documentationPath="${documentationPath#/}"
        documentationPath="${documentationPath#"$documentationSource"}"
        documentationPath="$matchingPrefix${documentationPath#/}"
      else
        documentationPath="#not-found-$matchingToken"
      fi
      local tokenValue
      if [ -z "$templateFile" ]; then
        tokenValue="Not found"
      else
        tokenValue=$(catchEnvironment "$handler" mapEnvironment "${vv[@]}" <"$templateFile") || returnClean $? "${clean[@]}" || return $?
      fi
      ! $debugFlag || statusMessage decorate pair "$tokenName" "$(newlineHide "$tokenValue")"
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
