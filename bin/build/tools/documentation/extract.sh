#!/usr/bin/env bash
#
# Documentation
#
# Copyright &copy; 2026 Market Acumen, Inc.

# Argument: handler - Required. Function.
# Argument: fn - String. Required.
__bashDocumentationSettingsHeader() {
  local handler="$1" && shift

  fn=$(validate "$handler" String "fn" "${1-}") && shift || return $?

  # Hides 'unused' messages so shellcheck should succeed
  printf '%s\n' '# shellcheck disable=SC2034'

  catchReturn "$handler" __dumpSimpleValue "fn" "$fn" || return $?
}

# Argument: handler - Required. Function.
# Argument: definitionFile - Required. File.
__bashDocumentationSettingsFileDetails() {
  local handler="$1" && shift

  local definitionFile lineNumber

  definitionFile=$(validate "$handler" RealFile "definitionFile" "${1-}") && shift || return $?
  local lineNumber="${1-}"

  local home
  home=$(catchReturn "$handler" buildHome) || return $?

  local file="${definitionFile#"${home%/}"/}"
  catchReturn "$handler" __dumpSimpleValue "file" "$file" || return $?
  catchReturn "$handler" __dumpSimpleValue "sourceFile" "$file" || return $?
  catchReturn "$handler" __dumpSimpleValue "sourceHash" "$(shaPipe <"$definitionFile")" || return $?
  catchReturn "$handler" __dumpSimpleValue "base" "$(basename "$definitionFile")" || return $?
  [ -z "$lineNumber" ] || catchReturn "$handler" __dumpSimpleValue "sourceLine" "$lineNumber" || return $?
}

# Caching version - __bashDocumentationExtractDirect does the actual work
# Argument: handler - Function. Required.
# Argument: function - String. Required.
# Argument: sourceFile - File. Required.
# Argument: --generate - Flag. Optional. Generate cached files.
# Argument: --no-cache - Flag. Optional. Skip any attempt to cache anything.
# Argument: --cache - Flag. Optional. Force use of cache.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# BUILD_DEBUG: usage-cache-skip - Skip caching by default (override with `--cache`)
__bashDocumentationExtract() {
  local __saved=("$@") __count=$#

  local handler="$1" && shift
  local generateCache=false fn="" source="" checkCache=true

  ! buildDebugEnabled usage-cache-skip || checkCache=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --generate) generateCache=true ;;
    --no-cache) checkCache=false ;;
    --cache) checkCache=true ;;
    *)
      if [ -z "$fn" ]; then
        fn=$(validate "$handler" String "fn" "${1-}") || return $?
      elif [ -z "$source" ]; then
        source=$(validate "$handler" File "source" "${1-}") || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local definitionFile="$home/bin/build/documentation/$fn.sh"
  if $generateCache; then
    if __bashDocumentationExtractCheckCache "$handler" "$source" "$definitionFile"; then
      return 0
    fi
    __bashDocumentationExtractGenerateCache "$handler" "$source" "$definitionFile" "$fn" || return $?
  elif $checkCache && [ -x "$definitionFile" ] && [ "$definitionFile" -nt "$source" ]; then
    catchEnvironment "$handler" cat "$definitionFile" || return $?
    return 0
  else
    __bashDocumentationExtractDirect "$handler" "$fn" "$source" "$@" || return $?
  fi

}
__bashDocumentationExtractCheckCache() {
  local handler="$1" source="$2" definitionFile="$3"
  local sourceHash && sourceHash=$(catchReturn "$handler" shaPipe <"$source") || return $?
  if [ -f "$definitionFile" ] && [ "$source" -ot "$definitionFile" ]; then
    local savedSourceHash
    savedSourceHash=$(
      local sourceHash sourceFile=""
      # shellcheck source=/dev/null
      catchEnvironment "$handler" source "$definitionFile" || return $?
      if [ -n "$sourceFile" ]; then
        catchEnvironment "$handler" printf -- "%s\n" "${sourceHash-}" || return $?
      fi
    ) || :
    if [ "$savedSourceHash" -eq "$sourceHash" ]; then
      catchEnvironment "$handler" touch "$definitionFile" || return $?
      catchEnvironment "$handler" cat "$definitionFile" || return $?
      return 0
    fi
  fi
  return 1
}

