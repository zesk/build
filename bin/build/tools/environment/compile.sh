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

  local __files=() __v=() __a=() __skipVariables=() __debugFlag=false __keepComments=false __parseFlag=false __inplaceFlag=false
  local __removeBlankFlag=false __item

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
    --remove-blank) __removeBlankFlag=true ;;
    --variables)
      shift && local __listText && __listText="$(validate "$handler" "CommaDelimitedList" "$__argument" "${1-}")" || return $?
      local __variableList=() && IFS="," read -d $'\n' -r -a __variableList <<<"$__listText"
      __v+=("${__variableList[@]+"${__variableList[@]}"}")
      ;;
    --keep-comments) __keepComments=true ;;
    --underscore | --secure) __a+=("$__argument") ;;
    *) __files+=("$(validate "$handler" File "environmentFile" "$__argument")") || return $? ;;
    esac
    shift
  done

  [ ${#__files[@]} -gt 0 ] || ! $__inplaceFlag || throwArgument "$handler" "--in-place requires a file" || return $?

  local tempEnv && tempEnv=$(fileTemporaryName "$handler") || return $?
  local clean=("$tempEnv" "$tempEnv.after" "$tempEnv.source" "$tempEnv.save")
  if [ ${#__files[@]} -eq 0 ]; then
    catchEnvironment "$handler" cat >"$tempEnv.source" || returnClean $? "${clean[@]}" || return $?
    __files+=("$tempEnv.source")
  fi
  if $__parseFlag; then
    while read -r variable; do __v+=("$variable"); done < <(cat "${__files[@]}" | environmentParseVariables)
    if $__debugFlag; then printf "%s\n" "${__v[@]}" | dumpPipe "PARSED variables" 1>&2; fi
  fi
  if $__debugFlag; then cat "${__files[@]}" | dumpPipe SOURCES 1>&2; fi
  (
    local __handler="$handler"
    catchReturn "$__handler" environmentClean || returnClean $? "${clean[@]}" || return $?
    if $__debugFlag; then printf "# variables: %s\n" "${__v[*]}" | tee "$tempEnv" >"$tempEnv.after"; fi
    if [ "${#__v[@]}" -gt 0 ]; then
      export "${__v[@]+"${__v[@]}"}"
      for __item in "${__v[@]}"; do __skipVariables+=("--skip" "$__item"); done
    fi
    ! $__debugFlag || statusMessage --last decorate info "environmentOutput(BEFORE)" "${__v[@]+"${__v[@]}"}" || :
    catchReturn "$__handler" environmentOutput "${__a[@]+"${__a[@]}"}" "${__skipVariables[@]+"${__skipVariables[@]}"}" >>"$tempEnv" || returnClean $? "${clean[@]}" || return $?
    # LOAD (source) MUST be here to ensure arrays are preserved - they are not passed back from an exported function
    local environmentFile && for environmentFile in "${__files[@]}"; do
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
      ! $__keepComments || catchReturn "$handler" bashCommentFilter --only <"$environmentFile" | grepSafe -e '^#' >>"$tempEnv.save" || returnClean $? "${clean[@]}" || returnUndo $? set +a || return $?
    done
    if $__debugFlag; then
      declare -ax | dumpPipe "declare -ax OUTSIDE" 1>&2
      declare -x | dumpPipe "declare -x OUTSIDE" 1>&2
    fi
    ! $__debugFlag || statusMessage --last decorate info "environmentOutput(AFTER)" "${__v[@]+"${__v[@]}"}" || :
    catchReturn "$handler" environmentOutput "${__a[@]+"${__a[@]}"}" "${__v[@]+"${__v[@]}"}" >>"$tempEnv.after" || returnClean $? "${clean[@]}" || return $?
  ) || returnClean $? "${clean[@]}" || return $?
  if $__debugFlag; then
    dumpPipe BEFORE <"$tempEnv" 1>&2
    dumpPipe AFTER <"$tempEnv.after" 1>&2
    decorate info DIFF 1>&2
    muzzleReturn diff -U0 "$tempEnv" "$tempEnv.after" 1>&2
    decorate success RESULT 1>&2
  fi
  [ ! -f "$tempEnv.save" ] || catchEnvironment "$handler" cat "$tempEnv.save" || return $?
  local postPostProcess=(cat)
  ! $__removeBlankFlag || postPostProcess=(catchReturn "$handler" grepSafe -v -e '=""$')
  # 3 is a copy of 1 (stdout)
  exec 3>&1
  if $__inplaceFlag; then
    local outputFile="${__files[0]}"
    # 3 is opened to write to `$outputFile`
    exec 3>"$outputFile"
  fi
  # redirect postprocess output to 3
  local returnCode=0 && __environmentCompilePostProcess "$handler" "$tempEnv" "$tempEnv.after" | "${postPostProcess[@]}" 1>&3 || returnCode=$?
  # close 3
  exec 3>&-
  catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
  return "$returnCode"
}
__environmentCompilePostProcess() {
  local handler="$1" && shift
  # diff returns 1 when files differ so hide it
  muzzleReturn diff -U0 "$@" | catchEnvironment "$handler" grepSafe '^+' | catchEnvironment "$handler" cut -c 2- | catchEnvironment "$handler" grepSafe -v '^+' | catchEnvironment "$handler" sort -u || return $?
}
_environmentCompile() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
