#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Load an environment file and evaluate it using bash and output the changed environment variables after running
# Do not perform this operation on files which are untrusted.
# Argument: --underscore - Flag. Optional. Include environment variables which begin with underscore `_`.
# Argument: --secure - Flag. Optional. Include environment variables which are in `environmentSecureVariables`
# Argument: --keep-comments - Flag. Keep all comments in the source
# Argument: --variables - CommaDelimitedList. Optional. Always output the value of these variables.
# Argument: --parse - Flag. Optional. Parse the file for things which look like variables to output (basically `^foo=`)
# Argument: environmentFile - File. Required. Environment file to load, evaluate, and output in raw form (Bash-compatible).
# Security: source
environmentCompile() {
  local handler="_${FUNCNAME[0]}"

  local environmentFiles=() aa=() __debugFlag=false keepComments=false __parseFlag=false __inplaceFlag=false variables=()

  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local __argument="$1" __index=$((__count - $# + 1))
    [ -n "$__argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$__argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --debug) __debugFlag=true ;;
    --parse) __parseFlag=true ;;
    --in-place) __inplaceFlag=true ;;
    --variables)
      shift && local listText && listText="$(validate "$handler" "CommaDelimitedList" "$__argument" "${1-}")" || return $?
      local variableList=() && IFS="," read -r -a variableList <<<"$listText" || :
      variables+=("${variableList[@]+"${variableList[@]}"}")
      aa+=("${variableList[@]+"${variableList[@]}"}")
      ;;
    --keep-comments) keepComments=true ;;
    --underscore | --secure) aa+=("$__argument") ;;
    *) environmentFiles+=("$(validate "$handler" File "environmentFile" "$__argument")") || return $? ;;
    esac
    shift
  done

  [ ${#environmentFiles[@]} -gt 0 ] || ! $__inplaceFlag || throwArgument "$handler" "--in-place requires a file" || return $?

  local tempEnv && tempEnv=$(fileTemporaryName "$handler") || return $?
  local clean=("$tempEnv" "$tempEnv.after" "$tempEnv.source" "$tempEnv.save")
  if [ ${#environmentFiles[@]} -eq 0 ]; then
    catchEnvironment "$handler" cat >"$tempEnv.source" || returnClean $? "${clean[@]}" || return $?
    environmentFiles+=("$tempEnv.source")
  fi
  if $__parseFlag; then
    while read -r variable; do variables+=("$variable"); done < <(cat "${environmentFiles[@]}" | environmentParseVariables)
    if $__debugFlag; then printf "%s\n" "${variables[@]}" | dumpPipe "PARSED variables" 1>&2; fi
  fi
  if $__debugFlag; then cat "${environmentFiles[@]}" | dumpPipe SOURCES 1>&2; fi
  (
    local __handler="$handler"
    catchReturn "$__handler" environmentClean || returnClean $? "${clean[@]}" || return $?
    if $__debugFlag; then printf "# variables: %s\n" "${variables[*]}" | tee "$tempEnv" >"$tempEnv.after"; fi
    [ "${#variables[@]}" -eq 0 ] || export "${variables[@]+"${variables[@]}"}"
    ! $__debugFlag || statusMessage --last decorate info "environmentOutput(BEFORE)" "${aa[@]+"${aa[@]}"}" || :
    catchReturn "$__handler" environmentOutput "${aa[@]+"${aa[@]}"}" >>"$tempEnv" || returnClean $? "${clean[@]}" || return $?
    # LOAD (source) MUST be here to ensure arrays are preserved - they are not passed back from an exported function
    local environmentFile && for environmentFile in "${environmentFiles[@]}"; do
      ! $__debugFlag || statusMessage --last decorate source "$environmentFile" || :
      local __returnCode=0
      set -a # Undo ok
      # shellcheck source=/dev/null
      source "$environmentFile" >(outputTrigger source "$environmentFile") 2>&1 || __returnCode=$?
      set +a # Undo
      if $__debugFlag; then
        declare -ax | dumpPipe "declare -ax INSIDE" 1>&2
        declare -x | dumpPipe "declare -x INSIDE" 1>&2
      fi
      [ "$__returnCode" -eq 0 ] || throwEnvironment "$__handler" "source $1 failed with $__returnCode" || returnClean "$__returnCode" "${clean[@]}" || returnUndo $? set +a || return $?
      ! $keepComments || catchReturn "$handler" bashCommentFilter --only <"$environmentFile" | grepSafe -e '^#' >>"$tempEnv.save" || returnClean $? "${clean[@]}" || returnUndo $? set +a || return $?
    done
    if $__debugFlag; then
      declare -ax | dumpPipe "declare -ax OUTSIDE" 1>&2
      declare -x | dumpPipe "declare -x OUTSIDE" 1>&2
    fi
    ! $__debugFlag || statusMessage --last decorate info "environmentOutput(AFTER)" "${aa[@]+"${aa[@]}"}" "${variables[@]+"${variables[@]}"}" || :
    catchReturn "$handler" environmentOutput "${aa[@]+"${aa[@]}"}" "${variables[@]+"${variables[@]}"}" >>"$tempEnv.after" || returnClean $? "${clean[@]}" || return $?
  ) || returnClean $? "${clean[@]}" || return $?
  if $__debugFlag; then
    dumpPipe BEFORE <"$tempEnv" 1>&2
    dumpPipe AFTER <"$tempEnv.after" 1>&2
    decorate info DIFF 1>&2
    diff -U0 "$tempEnv" "$tempEnv.after" 1>&2
    decorate success RESULT 1>&2
  fi
  [ ! -f "$tempEnv.save" ] || catchEnvironment "$handler" cat "$tempEnv.save" || return $?
  if $__inplaceFlag; then
    local outputFile="${environmentFiles[0]}"
    __environmentCompilePostProcess "$tempEnv" >"$outputFile" || returnClean $? "${clean[@]}" || return 0
  else
    __environmentCompilePostProcess "$tempEnv" || returnClean $? "${clean[@]}" || return 0
  fi
  catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
}
__environmentCompilePostProcess() {
  local tempEnv="$1" && diff -U0 "$tempEnv" "$tempEnv.after" | grepSafe '^+' | cut -c 2- | grepSafe -v '^+' | sort -u
}
_environmentCompile() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
