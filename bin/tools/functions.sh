#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Extract and build the documentation settings cache and generate derived files
# Argument: --clean - Flag. Optional. Clean everything and then exit.
# Argument: --fingerprint - Flag. Optional. Use fingerprint to ensure results are up to date.
# Argument: --all - Flag. Optional. Do everything regardless of cache state.
# Argument: functionName ... - String. Optional. Specific functions to compile.
buildFunctionsCompile() {
  local handler="_${FUNCNAME[0]}"

  local home && home=$(catchReturn "$handler" buildHome) || return $?
  set -- \
    --handler "$handler" \
    --source "$home/bin/build/tools" \
    --documentation "$home/documentation/source" \
    --target "$home/bin/build/documentation" \
    --key "buildFunctions" "$@"
  documentationFunctionsCompile "$@" < <(buildFunctions)
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
