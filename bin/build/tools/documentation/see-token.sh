#!/usr/bin/env bash
# see.sh
#
# See functionality
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.

__documentationSeeTokenTemplates() {
  local handler="$1" && shift
  local cacheDirectory="$1" && shift

  local templateCache
  templateCache=$(catchEnvironment "$handler" directoryRequire "$cacheDirectory/see/templates") || return $?
  local type file
  while [ $# -gt 1 ]; do
    type="$(usageArgumentString "$handler" "type" "$1")" || return $?
    file="$(usageArgumentFile "$handler" "file" "${2-}")" || return $?
    link="$(usageArgumentString "$handler" "link" "${3-}")" || return $?
    catchEnvironment "$handler" cp "$file" "$templateCache/$type" || return $?
    printf "%s\n" "$link" >"$templateCache/$type.link" || return $?
    shift 3
  done
}

__documentationSeeTokenGenerate() {
  local handler="$1" && shift
  local cacheDirectory="$1" && shift
  local matchingToken="$1" && shift
  local matchingPrefix="$1" && shift
  local tokenCache

  local home
  home=$(catchEnvironment "$handler" buildHome) || return $?

  tokenCache=$(catchEnvironment "$handler" directoryRequire "$cacheDirectory/see/tokens") || return $?
  if [ "$matchingToken" != "${matchingToken//../}" ]; then
    throwArgument "$handler" "Token contains invalid characters: $matchingToken" || return $?
  fi
  local checkFile="$tokenCache/$matchingToken.check"
  if [ -f "$tokenCache/$matchingToken" ]; then
    local checkFiles=()
    IFS=$'\n' read -r -d '' -a checkFiles <"$checkFile" || :
    [ "${#checkFiles[@]}" -gt 0 ] || throwEnvironment "$handler" "$matchingToken.check contains no files" || return $?
    if fileIsNewest "$tokenCache/$matchingToken" "${checkFiles[@]}"; then
      catchEnvironment "$handler" cat "$tokenCache/$matchingToken" || return $?
      return 0
    fi
  fi

  local templateCache
  templateCache=$(catchEnvironment "$handler" directoryRequire "$cacheDirectory/see/templates") || return $?
  local linkPatternFile="$tokenCache/$matchingToken.settings"

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
        lowerVariable=$(lowercase "$variable")
        __dumpSimpleValue "variable" "$variable"
        __dumpSimpleValue "lowerVariable" "$lowerVariable"
        __dumpSimpleValue "link" "$matchingPrefix"
        __documentationEnvironmentFileParse "$handler" "$settingsFile" || return $?
      else
        catchEnvironment "$handler" printf -- "%s\n" "$settingsFile" >>"$checkFile" || return $?
        linkType="file"
      fi
    fi
    linkPattern=""
    templateFile=""
    if [ -f "$templateCache/$linkType" ]; then
      linkPattern=$(catchEnvironment "$handler" head -n 1 "$templateCache/$linkType.link") || return $?
      templateFile="$templateCache/$linkType"
    fi
    __dumpSimpleValue "linkType" "$linkType"
    __dumpSimpleValue "fn" "$matchingToken"
    __dumpSimpleValue "lowerFn" "$(lowercase "$matchingToken")"
  } >"$linkPatternFile"

  local vv=(
    fn usage applicationHome applicationFile file
    base return_code description example argument linkType file line summary
    sourceLink documentationPath
  )
  export sourceLink documentationPath
  local __save_handler__="$handler"
  set -a # UNDO ok
  # shellcheck source=/dev/null
  source "$linkPatternFile"
  set +a
  handler="$__save_handler__"
  sourceLink="$(catchEnvironment "$handler" mapEnvironment "${vv[@]}" <<<"$linkPattern")" >>"$linkPatternFile" || return $?
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
    tokenValue=$(catchEnvironment "$handler" mapEnvironment "${vv[@]}" <"$templateFile" | tee "$tokenCache/$matchingToken") || return $?
  fi
  printf "%s\n" "$tokenValue"
}
