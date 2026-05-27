#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Extract and build the documentation settings cache and generate derived files
# Argument: --clean - Flag. Optional. Clean everything and then exit.
# Argument: --git - Flag. Optional. Do some handy `git` changes. (Adding/removing files)
# Argument: --all - Flag. Optional. Do everything regardless of cache state.
# Argument: --fingerprint - Flag. Optional. Use fingerprint to ensure results are up to date.
# Argument: functionName ... - String. Optional. Specific functions to compile.
buildFunctionsCompile() {
  local handler="_${FUNCNAME[0]}" aa=() allFlag=false

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
    --all) allFlag=true ;;
    *) aa+=("$1") ;;
    esac
    shift
  done

  if $allFlag; then
    catchReturn "$handler" documentationFunctionCompile --key "buildFunctions" "$@" < <(catchReturn "$handler" buildFunctions) || return $?
  else
    local home && home=$(catchReturn "$handler" buildHome) || return $?
    local funFile && funFile=$(fileTemporaryName "$handler") || return $?
    local clean=("$funFile")
    local paths=() && IFS=":" read -r -a paths <<<"$(catchReturn "$handler" buildEnvironmentGet BUILD_DOCUMENTATION_PATH)"
    local mostRecentTimestamp _modifiedFile && read -r mostRecentTimestamp _modifiedFile < <(catchReturn "$handler" fileModifiedRecently "$home/bin/build/tools") || returnClean $? "${clean[@]}" || return $?
    local path && for path in "${paths[@]}"; do
      pathIsAbsolute "$path" || path="$home/$path"
      local timestamp fileName && while read -r timestamp fileName; do
        if isInteger "$timestamp"; then
          if [ "$timestamp" -lt "$mostRecentTimestamp" ]; then
            fileName="$(basename "$fileName")" && fileName="${fileName%.sh}"
            if isFunction "$fileName"; then
              printf "%s\n" "$fileName"
            fi
          else
            break
          fi
        fi
      done < <(fileModificationTimes "$path" -maxdepth 1 -mindepth 1 -name '*.sh' | sort -n) >"$funFile"
    done
    catchReturn "$handler" documentationFunctionCompile --key "buildFunctions" "$@" <"$funFile" || returnClean $? "${clean[@]}" || return $?
    catchReturn "$handler" rm -f "${clean[@]}" || return $?
  fi
}
_buildFunctionsCompile() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

buildFunctionsRemoveDeprecated() {
  local handler="_${FUNCNAME[0]}"

  catchReturn "$handler" documentationFunctionRemove < <(catchReturn "$handler" buildDeprecatedFunctions) || return $?
}
_buildFunctionsRemoveDeprecated() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
