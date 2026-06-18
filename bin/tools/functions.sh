#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

buildFunctionsListSeeUnfinished() {
  local handler="_${FUNCNAME[0]}"

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local path="$home/bin/build/documentation"
  find "$path" -mindepth 1 -maxdepth 1 -type f -name '*.md' -print0 | xargs -0 grep -l '{SEE' | cut -c $((${#path} + 2))- | cut -f 1 -d . | sort
}
_buildFunctionsListSeeUnfinished() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

buildFunctionsSeeLoop() {
  local count=99

  while [ "$count" -gt 0 ]; do
    count=$(buildFunctionsListSeeUnfinished | fileLineCount)
    [ "$count" -gt 0 ] || break
    decorate big "$count" | decorate red
    buildFunctionsListSeeUnfinished | head -10
    sleep 10 && clear
  done
}

buildFunctionsSeeAgain() {
  local handler="_${FUNCNAME[0]}"

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local fun && while read -r fun; do
    local funFile="$home/bin/build/documentation/$fun.md"
    [ ! -f "$funFile" ] || catchReturn "$handler" touch -d "1970-01-01T00:00:00" "$funFile" || return $?
  done < <(buildFunctionsListSeeUnfinished)
  __buildFunctionsCompile "$handler" --stdin "$@" < <(buildFunctionsListSeeUnfinished)
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
