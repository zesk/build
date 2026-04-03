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
  __buildFunctionLoader __bashDocumentation usage "$@"
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
# BUILD_DEBUG: fast-usage - `bashDocumentation` does not output formatted help for performance reasons
# BUILD_DEBUG: handler - For all `--help` and any function which uses `usageTemplate` to output documentation (upon error), the stack will be displayed
bashDocumentation() {
  #  bashSimpleDocumentation "$@"
  __usageLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_bashDocumentation() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL __usageMessage 39

# Summary: Icon for usage messages
# - `0` - meaning no error, icon is `🏆`
# - non-`0` - Error, icon is `❌`
__usageMessageIcon() {
  [ "$1" -eq 0 ] && printf -- "%s" "🏆" || printf -- "%s" "❌"
}

# Summary: Style usage messages
# Format arguments using the usage message return code to style output.
# Argument: returnCode - UnsignedInteger. Required. Return code to use as the basis for styling output.
# - `0` - meaning no error, style is `info`
# - `1` - Environment error, style is `error`
# - `2` - Argument error, style is `red`
# - `*` - All additional errors, style is `orange`
__usageMessageStyle() {
  local color="info" && case "$1" in 0) ;; 1) color="error" ;; 2) color="red" ;; *) color="orange" ;; esac && shift
  decorate "$color" "$@"
}

