#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# List templates with unresolved `SEE:` tokens in Zesk Build.
buildFunctionsListSeeUnfinished() {
  local handler="_${FUNCNAME[0]}"
  local home && home=$(catchReturn "$handler" buildHome) || return $?
  catchReturn "$handler" documentationFunctionsListSeeUnfinished "$home/bin/build/documentation" || return $?
}
_buildFunctionsListSeeUnfinished() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Interactive count of templates with unresolved `SEE:` tokens in Zesk Build.
buildFunctionsSeeLoop() {
  local handler="_${FUNCNAME[0]}"
  local home && home=$(catchReturn "$handler" buildHome) || return $?
  catchReturn "$handler" documentationFunctionsSeeLoop "$home/bin/build/documentation" || return $?
}
_buildFunctionsSeeLoop() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Re-generate templates with unresolved `SEE:` tokens in Zesk Build.
buildFunctionsSeeAgain() {
  local handler="_${FUNCNAME[0]}"

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local docPath="$home/bin/build/documentation"
  catchReturn "$handler" documentationFunctionsSeeDirty "$docPath" || return $?
  __buildFunctionsCompile "$handler" --stdin "$@" < <(documentationFunctionsListSeeUnfinished "$docPath")
}
_buildFunctionsSeeAgain() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__buildInternalFunctions() {
  cat <<'EOF'
_installRemotePackage
__bashDocumentationCached
__usageMessage
__functionSettings
__dateFromTimestamp
EOF
}

# Extract and build the documentation settings cache and generate derived files
# Argument: --clean - Flag. Optional. Clean everything and then exit.
# Argument: --fingerprint - Flag. Optional. Use fingerprint to ensure results are up to date.
# Argument: --all - Flag. Optional. Do everything regardless of cache state.
# Argument: functionName ... - String. Optional. Specific functions to compile.
buildFunctionsCompile() {
  local handler="_${FUNCNAME[0]}"
  __buildFunctionsCompile "$handler" "$@" < <(
    __buildInternalFunctions
    buildFunctions
  )
}
_buildFunctionsCompile() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__buildFunctionsCompile() {
  local handler="$1" && shift
  local home && home=$(catchReturn "$handler" buildHome) || return $?
  set -- \
    --handler "$handler" \
    --source "$home/bin/build/tools" \
    --documentation "$home/documentation/source" \
    --target "$home/bin/build/documentation" \
    --key "buildFunctions" "$@"
  documentationFunctionsCompile "$@"
}

buildFunctionsRemoveDeprecated() {
  local handler="_${FUNCNAME[0]}"

  catchReturn "$handler" documentationFunctionRemove < <(catchReturn "$handler" buildDeprecatedFunctions) || return $?
}
_buildFunctionsRemoveDeprecated() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
