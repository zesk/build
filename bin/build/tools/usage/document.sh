#!/usr/bin/env bash
#
# document.sh
#
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.

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

__usageDocument() {
  local handler="$1" __handler="$1" && shift

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  [ $# -ge 2 ] || throwArgument "$handler" "Expected 2 arguments, got $#:$(printf -- " \"%s\"" "$@")" || return $?

  local functionDefinitionFile="${1-}" functionName="${2-}"
  shift 2 || throwArgument "$handler" "Missing arguments" || return $?

  local home returnCode="${1-NONE}"

  home=$(returnCatch "$handler" buildHome) || return $?

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

  local variablesFile
  variablesFile=$(fileTemporaryName "$handler") || return $?
  local commentFile="$variablesFile.comment"
  local clean=("$variablesFile" "$commentFile")
  returnCatch "$handler" bashFunctionComment "$functionDefinitionFile" "$functionName" >"$commentFile" || returnClean $? "${clean[@]}" || return $?
  if ! returnCatch "$handler" bashDocumentationExtract "$functionName" >"$variablesFile" <"$commentFile"; then
    dumpPipe "commentFile" <"$commentFile"
    dumpPipe "variablesFile" <"$variablesFile"
    dumpPipe "functionDefinitionFile" <"$functionDefinitionFile"
    throwArgument "$handler" "Unable to extract \"$functionName\" from \"$functionDefinitionFile\"" || returnClean $? "${clean[@]}" || return $?
  fi
  (
    local fn="$functionName" description="" argument="" base return_code="" environment="" stdin="" stdout="" example="" build_debug=""

    declare -r __handler variablesFile
    set -a
    base="$(basename "$functionDefinitionFile")"
    # shellcheck source=/dev/null
    catchEnvironment "$__handler" source "$variablesFile" || returnClean $? "${clean[@]}" || return $?
    # Some variables MAY BE OVERWRITTEN ABOVE .e.g. `__handler`
    catchEnvironment "$__handler" rm -f "$variablesFile" "$commentFile" || return $?
    set +a

    : "$base $return_code $environment $stdin $stdout $example are referenced here and with \${!variable} below"
    : "$build_debug"

    [ "$returnCode" -eq 0 ] || exec 1>&2 && color="error"
    local bashDebug=false
    if isBashDebug; then
      bashDebug=true
      # Hides a lot of unnecessary tracing
      __buildDebugDisable
    fi
    returnCatch "$__handler" bashRecursionDebug || return $?
    local variable prefix label done=false suffix=""
    while ! $done; do
      IFS="|" read -r variable prefix label || done=true
      [ -n "$variable" ] || continue
      local value="${!variable}"
      if [ -n "$value" ]; then
        local formatted
        formatted="$(printf "\n\n%s\n%s\n" "$label:" "$(decorate wrap "$prefix" "" <<<"$(trimSpace "$value")")")"
        suffix="$suffix$formatted"
      fi
    done < <(__usageDocumentSections)
    description=$(trimTail <<<"$description")
    __usageTemplate "$fn" "$(printf "%s\n" "$argument" | sed 's/ - /^/1')" "^" "$description$suffix" "$returnCode" "$@" | identical=IDENTICAL functionName="$functionName" fn="$fn" mapEnvironment
    if $bashDebug; then
      __buildDebugEnable
    fi
    returnCatch "$__handler" bashRecursionDebug --end || return $?
  ) || returnClean $? "${clean[@]}" || return $?
  return "$returnCode"
}
