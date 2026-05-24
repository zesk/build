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
  local handler="_${FUNCNAME[0]}"
  catchReturn "$handler" documentationFunctionCompile --key "buildFunctions" "$@" < <(catchReturn "$handler" buildFunctions) || return $?
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

# Is everything up to date?
# Argument: handler - Function. Required.
# Argument: docPath - Directory. Required.
# Argument: tempFunctions - File. Required. File containing list of function names
__buildFunctionsIsComplete() {
  local handler="$handler" && shift
  local docPath="$1" && shift
  local tempFunctions="$1" && shift

  local missing=() finished=false && while ! $finished; do
    local fun && read -r fun || finished=true
    [ -n "$fun" ] || continue
    if [ ! -f "$docPath/$fun.sh" ]; then
      missing+=("$fun")
    fi
  done <"$tempFunctions"
  finished=false && while ! $finished; do
    local file fun && read -r file || finished=true
    [ -n "$file" ] || continue
    fun="${file##*/}" && fun="${fun%.sh}"
    if ! isFunction "$fun" && ! muzzle buildEnvironmentGet "$fun" 2>/dev/null; then
      catchReturn "$handler" statusMessage --last decorate error "File $(decorate file "$file") has no matching function $(decorate code "$fun") anymore" || return $?
    fi
  done < <(find "$docPath" -type f -name '*.sh')
  local index=0 fun
  [ "${#missing[@]}" -eq 0 ] || for fun in "${missing[@]}"; do
    index=$((index + 1))
    catchReturn "$handler" statusMessage decorate warning "Loading missing: $fun" || return $?
    (
      __documentationFileCompileFunction "$handler" "$docPath" "$fun" "" "Missing #$index/${#missing[@]}" "$@" || return $?
    ) || return $?
  done
  catchReturn "$handler" statusMessage decorate info "No functions missing" || return $?
}
