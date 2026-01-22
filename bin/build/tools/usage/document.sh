#!/usr/bin/env bash
#
# document.sh
#
#
# Copyright: Copyright &copy; 2026 Market Acumen, Inc.

__usageDocumentSections() {
  cat <<'EOF'
return_code|- |Return codes
environment|- |Environment variables
stdin||Reads from `stdin`
stdout||Writes to `stdout`
example||Example
build_debug|- |`BUILD_DEBUG` settings
EOF
}

# BUILD_DEBUG: usage-cache-skip
# BUILD_DEBUG: usage-cache-dump
__usageDocument() {
  local __count=$# __saved=("$@")
  local handler="$1" __handler="$1" && shift

  # ********************************************************************************************************************
  # profiling variables
  export BUILD_DEBUG
  local flag=",usage-profile," flags=",${BUILD_DEBUG-},"
  # Hides a lot of unnecessary tracing
  local bashDebug=false && if isBashDebug; then bashDebug=true && __buildDebugDisable; fi

  # IDENTICAL profileFunctionHead 6
  # ********************************************************************************************************************
  local __profile="false" __profile0="" __profileNext __profileUsed=0 __profileLabel="arguments (#$__count)" __profilePrefix="Profile-${FUNCNAME[0]}: "

  if [ -n "$flags" ] && [ "${flags#*"$flag"}" != "$flags" ]; then __profile=$(timingStart) && __profile0=$__profile; fi
  # ********************************************************************************************************************

  local start="$__profile" && [ "$start" != false ] || start="$(timingStart)"

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  [ $# -ge 2 ] || throwArgument "$handler" "Expected 2 arguments, got $#:$(printf -- " \"%s\"" "$@")" || return $?

  local functionDefinitionFile="${1-}" functionName="${2-}"
  local displayName="${fn-"$functionName"}"
  shift 2 || throwArgument "$handler" "Missing arguments" || return $?

  local home returnCode="${1-NONE}"

  home=$(catchReturn "$handler" buildHome) || return $?

  shift 2>/dev/null || :

  if [ ! -f "$functionDefinitionFile" ]; then
    local tryFile="$home/$functionDefinitionFile"
    if [ ! -f "$tryFile" ]; then
      export PWD
      catchArgument "$handler" "functionDefinitionFile $functionDefinitionFile (PWD: ${PWD-}) (Build home: \"$home\") not found" || return $?
    fi
    functionDefinitionFile="$tryFile"
  fi
  [ -n "$functionName" ] || throwArgument "$handler" "functionName is blank" || return $?

  if [ "$returnCode" = "NONE" ]; then
    decorate error "NO EXIT CODE" 1>&2
    debuggingStack
    returnCode=1
  fi

  catchArgument "$handler" isInteger "$returnCode" || catchArgument "$handler" "$(debuggingStack)" || return $?

  local color="success"
  case "$returnCode" in
  0 | 2)
    if buildDebugEnabled "fast-usage"; then
      if [ "$returnCode" -ne 0 ]; then
        exec 1>&2
        color="warning"
      fi
      printf -- "%s%s %s\n" "$(decorate value "[$returnCode]")" "$(decorate code " $functionName ")" "$(decorate "$color" -- "$@")"
      return "$returnCode"
    fi
    ;;
  *)
    if [ "$returnCode" -ne 0 ]; then
      exec 1>&2 && color="error"
    fi
    printf -- "%s%s %s\n" "$(decorate value "[$returnCode]")" "$(decorate code " $functionName ")" "$(decorate "$color" -- "$@")"
    return "$returnCode"
    ;;
  esac

  if ! buildDebugEnabled usage-cache-skip || ! __usageDocumentCached "$handler" "$home" "$functionName" "$start"; then

    # IDENTICAL profileFunctionMarker 3
    # ********************************************************************************************************************
    if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" && __profile=$__profileNext; fi

    local variablesFile && variablesFile=$(fileTemporaryName "$handler") || return $?
    local commentFile="$variablesFile.comment"
    local clean=("$variablesFile" "$commentFile")

    catchReturn "$handler" bashFunctionComment "$functionDefinitionFile" "$functionName" >"$commentFile" || returnClean $? "${clean[@]}" || return $?

    __profileLabel=bashFunctionComment
    # IDENTICAL profileFunctionMarker 3
    # ********************************************************************************************************************
    if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" && __profile=$__profileNext; fi

    if ! catchReturn "$handler" bashDocumentationExtract "$displayName" "$functionDefinitionFile" >"$variablesFile" <"$commentFile"; then
      dumpPipe "commentFile" <"$commentFile"
      dumpPipe "variablesFile" <"$variablesFile"
      dumpPipe "functionDefinitionFile" <"$functionDefinitionFile"
      throwArgument "$handler" "Unable to extract \"$functionName\" from \"$functionDefinitionFile\"" || returnClean $? "${clean[@]}" || return $?
    fi

    __profileLabel=bashDocumentationExtract
    # IDENTICAL profileFunctionMarker 3
    # ********************************************************************************************************************
    if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" && __profile=$__profileNext; fi

    local fn="$displayName" description="" argument="" base return_code="" environment="" stdin="" stdout="" example="" build_debug="" name="${name-}"

    declare -r __handler variablesFile
    set -a # UNDO ok
    base="$(catchEnvironment "$handler" basename "$functionDefinitionFile")" || returnUndo $? set +a || return $?
    # shellcheck source=/dev/null
    catchEnvironment "$__handler" source "$variablesFile" || returnUndo $? set +a || returnClean $? "${clean[@]}" || return $?
    set +a
    #    dumpPipe "commentFile" <"$commentFile"
    #    dumpPipe "sourceVariables" <"$variablesFile"
    # Some variables MAY BE OVERWRITTEN ABOVE .e.g. `__handler`
    catchEnvironment "$__handler" rm -f "$variablesFile" "$commentFile" || return $?

    __profileLabel="source $variablesFile"
    # IDENTICAL profileFunctionMarker 3
    # ********************************************************************************************************************
    if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" && __profile=$__profileNext; fi

    : "$base $return_code $environment $stdin $stdout $example are referenced here and with \${!variable} below"
    : "$build_debug"

    [ "$returnCode" -eq 0 ] || exec 1>&2 && color="error"

    catchReturn "$__handler" bashRecursionDebug || return $?
    local variable prefix label done=false suffix=""
    while ! $done; do
      IFS="|" read -r variable prefix label || done=true
      [ -n "$variable" ] || continue
      local value="${!variable}"
      if [ -n "$value" ]; then
        local formatted
        formatted="$(printf "\n\n%s\n%s\n" "$label:" "$(decorate wrap "$prefix" "" <<<"$value")")"
        suffix="$suffix$formatted"
      fi
    done < <(__usageDocumentSections)

    __profileLabel="__usageDocumentSections formatting"
    # IDENTICAL profileFunctionMarker 3
    # ********************************************************************************************************************
    if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" && __profile=$__profileNext; fi

    description=$(trimTail <<<"$description")
    __usageTemplate "$fn" "$(printf "%s\n" "$argument" | sed 's/ - /^/1')" "^" "$description$suffix" "$returnCode" "$@" | identical=IDENTICAL functionName="$functionName" fn="$fn" name="$name" mapEnvironment

    __profileLabel="__usageTemplate $fn"
    # IDENTICAL profileFunctionMarker 3
    # ********************************************************************************************************************
    if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" && __profile=$__profileNext; fi

    catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
    catchReturn "$__handler" bashRecursionDebug --end || return $?
  fi

  __profileLabel="cleanup"
  # IDENTICAL profileFunctionTail 7
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then
    __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel"
    printf -- "Line %d: %s%d %s (%d + %d) %s + %s %d%%\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile0))" '*TOTAL*' "$((__profileNext - __profile0 - __profileUsed))" "$__profileUsed" 'us' 'them' "$(((100 * __profileUsed) / (__profileNext - __profile0)))"
  fi
  # ********************************************************************************************************************

  ! $bashDebug || __buildDebugEnable
  return "$returnCode"
}
