#!/usr/bin/env bash
# see.sh
#
# See functionality
#
# Copyright: Copyright &copy; 2026 Market Acumen, Inc.

__documentationSeeTokenTemplates() {
  local handler="$1" && shift
  local cacheDirectory="$1" && shift

  local templateCache
  templateCache=$(catchReturn "$handler" directoryRequire "$cacheDirectory/see/templates") || return $?
  local type file
  while [ $# -gt 1 ]; do
    type="$(validate "$handler" String "type" "$1")" || return $?
    file="$(validate "$handler" File "file" "${2-}")" || return $?
    link="$(validate "$handler" String "link" "${3-}")" || return $?
    catchEnvironment "$handler" cp "$file" "$templateCache/$type" || return $?
    printf "%s\n" "$link" >"$templateCache/$type.link" || return $?
    shift 3
  done
}

__documentationSeeTokenGenerate() {
  local handler="$1" && shift
  local cacheDirectory="$1" && shift
  local matchingToken="$1" && shift
  local tokenCache

  local home
  home=$(catchReturn "$handler" buildHome) || return $?

  tokenCache=$(catchReturn "$handler" directoryRequire "$cacheDirectory/see/tokens") || return $?
  if [ "$matchingToken" != "${matchingToken//../}" ]; then
    throwEnvironment "$handler" "Token contains invalid characters: $matchingToken" || return $?
  fi
  local matchingTokenFile="${matchingToken//[^A-Za-z0-9]/_}"
  local tokenCacheFile="$tokenCache/$matchingTokenFile"
  local checkFile="$tokenCacheFile.check"
  if [ -f "$tokenCacheFile" ]; then
    local checkFiles=()
    IFS=$'\n' read -r -d '' -a checkFiles <"$checkFile" || :
    [ "${#checkFiles[@]}" -gt 0 ] || throwEnvironment "$handler" "$matchingToken.check contains no files" || return $?
    if fileIsNewest "$tokenCacheFile" "${checkFiles[@]}"; then
      catchEnvironment "$handler" cat "$tokenCacheFile" || return $?
      return 0
    fi
  fi

  local templateCache
  templateCache=$(catchReturn "$handler" directoryRequire "$cacheDirectory/see/templates") || return $?
  local linkPatternFile="$tokenCacheFile.settings"

  {
    local settingsFile linkPattern templateFile linkType="unknown"
    if [ "${matchingToken}" = "${matchingToken%.*}" ] && settingsFile=$(__documentationIndexLookup "$handler" --settings "$matchingToken"); then
      linkType="function"
      cat "$settingsFile"
      catchEnvironment "$handler" printf -- "%s\n" "$settingsFile" >>"$checkFile" || return $?
      __dumpSimpleValue "line" "$(__documentationIndexLookup "$handler" --line "$matchingToken")"
    elif settingsFile=$(__documentationIndexLookup "$handler" --file "$matchingToken"); then
      settingsFile="$(printf -- "%s\n" "$settingsFile" | sort | head -n 1)" || return $?
      __dumpSimpleValue "file" "$settingsFile"
      if stringBegins "$settingsFile" "bin/build/env" "bin/env"; then
        catchEnvironment "$handler" printf -- "%s\n" "$home/$settingsFile" >>"$checkFile" || return $?
        linkType="environment"
        local variable lowerVariable
        variable="$(basename "$settingsFile")"
        variable="${variable%.sh}"
        lowerVariable=$(stringLowercase "$variable")
        __dumpSimpleValue "variable" "$variable"
        __dumpSimpleValue "lowerVariable" "$lowerVariable"
        __dumpSimpleValue "line" ""
        __documentationEnvironmentFileParse "$handler" "$settingsFile" || return $?
      else
        catchEnvironment "$handler" printf -- "%s\n" "$settingsFile" >>"$checkFile" || return $?
        __dumpSimpleValue "line" ""
        linkType="file"
      fi
    fi
    linkPattern=""
    templateFile=""
    if [ -f "$templateCache/$linkType" ]; then
      linkPattern=$(catchEnvironment "$handler" head -n 1 "$templateCache/$linkType.link") || return $?
      __dumpSimpleValue "link" "$linkPattern"
      templateFile="$templateCache/$linkType"
    fi
    __dumpSimpleValue "linkType" "$linkType"
    __dumpSimpleValue "fn" "$matchingToken"
    __dumpSimpleValue "lowerFn" "$(stringLowercase "$matchingToken")"
  } >"$linkPatternFile"

  local vv=(
    fn lowerFn usage applicationHome applicationFile file line
    base return_code description example argument linkType summary
    sourceLink documentationPath build_debug variable lowerVariable link type
  )
  (
    export sourceLink documentationPath
    local __save_handler__="$handler"
    set -a # UNDO ok
    # shellcheck source=/dev/null
    source "$linkPatternFile"
    set +a
    handler="$__save_handler__"
    sourceLink="$(catchReturn "$handler" mapEnvironment "${vv[@]}" <<<"$linkPattern")" || return $?
    documentationPath="$(__documentationIndexLookup "$handler" --documentation "$matchingToken" | head -n 1 || :)"
    if [ -n "$documentationPath" ]; then
      documentationPath="${documentationPath#"$home"}"
      documentationPath="${documentationPath#/}"
      documentationPath="${documentationPath#"$documentationSource"}"
      documentationPath="${documentationPath#/}"
    else
      documentationPath="#not-found-$matchingToken"
    fi
    if [ -z "$templateFile" ]; then
      printf "%s\n" "$matchingToken - (not found)"
    else
      catchReturn "$handler" mapEnvironment "${vv[@]}" <"$templateFile" | tee "$tokenCacheFile" || return $?
    fi
  ) || return $?
}