__bashDocumentationExtractGenerateCache() {
  local handler="$1" && shift
  local source="$1" && shift
  local definitionFile="$1" && shift
  local fn="$1" && shift

  local variableList="sourceFile,fn,usage,argument,description,usage,summary,file,base,sourceHash,foundNames"

  catchEnvironment "$handler" muzzle fileDirectoryRequire "$definitionFile" || return $?
  catchEnvironment "$handler" touch "$definitionFile" || return $?
  catchEnvironment "$handler" chmod +x "$definitionFile" || return $?
  (
    local extras=()
    extras+=("#!/usr/bin/env bash" "# Copyright &copy; $(date +%Y) $(catchReturn "$handler" buildEnvironmentGet BUILD_COMPANY)") || return $?
    extras+=("# Generated on $(dateToday)")
    catchReturn "$handler" environmentClean || return $?
    local uncompiled="${definitionFile%.sh}.sh.uncompiled"
    local clean=("$uncompiled" "$uncompiled.finished")
    bashRecursionDebug || return $?
    __bashDocumentationExtractDirect "$handler" "$fn" "$source" "${extras[@]}" "$@" >"$uncompiled" || returnClean $? "${clean[@]}" || $?
    bashRecursionDebug --end || return $?
    catchEnvironment "$handler" environmentCompile --keep-comments --parse --variables "$variableList" <"$uncompiled" | catchEnvironment "$handler" tee "$uncompiled.finished" || returnClean $? "${clean[@]}" || $?
    if ! grep -q '^sourceFile=' "$uncompiled.finished"; then
      consoleLineFill
      dumpPipe uncompiled < <(grep source <"$uncompiled") || return $?
      dumpPipe compiled <"$uncompiled.finished" || return $?
      throwEnvironment "$handler" "Final $definitionFile does not contain sourceFile=?" || returnClean $? "${clean[@]}" || return $?
    fi
    catchEnvironment "$handler" mv -f "$uncompiled.finished" "$definitionFile" || returnClean $? "${clean[@]}" || $?
    catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
  ) || return $?
}

