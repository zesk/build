#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

#   _   _ ___  __ _  __ _  ___
#  | | | / __|/ _` |/ _` |/ _ \
#  | |_| \__ \ (_| | (_| |  __/
#   \__,_|___/\__,_|\__, |\___|
#                   |___/

# Argument: handler - Function. Required. Error handler.
# Argument: function - Function. Required. Function to call; first argument will be `handler`.
# Argument ... - Arguments. Optional. Additional arguments to the function.
__usageLoader() {
  __buildFunctionLoader __usageDocument usage "$@"
}

# Summary: Universal error handler for functions (with formatting)
#
# Actual function is called `{functionName}`.
#
# Argument: functionDefinitionFile - File. Required. The file in which the function is defined. If you don't know, use `__bashDocumentation_FindFunctionDefinitions` or `__bashDocumentation_FindFunctionDefinition`.
# Argument: functionName - String. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.
# Argument: exitCode - Integer. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.
# Argument: message - String. Optional. A message.
#
# Generates console usage output for a script using documentation tools parsed from the comment of the function identified.
#
# Simplifies documentation and keeps it with the code.
#
# Environment: *BUILD_DEBUG* - Add `fast-usage` to make this quicker when you do not care about usage/failure.
# BUILD_DEBUG: fast-usage - `usageDocument` does not output formatted help for performance reasons
# BUILD_DEBUG: handler - For all `--help` and any function which uses `usageTemplate` to output documentation (upon error), the stack will be displayed
usageDocument() {
  #  usageDocumentSimple "$@"
  __usageLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_usageDocument() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL __usageDocumentCached 22

# Argument: handler - Function. Required.
# Argument: home - Directory. BUILD_HOME
# Argument: functionName - String. Function to display usage for
# Environment: BUILD_COLORS
__usageDocumentCached() {
  local handler="${1-}" && shift
  local home="${1-}" && shift
  local functionName="${1-}" && shift
  local settingsFile="$home/bin/build/documentation/$functionName.sh"
  [ -f "$settingsFile" ] || return 1
  (
    local helpConsole helpPlain
    # shellcheck source=/dev/null
    catchEnvironment "$handler" source "$settingsFile" || return $?
    if [ "${BUILD_COLORS-}" != "false" ]; then
      catchEnvironment "$handler" printf "%s\n" "$helpConsole" || return $?
    else
      catchEnvironment "$handler" printf "%s\n" "$helpPlain" || return $?
    fi
  ) || return $?
}


# IDENTICAL usageDocumentSimple 33

# Output a simple error message for a function
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: source - File. Required. File where documentation exists.
# Argument: function - String. Required. Function to document.
# Argument: returnCode - UnsignedInteger. Required. Exit code to return.
# Argument: message ... - String. Optional. Message to display to the user.
# Requires: bashFunctionComment decorate read printf returnCodeString __help usageDocument __usageDocumentCached
usageDocumentSimple() {
  local handler="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local source="${1-}" functionName="${2-}" returnCode="${3-}" color helpColor="info" icon="❌" skip=false && shift 3

  case "$returnCode" in 0) icon="🏆" && color="info" && [ $# -ne 0 ] || skip=true ;; 1) color="error" ;; 2) color="red" ;; *) color="orange" ;; esac
  [ "$returnCode" -eq 0 ] || exec 1>&2
  $skip || printf -- "%s [%s] %s\n" "$icon" "$(decorate "code" "$(returnCodeString "$returnCode")")" "$(decorate BOLD "$color" "$*")"
  export BUILD_HOME
  if [ ! -f "$source" ]; then
    [ -d "${BUILD_HOME-}" ] || returnArgument "Unable to locate $source (${PWD-})" || return $?
    source="$BUILD_HOME/$source"
    [ -f "$source" ] || returnArgument "Unable to locate $source (${PWD-})" || return $?
  fi
  if ! __usageDocumentCached "$handler" "${BUILD_HOME-}" "${functionName}"; then
    bashFunctionComment "$source" "$functionName" | sed "s/{fn}/$functionName/g" | decorate "$helpColor"
  fi
  return "$returnCode"
}
_usageDocumentSimple() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Check that one or more binaries are installed
# Argument: usageFunction - Required. `bash` function already defined to output handler
# Argument: binary - Required. Binary which must have a `which` path.
# Return Code: 1 - If any `binary` is not available within the current path
# Requires the binaries to be found via `which`
#
# Runs `handler` on failure
#
usageRequireBinary() {
  # IDENTICAL usageFunctionHeader 6
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local usageFunction="${1-}" && shift
  if [ "$(type -t "$usageFunction")" != "function" ]; then
    catchArgument "$handler" "$(decorate code "$handler") must be a valid function" || return $?
  fi
  local binary
  for binary in "$@"; do
    whichExists "$binary" || throwEnvironment "$handler" "$binary is not available in path, not found: $(decorate code "$PATH")"
  done
}
_usageRequireBinary() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Requires environment variables to be set and non-blank
# Argument: usageFunction - Required. `bash` function already defined to output handler
# Argument: environmentVariable - String. Optional. One or more environment variables which should be set and non-empty.
# Return Code: 0 - All environment variables are set and non-empty
# Return Code: 1 - If any `environmentVariable` variables are not set or are empty.
# Deprecated: 2024-01-01
#
usageRequireEnvironment() {
  # IDENTICAL usageFunctionHeader 6
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local usageFunction="${1-}" && shift
  if [ "$(type -t "$usageFunction")" != "function" ]; then
    catchArgument "$handler" "$(decorate code "$handler") must be a valid function" || return $?
  fi
  local environmentVariable
  for environmentVariable in "$@"; do
    if [ -z "${!environmentVariable-}" ]; then
      throwEnvironment "$usageFunction" "Environment variable $(decorate code "$environmentVariable") is required" || return $?
    fi
  done
}
_usageRequireEnvironment() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
