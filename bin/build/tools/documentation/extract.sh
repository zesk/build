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
  catchReturn "$handler" __dumpSimpleValue "original" "$fn" || return $?
}

# Caching version - __bashDocumentationExtractDirect does the actual work
__bashDocumentationExtract() {
  local __saved=("$@") __count=$#

  local handler="$1" && shift
  local generateCache=false fn="" source="" checkCache=true derivations=() lineNumber=""

  ! buildDebugEnabled usage-cache-skip || checkCache=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --line) shift && lineNumber=$(validate "$handler" PositiveInteger "$argument" "${1-}") || return $? ;;
    --generate) generateCache=true ;;
    --no-cache) checkCache=false && generateCache=false ;;
    --function) derivations+=("return_code" "fn" "lowerFn" "fnMarker" "argument" "usage") ;;
    --environment) derivations+=("env" "envMarker" "name") ;;
    --cache) checkCache=true ;;
    *)
      if [ -z "$fn" ]; then
        fn=$(validate "$handler" String "fn" "${1-}") || return $?
      elif [ -z "$source" ]; then
        source=$(validate "$handler" File "source" "${1-}") || return $?
      else
        break
      fi
      ;;
    esac
    shift
  done

  [ -n "$fn" ] || throwArgument "$handler" "fn is required" || return $?
  [ -n "$source" ] || throwArgument "$handler" "source is required" || return $?

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  if $generateCache || $checkCache; then
    local definitionFile && definitionFile=$(__functionSettings "$home" "$fn" true) || return $?
    if $generateCache; then
      if __bashDocumentationExtractCheckCache "$handler" "$source" "$definitionFile"; then
        return 0
      fi
      __bashDocumentationExtractGenerateCache "$handler" "$definitionFile" "$fn" "$source" "$lineNumber" "${derivations[@]+"${derivations[@]}"}" || return $?
    elif [ -x "$definitionFile" ] && [ "$definitionFile" -nt "$source" ]; then
      catchEnvironment "$handler" cat "$definitionFile" || return $?
      return 0
    fi
  else
    __bashDocumentationExtractDirect "$handler" "$fn" "$source" "$lineNumber" "${derivations[@]+"${derivations[@]}"}" || return $?
  fi
}

__bashDocumentationExtractCheckCache() {
  local handler="$1" source="$2" definitionFile="$3"
  local sourceHash && sourceHash=$(catchReturn "$handler" textSHA <"$source") || return $?
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
    if [ "$savedSourceHash" = "$sourceHash" ]; then
      catchEnvironment "$handler" touch "$definitionFile" || return $?
      catchEnvironment "$handler" cat "$definitionFile" || return $?
      return 0
    fi
  fi
  return 1
}

# Argument: handler - Function. Required.
# Argument: sourceFile - File. Required.
# Argument: definitionFile - FileDirectory. Required. Target file to generate
# Argument: fn - String. Required. Item name
# Argument: lineNumber - EmptyString. Required. Output this prefix to the resulting file
# Argument: derivations ... - String. Optional. Allow derived variables with these names.
__bashDocumentationExtractGenerateCache() {
  local handler="$1" && shift
  local definitionFile="$1" && shift
  local fn="$1" && shift
  local source="$1" && shift
  local lineNumber="$1" && shift

  local variableList="sourceFile,argument,description,summary,file,base,sourceHash,foundNames,summaryComputed"
  variableList="$variableList,derivations,descriptionLineCount"

  catchEnvironment "$handler" muzzle fileDirectoryRequire "$definitionFile" || return $?
  catchEnvironment "$handler" touch "$definitionFile" || return $?
  catchEnvironment "$handler" chmod +x "$definitionFile" || return $?
  (
    local extras=()
    extras+=("#!/usr/bin/env bash" "# Copyright &copy; $(date +%Y) $(catchReturn "$handler" buildEnvironmentGet BUILD_COMPANY)") || return $?
    extras+=("# Generated on $(dateToday)")
    catchReturn "$handler" environmentClean || return $?
    local uncompiled && uncompiled=$(fileTemporaryName "$handler") || return $?
    local clean=("$uncompiled" "$uncompiled.finished")
    bashRecursionDebug || return $?
    __bashDocumentationExtractDirect "$handler" "$fn" "$source" "$lineNumber" "$@" | printfOutputPrefix "%s\n" "${extras[@]}" >"$uncompiled" || returnClean $? "${clean[@]}" || $?
    bashRecursionDebug --end || return $?
    catchEnvironment "$handler" environmentCompile --keep-comments --parse --variables "$variableList" <"$uncompiled" | catchEnvironment "$handler" tee "$uncompiled.finished" || returnClean $? "${clean[@]}" || $?
    if ! grep -q '^sourceFile=' "$uncompiled.finished"; then
      decorateThemelessMode --end || : 2>/dev/null
      consoleLineFill 1>&2
      dumpPipe uncompiled < <(grep source <"$uncompiled") 1>&2 || return $?
      dumpPipe compiled <"$uncompiled.finished" 1>&2 || return $?
      decorate warning "RUN with --debug"
      environmentCompile --keep-comments --parse --variables "$variableList" <"$uncompiled" 1>&2
      throwEnvironment "$handler" "Final $definitionFile does not contain sourceFile=?" || returnClean $? "${clean[@]}" || return $?
    fi
    catchEnvironment "$handler" cp "$uncompiled.finished" "$definitionFile" || returnClean $? "${clean[@]}" "$definitionFile" || $?
    catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
  ) || return $?
}