# Argument: handler - Function. Required.
# Argument: function - String. Required.
# Argument: sourceFile - File. Required.
# Argument: prefix ... - String. Optional. Output this prefix to the resulting file
__bashDocumentationExtractDirect() {
  local __saved=("$@") __count=$#
  local handler="$1" && shift
  local fn="$1" && shift
  local source="$1" && shift

  # ********************************************************************************************************************
  # Configure your profiling flags as desired using whatever global needed
  export BUILD_DEBUG
  local flag=",usage-profile," flags=",${BUILD_DEBUG-},"

  # IDENTICAL profileFunctionHead 4
  # ********************************************************************************************************************
  local __profile="false" __profile0="" __profileNext __profileUsed=0 __profileLabel="arguments (#$__count)" __profilePrefix="Profile-${FUNCNAME[0]}: "
  if [ -n "$flags" ] && [ "${flags#*"$flag"}" != "$flags" ]; then __profile=$(timingStart) && __profile0=$__profile; fi
  # ********************************************************************************************************************
  catchEnvironment "$handler" printf -- "%s\n" "$@" || return $?
  # subshell to hide exports
  local dumper line
  export fn base

  local mapNames=("fn") simpleNames=("fn")
  local desc=() lastName="" foundNames=() lastName="" values=() rawComment="" finished=false
  __bashDocumentationSettingsHeader "$handler" "$fn" || return $?
  # Read comment (stripped of #) from stdin
  while ! $finished; do
    IFS= read -r line || finished=true
    [ -n "$line" ] || continue
    rawComment="$rawComment$line"$'\n'
    local name="${line%%:*}" value cleanName
    cleanName="$(catchReturn "$handler" tr '[:upper:]' '[:lower:]' <<<"${name//[- ]/_}")" || return $?
    __profileLabel="$cleanName"
    # IDENTICAL profileFunctionMarker 3
    # ********************************************************************************************************************
    if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
    # ********************************************************************************************************************

    if ! environmentVariableNameValid "$cleanName" || [ "$name" = "$line" ] || [ "${line%%:}" != "$line" ] || [ "${line##:}" != "$line" ]; then
      # no colon or ends with colon *or* starts with :
      # strip starting colon (end colon STAYS)
      value="${line##:}"
      if [ "${#desc[@]}" -gt 0 ] || [ "$(trimSpace "$value")" != "" ]; then
        desc+=("$value")
      fi
    else
      value="${line#*:}"
      value="${value# }"
      name="$cleanName"
      case "$name" in
      ":sourceFile") name="${name:1}" && source="$value" ;;
      ":sourceLine") name="${name:1}" ;;
      esac
      case "$name" in
      "shellcheck") continue ;;
      "description")
        value="$(catchReturn "$handler" trimSpace "$value")" || return $?
        [ -z "$value" ] || desc+=("$value")
        continue
        ;;
      esac
      if [ -n "$lastName" ] && [ "$lastName" != "$name" ]; then
        dumper=__dumpNameValueAppend
        if ! inArray "$lastName" "${foundNames[@]+${foundNames[@]}}"; then
          foundNames+=("$lastName")
          inArray "$lastName" "${simpleNames[@]}" && dumper=__dumpSimpleValue || dumper=__dumpNameValue
        fi
        catchReturn "$handler" "$dumper" "$lastName" "${values[@]}" || return $?
        values=()
      fi
      : "$fn"
      if [ "${value#*{}" != "$value" ]; then
        value="$(catchReturn "$handler" mapEnvironment "${mapNames[@]}" <<<"$value")" || return $?
      fi
      values+=("$value")
      lastName="$name"
    fi
  done
  if [ -f "$source" ]; then
    __bashDocumentationSettingsFileDetails "$handler" "$source" || return $?
  elif [ -n "$source" ]; then
    throwArgument "$handler" "source is not a file: $source" || return $?
  fi
  if [ "${#values[@]}" -gt 0 ]; then
    dumper=__dumpNameValueAppend
    if ! inArray "$lastName" "${foundNames[@]+"${foundNames[@]}"}"; then
      foundNames+=("$lastName")
      inArray "$lastName" "${simpleNames[@]}" && dumper=__dumpSimpleValue || dumper=__dumpNameValue
    fi
    catchReturn "$handler" "$dumper" "$lastName" "${values[@]}" || return $?
  fi
  if [ "${#desc[@]}" -gt 0 ]; then
    catchReturn "$handler" __dumpNameValue "description" "${desc[@]}" || return $?
    if ! inArray "summary" "${foundNames[@]+"${foundNames[@]}"}"; then
      local summary
      summary="$(trimWords 10 "${desc[0]}")"
      [ -n "$summary" ] || summary="undocumented"
      catchReturn "$handler" __dumpSimpleValue "summary" "$summary" || return $?
      catchReturn "$handler" __dumpSimpleValue "summaryComputed" "true" || return $?
    fi
  elif inArray "summary" "${foundNames[@]+${foundNames[@]}}"; then
    catchReturn "$handler" __dumpAliasedValue description summary || return $?
  else
    catchReturn "$handler" __dumpNameValue "description" "No documentation for \`$fn\`." || return $?
    catchReturn "$handler" __dumpSimpleValue "summary" "undocumented" || return $?
  fi
  if ! inArray "return_code" "${foundNames[@]+"${foundNames[@]}"}"; then
    catchReturn "$handler" __dumpNameValue "return_code" '0 - Success' '1 - Environment error' '2 - Argument error' || return $?
  fi
  if ! inArray "fn" "${foundNames[@]+"${foundNames[@]}"}"; then
    catchReturn "$handler" __dumpSimpleValue "fn" "$fn" || return $?
  fi
  if ! inArray "argument" "${foundNames[@]+${foundNames[@]}}"; then
    catchReturn "$handler" __dumpSimpleValue "argument" "none" || return $?
    if ! inArray "usage" "${foundNames[@]+"${foundNames[@]}"}"; then
      catchReturn "$handler" __dumpAliasedValue "usage" "fn" || return $?
    fi
  else
    if ! inArray "usage" "${foundNames[@]+"${foundNames[@]}"}"; then
      # lazy
      catchReturn "$handler" printf "%s\n" "export usage; usage=\"\$fn\$(__bashDocumentationDefaultArguments \"\$argument\")\"" || return $?
    fi
  fi
  catchReturn "$handler" __dumpNameValue "rawComment" "$rawComment" || return $?
  catchReturn "$handler" __dumpArrayValue "foundNames" "${foundNames[@]+"${foundNames[@]}"}" || return $?

  # IDENTICAL profileFunctionTail 7
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then
    __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2
    printf -- "Line %d: %s%d %s (%d + %d) %s + %s %d%%\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile0))" '*TOTAL*' "$((__profileNext - __profile0 - __profileUsed))" "$__profileUsed" 'us' 'them' "$(((100 * __profileUsed) / (__profileNext - __profile0)))" 1>&2
  fi
  # ********************************************************************************************************************

  return 0
}