# Output the message for usage consistently
# Argument: returnCode - UnsignedInteger. Optional. Exit code to possibly display with message.
# Argument: message ... - String. Optional. Display this message which describes why `exitCode` occurred.
# Requires: decorate returnCodeString
__usageMessage() {
  local returnCode="${1-0}"
  [ $# -eq 0 ] || shift
  local suffix="$*"
  if [ "$returnCode" -eq 0 ]; then
    [ -n "$suffix" ] || return 0
    __usageMessageStyle "$returnCode" "$suffix"
  elif [ "$returnCode" != 2 ]; then
    [ -z "$suffix" ] || suffix=" $(decorate code "$suffix")"
    printf "%s %s%s\n" "$(__usageMessageIcon "$returnCode")" "$(__usageMessageStyle "$returnCode" "[$(returnCodeString "$returnCode")]")" "$suffix"
  else
    [ -z "$suffix" ] || suffix=" $(decorate code "$suffix")"
    printf "%s %s%s\n" "$(__usageMessageIcon "$returnCode")" "$(__usageMessageStyle "$returnCode" "[$(returnCodeString "$returnCode")]")" "$suffix"
  fi
}

# IDENTICAL __functionSettings 19

# Summary: Load cached function comment values
# Argument: home - Directory. BUILD_HOME
# Argument: functionName - String. Function to fetch settings for
# Environment: BUILD_DOCUMENTATION_PATH
# Requires:
__functionSettings() {
  local home="$1" && shift
  local functionName="$1" && shift
  export BUILD_DOCUMENTATION_PATH
  local paths && IFS=":" read -r -d $'\n' -a paths <<<"${BUILD_DOCUMENTATION_PATH-"bin/build/documentation"}"
  local settingsFile="" path && for path in "${paths[@]+"${paths[@]}"}"; do
    settingsFile="$home/${path%/}/$functionName.sh"
    [ -f "$settingsFile" ] || continue
    printf "%s\n" "$settingsFile"
    return 0
  done
  return 1
}

# IDENTICAL __bashDocumentationCached 31

# Summary: Display cached usage for a function
# Argument: handler - Function. Required.
# Argument: home - Directory. BUILD_HOME
# Argument: functionName - String. Function to display usage for
# Argument: returnCode - UnsignedInteger. Optional. Exit code to display. Defaults to `0` - no error.
# Argument: message ... - String. Optional. Display this message which describes why `exitCode` occurred.
# Environment: BUILD_COLORS
# Environment: BUILD_DOCUMENTATION_PATH
# Requires: decorateThemed catchEnvironment __usageMessage decorate __functionSettings
__bashDocumentationCached() {
  local handler="$1" && shift
  local home="$1" && shift
  local functionName="$1" && shift
  local settingsFile && settingsFile=$(__functionSettings "$home" "$functionName") || return $?

  decorateInitialized || decorate info -- || return $?
  (
    local helpConsole="" helpPlain=""
    # shellcheck source=/dev/null
    catchEnvironment "$handler" source "$settingsFile" || return $?
    if [ "${BUILD_COLORS-}" != "false" ] && [ -n "$helpConsole" ]; then
      __usageMessage "$@" || return $?
      catchEnvironment "$handler" decorateThemed <<<"$helpConsole" || return $?
    else
      [ -n "$helpPlain" ] || return 1
      __usageMessage "$@" || return $?
      catchEnvironment "$handler" printf "%s\n" "$helpPlain" || return $?
    fi
  ) || return $?
}

# Output a simple error message for a function
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: source - File. Required. File where documentation exists.
# Argument: function - String. Required. Function to document.
# Argument: returnCode - UnsignedInteger. Required. Exit code to return.
# Argument: message ... - String. Optional. Message to display to the user.
# Requires: bashFunctionComment decorate read printf returnCodeString __help bashDocumentation __bashDocumentationCached
bashSimpleDocumentation() {
  local handler="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local source="${1-}" functionName="${2-}" returnCode="${3-}" && shift 3

  [ "$returnCode" -eq 0 ] || exec 3>&1 1>&2
  if ! __bashDocumentationCached "$handler" "${BUILD_HOME-}" "${functionName}" "$returnCode" "$@"; then
    local color="info" icon="❌" skip=false && case "$returnCode" in 0) icon="🏆" && [ $# -ne 0 ] || skip=true ;; 1) color="error" ;; 2) color="red" ;; *) color="orange" ;; esac
    $skip || printf -- "%s [%s] %s\n" "$icon" "$(decorate "code" "$(returnCodeString "$returnCode")")" "$(decorate BOLD "$color" "$*")"
    export BUILD_HOME
    if [ ! -f "$source" ]; then
      [ -d "${BUILD_HOME-}" ] || returnArgument "Unable to locate $source (${PWD-})" || return $?
      source="$BUILD_HOME/$source"
      [ -f "$source" ] || returnArgument "Unable to locate $source (${PWD-})" || return $?
    fi
    bashFunctionComment "$source" "$functionName" | sed "s/{fn}/$functionName/g" | decorate "$color"
  fi
  [ "$returnCode" -eq 0 ] || exec 1>&3 3>&-
  return "$returnCode"
}
_bashSimpleDocumentation() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Check that one or more binaries are installed
# Argument: usageFunction - Required. `bash` function already defined to output handler
# Argument: binary - Required. Binary which must have a `which` path.
# Return Code: 1 - If any `binary` is not available within the current path
# Requires the binaries to be found via `which`
#
# Runs `handler` on failure
#
executableRequire() {
  # IDENTICAL usageFunctionHeader 6
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local usageFunction="${1-}" && shift
  if [ "$(type -t "$usageFunction")" != "function" ]; then
    catchArgument "$handler" "$(decorate code "$handler") must be a valid function" || return $?
  fi
  local binary
  for binary in "$@"; do
    executableExists "$binary" || throwEnvironment "$handler" "$binary is not available in path, not found: $(decorate code "$PATH")"
  done
}
_executableRequire() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Requires environment variables to be set and non-blank
# Argument: usageFunction - Required. `bash` function already defined to output handler
# Argument: environmentVariable - String. Optional. One or more environment variables which should be set and non-empty.
# Return Code: 0 - All environment variables are set and non-empty
# Return Code: 1 - If any `environmentVariable` variables are not set or are empty.
# Deprecated: 2024-01-01
#
environmentRequire() {
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
_environmentRequire() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