# Argument: handler - Function. Required.
# Argument: function - String. Required.
# Argument: sourceFile - File. Required.
# Argument: lineNumber - EmptyString. Required. Output this prefix to the resulting file
# Argument: derivations ... - String. Optional. Allow derived variables with these names.
__bashDocumentationExtractDirect() {
  local __saved=("$@") __count=$#
  local handler="$1" && shift
  local fn="$1" && shift
  local source="$1" && shift
  local lineNumber="$1" && shift

  local derivations=("$@")

  local mapNames=("fn") simpleNames=("name" "fn" "env" "summary" "category" "type")

  # ********************************************************************************************************************
  # Configure your profiling flags as desired using whatever global needed
  export BUILD_DEBUG
  local flag=",usage-profile," flags=",${BUILD_DEBUG-},"

  # IDENTICAL profileFunctionHead 4
  # ********************************************************************************************************************
  local __profile="false" __profile0="" __profileNext __profileUsed=0 __profileLabel="arguments (#$__count)" __profilePrefix="Profile-${FUNCNAME[0]}: "
  if [ -n "$flags" ] && [ "${flags#*"$flag"}" != "$flags" ]; then __profile=$(timingStart) && __profile0=$__profile; fi
  # ********************************************************************************************************************

  # subshell to hide exports?
  local dumper=""
  export fn base

  local desc=() lastName="" foundNames=() lastName="" values=() rawComment="" finished=false
  __bashDocumentationSettingsHeader "$handler" "$fn" || return $?
  # Read comment (stripped of #) from stdin
  while ! $finished; do
    local line && IFS="" read -r line || finished=true
    if [ -z "$line" ]; then
      [ "${#desc[@]}" -gt 0 ] || continue
      [ -n "${desc[$((${#desc[@]} - 1))]}" ] || continue
      desc+=("")
      continue
    fi
    rawComment="$rawComment$line"$'\n'
    local name="${line%%:*}"
    local cleanName && cleanName="$(catchReturn "$handler" tr '[:upper:]' '[:lower:]' <<<"${name//[- ]/_}")" || return $?
    __profileLabel="$cleanName"
    # IDENTICAL profileFunctionMarker 3
    # ********************************************************************************************************************
    if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
    # ********************************************************************************************************************

    local value=""
    if ! environmentVariableNameValid "$cleanName" || [ "$name" = "$line" ] || [ "${line%%:}" != "$line" ] || [ "${line##:}" != "$line" ]; then
      # no colon or ends with colon *or* starts with :
      # strip starting colon (end colon STAYS)
      value="${line##:}"
      if [ "${#desc[@]}" -gt 0 ] || [ "$(textTrim "$value")" != "" ]; then
        desc+=("$value")
      fi
      continue
    fi
    value="${line#*:}"
    value="${value# }"
    name="$cleanName"
    case "$name" in
    ":sourceFile") name="${name:1}" && source="$value" ;;
    ":sourceLine") name="${name:1}" && lineNumber="$name" ;;
    esac
    case "$name" in
    "shellcheck") continue ;;
    "description")
      value="$(catchReturn "$handler" textTrim "$value")" || return $?
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
  done
  if [ -f "$source" ]; then
    __bashDocumentationSettingsFileDetails "$handler" "$source" "$lineNumber" || return $?
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
    catchReturn "$handler" __dumpSimpleValue "descriptionLineCount" "${#desc[@]}" || return $?
    if ! inArray "summary" "${foundNames[@]+"${foundNames[@]}"}"; then
      local summary
      summary="$(stringTrimWords 10 "${desc[0]}")"
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
  local code="return_code"
  if inArray "$code" "${derivations[@]}" && ! inArray "$code" "${foundNames[@]+"${foundNames[@]}"}"; then
    catchReturn "$handler" __dumpNameValue "$code" '0 - Success' '1 - Environment error' '2 - Argument error' || return $?
  fi
  for code in fn env; do
    if inArray "$code" "${derivations[@]}" && ! inArray "$code" "${foundNames[@]+"${foundNames[@]}"}"; then
      catchReturn "$handler" __dumpSimpleValue "$code" "$fn" || return $?
    fi
  done
  for code in fnMarker envMarker; do
    if inArray "$code" "${derivations[@]}" && ! inArray "$code" "${foundNames[@]+"${foundNames[@]}"}"; then
      catchReturn "$handler" __dumpSimpleValue "$code" "$(stringLowercase "${fn//[^[:alnum:]]/_}")" || return $?
    fi
  done
  code="argument"
  if inArray "$code" "${derivations[@]}" && ! inArray "$code" "${foundNames[@]+${foundNames[@]}}"; then
    catchReturn "$handler" __dumpSimpleValue "$code" "none" || return $?
    code="usage"
    if inArray "$code" "${derivations[@]}" && ! inArray "$code" "${foundNames[@]+${foundNames[@]}}"; then
      catchReturn "$handler" __dumpSimpleValue "$code" "$fn" || return $?
    fi
  else
    code="usage"
    if inArray "$code" "${derivations[@]}" && ! inArray "$code" "${foundNames[@]+"${foundNames[@]}"}"; then
      # lazy
      catchReturn "$handler" printf "%s\n" "export $code; $code=\"\$fn\$(__bashDocumentationDefaultArguments \"\$argument\")\"" || return $?
    fi
  fi
  catchReturn "$handler" __dumpNameValue "rawComment" "$rawComment" || return $?
  catchReturn "$handler" __dumpArrayValue "foundNames" "${foundNames[@]+"${foundNames[@]}"}" || return $?
  catchReturn "$handler" __dumpArrayValue "derivations" "${derivations[@]+"${derivations[@]}"}" || return $?

  unset rawComment
  # IDENTICAL profileFunctionTail 6
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then
    __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2
    printf -- "Line %d: %s%d %s (%d + %d) %s + %s %d%%\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile0))" '*TOTAL*' "$((__profileNext - __profile0 - __profileUsed))" "$__profileUsed" 'us' 'them' "$(((100 * __profileUsed) / (__profileNext - __profile0)))" 1>&2
  fi
  # ********************************************************************************************************************
  return 0
}

# Argument: handler - Required. Function.
# Argument: definitionFile - Required. File.
__bashDocumentationSettingsFileDetails() {
  local handler="$1" && shift

  local definitionFile && definitionFile=$(validate "$handler" RealFile "definitionFile" "${1-}") && shift || return $?
  local lineNumber="${1-}"

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local file="${definitionFile#"${home%/}"/}"
  catchReturn "$handler" __dumpSimpleValue "file" "$file" || return $?
  if [ -z "$lineNumber" ]; then
    lineNumber="$(grep -n -e "^$fn()" "$definitionFile" | cut -f 1 -d :)" || lineNumber=""
  fi
  [ -z "$lineNumber" ] || catchReturn "$handler" __dumpSimpleValue "line" "$lineNumber" || return $?
  catchReturn "$handler" __dumpSimpleValue "sourceFile" "$file" || return $?
  catchReturn "$handler" __dumpSimpleValue "sourceLine" "$lineNumber" || return $?
  catchReturn "$handler" __dumpSimpleValue "sourceHash" "$(textSHA <"$definitionFile")" || return $?
  catchReturn "$handler" __dumpSimpleValue "base" "$(basename "$definitionFile")" || return $?
}
