#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Summary: Compile an environment file to evaluated names and values
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

  local __tempEnvFile && __tempEnvFile=$(fileTemporaryName "$handler") || return $?
  local __clean=("$__tempEnvFile" "$__tempEnvFile.after" "$__tempEnvFile.source" "$__tempEnvFile.save")
  if [ ${#__files[@]} -eq 0 ]; then
    catchEnvironment "$handler" cat >"$__tempEnvFile.source" || returnClean $? "${__clean[@]}" || return $?
    __files+=("$__tempEnvFile.source")
  fi
  if $__parseFlag; then
    while read -r variable; do __v+=("$variable"); done < <(cat "${__files[@]}" | environmentParseVariables)
    if $__debugFlag; then printf "%s\n" "${__v[@]}" | dumpPipe "PARSED variables" 1>&2; fi
  fi
  if $__debugFlag; then cat "${__files[@]}" | dumpPipe SOURCES 1>&2; fi
  (
    local __handler="$handler"

    set -eou pipefail
    # What is needed before this () exits?
    catchReturn "$__handler" environmentClean __handler __debugFlag __v __a _returnClean__skipVariables __files __tempEnvFile __keepComments || returnClean $? "${__clean[@]}" || return $?
    if $__debugFlag; then printf "# variables: %s\n" "${__v[*]}" | tee "$__tempEnvFile" >"$__tempEnvFile.after"; fi
    if [ "${#__v[@]}" -gt 0 ]; then
      export "${__v[@]+"${__v[@]}"}"
      for __item in "${__v[@]}"; do __skipVariables+=("--skip" "$__item"); done
    fi
    ! $__debugFlag || statusMessage --last decorate info "environmentOutput(BEFORE)" "${__v[@]+"${__v[@]}"}" 1>&2 || return $?
    catchReturn "$__handler" environmentOutput "${__a[@]+"${__a[@]}"}" "${__skipVariables[@]+"${__skipVariables[@]}"}" >>"$__tempEnvFile" || returnClean $? "${__clean[@]}" || return $?
    # LOAD (source) MUST be here to ensure arrays are preserved - they are not passed back from an exported function
    local __environmentFile && for __environmentFile in "${__files[@]}"; do
      ! $__debugFlag || statusMessage --last decorate source "$__environmentFile" 1>&2 || return $?
      local __returnCode=0
      declare -r __environmentFile
      set -a # Undo ok
      # shellcheck source=/dev/null
      source "$__environmentFile" >(outputTrigger source "$__environmentFile") 2>&1 || __returnCode=$?
      set +a # Undo
      if $__debugFlag; then
        declare -ax | dumpPipe "declare -ax INSIDE" 1>&2
        declare -x | dumpPipe "declare -x INSIDE" 1>&2
      fi
      [ "$__returnCode" -eq 0 ] || throwEnvironment "$__handler" "source $1 failed with $__returnCode" || returnClean "$__returnCode" "${__clean[@]}" || returnUndo $? set +a || return $?
      ! $__keepComments || catchReturn "$handler" bashCommentFilter --only <"$__environmentFile" | grepSafe -e '^#' >>"$__tempEnvFile.save" || returnClean $? "${__clean[@]}" || returnUndo $? set +a || return $?
    done
    if $__debugFlag; then
      declare -ax | dumpPipe "declare -ax OUTSIDE" 1>&2
      declare -x | dumpPipe "declare -x OUTSIDE" 1>&2
    fi
    ! $__debugFlag || statusMessage --last decorate info "environmentOutput(AFTER)" "${__v[@]+"${__v[@]}"}" 1>&2 || return $?
    catchReturn "$handler" environmentOutput "${__a[@]+"${__a[@]}"}" "${__v[@]+"${__v[@]}"}" >>"$__tempEnvFile.after" || returnClean $? "${__clean[@]}" || return $?
  ) || returnClean $? "${__clean[@]}" || return $?
  if $__debugFlag; then
    {
      dumpPipe BEFORE <"$__tempEnvFile"
      dumpPipe AFTER <"$__tempEnvFile.after"
      decorate info DIFF
      muzzleReturn diff -U0 "$__tempEnvFile" "$__tempEnvFile.after"
      decorate success "-- END DIFF --"
    } 1>&2
  fi
  [ ! -f "$__tempEnvFile.save" ] || catchEnvironment "$handler" cat "$__tempEnvFile.save" || return $?
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
  local returnCode=0 && __environmentCompilePostProcess "$handler" "$__tempEnvFile" "$__tempEnvFile.after" | "${postPostProcess[@]}" 1>&3 || returnCode=$?
  # close 3
  exec 3>&-
  catchEnvironment "$handler" rm -f "${__clean[@]}" || return $?
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
