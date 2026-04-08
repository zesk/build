#!/usr/bin/env bash
#
# Original of application.sh
#
# This template can be used to load or install Zesk Build in another project
#
# - Copy this file to bin/tools.sh
# - Copy install-bin-build.sh to bin/install-bin-build.sh
# - `source bin/tools.sh` installs and loads Zesk Build.
#
# Copyright &copy; 2026, Market Acumen, Inc.
#

# _IDENTICAL_ application.sh EOF

#
# This file generically loads all application tools in `./bin/tools` and allows for extensions
# to Zesk Build within an application with little effort.
#
# Copy this file into your application project at `./bin/` next to `install-bin-build.sh`
#
# To do `developerTrack` define `DEVELOPER_TRACK` prior to sourcing this file to get
# access to functions created via `__applicationToolsList`.
#
# Environment: DEVELOPER_TRACK
#

# IDENTICAL __source 21

# Load a source file and run a command
# Argument: source - File. Required. Path to source relative to application root..
# Argument: relativeHome - Directory. Optional. Path to application root. Defaults to `..`
# Argument: command ... - Callable. Optional. A command to run and optional arguments.
# Requires: returnMessage
# Security: source
# Return Code: 253 - source failed to load (internal error)
# Return Code: 0 - source loaded (and command succeeded)
# Return Code: ? - All other codes are returned by the command itself
__source() {
  local here="${BASH_SOURCE[0]%/*}" e=253
  local source="$here/${2:-".."}/${1-}" && shift 2 || returnMessage $e "missing source" || return $?
  [ -d "${source%/*}" ] || returnMessage $e "${source%/*} is not a directory" || return $?
  [ -f "$source" ] && [ -x "$source" ] || returnMessage $e "$source not an executable file" "$@" || return $?
  local a=("$@") && set --
  # shellcheck source=/dev/null
  source "$source" || returnMessage $e source "$source" "$@" || return $?
  [ ${#a[@]} -gt 0 ] || return 0
  "${a[@]}" || return $?
}

# IDENTICAL __tools 8

# Load build tools and run command
# Argument: relativeHome - Directory. Required. Path to application root.
# Argument: command ... - Callable. Optional. A command to run and optional arguments.
# Requires: __source
__tools() {
  __source bin/build/tools.sh "$@"
}

# IDENTICAL __install 25

# Load a bash script (installing if needed) and run an optional command
# Argument: installer - File. Required. Installation binary.
# Argument: source - File. Required. Include file which should exist after installation.
# Argument: relativeHome - Directory. Optional. Path to application home. Default is `..`.
# Argument: command ... - Callable. Optional. A command to run and optional arguments.
# Example:      __install bin/install-bin-build.sh bin/build/tools.sh ../../.. decorate info "$@"
# Requires: returnMessage execute
__install() {
  local installer="${1-}" source="${2-}" relativeHome="${3:-".."}" me="${BASH_SOURCE[0]}"
  local here="${me%/*}" e=253 a
  local install="$here/$relativeHome/$installer" tools="$here/$relativeHome/$source"
  [ -n "$installer" ] || returnMessage $e "blank installer" || return $?
  [ -n "$source" ] || returnMessage $e "blank source" || return $?
  if [ ! -x "$tools" ]; then
    "$install" || returnMessage $e "$install failed" || return $?
    [ -d "${tools%/*}" ] || returnMessage $e "$install failed to create directory ${tools%/*}" || return $?
  fi
  [ -x "$tools" ] || returnMessage $e "$install failed to create $tools" "$@" || return $?
  shift 3 && a=("$@") && set --
  # shellcheck source=/dev/null
  source "$tools" || returnMessage "$e" source "$tools" || return $?
  [ ${#a[@]} -gt 0 ] || return 0
  execute "${a[@]}" || return $?
}

# IDENTICAL __build 11

# Load build tools (installing if needed) and runs a command
# Argument: relativeHome - Directory. Optional. Path to application home.
# Argument: installerPath - Directory. Optional. Path to `install-bin-build.sh` binary. Defaults to `bin`
# Argument: command ... - Callable. Optional. A command to run and optional arguments.
# Requires: __install
# Example:     __build ../../.. functionToCall "$@"
__build() {
  local relative="${1:-".."}" installerPath="${2:-"bin"}" && shift && shift
  __install "$installerPath/install-bin-build.sh" "bin/build/tools.sh" "$relative" "$@" || return $?
}

# IDENTICAL executableExists 39

# Summary: Does a binary exist in the PATH?
# Argument: --any - Flag. Optional. If any binary exists then return 0 (success). Otherwise, all binaries must exist.
# Argument: binary ... - String. Required. One or more Binaries to find in the system `PATH`.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Return Code: 0 - If all values are found (without the `--any` flag), or if *any* binary is found with the `--any` flag
# Return Code: 1 - If any value is not found (without the `--any` flag), or if *all* binaries are NOT found with the `--any` flag.
# Example:     executableExists cp date aws ls mv stat || throwEnvironment "$handler" "Need basic environment to work" || return $?
# Example:     executableExists --any terraform tofu || throwEnvironment "$handler" "No available infrastructure providers" || return $?
# Example:     executableExists --any curl wget || throwEnvironment "$handler" "No way to download URLs easily" || return $?
# Requires: throwArgument decorate __decorateExtensionEach command
executableExists() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$# anyFlag=false
  [ $# -gt 0 ] || throwArgument "$handler" "no arguments" || return $?
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --any) anyFlag=true ;;
    *)
      local bin
      # printf is returned as just printf with no path, same with all builtins
      bin=$(command -v "$1" 2>/dev/null) || return 1
      [ -n "$bin" ] || return 1
      [ "${bin:0:1}" != "/" ] || [ -e "$bin" ] || return 1
      ! $anyFlag || return 0
      ;;
    esac
    shift
  done
}
_executableExists() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL fileRealPath 32

# Find the full, actual path of a file avoiding symlinks or redirection.
# See: readlink realpath
# DOC TEMPLATE: noArgumentsForHelp 1
# Without arguments, displays help.
# Argument: file ... - File. Required. One or more files to `realpath`.
# Requires: executableExists realpath __help bashDocumentation returnArgument
fileRealPath() {
  local handler="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || __help "$handler" --help || return 0
  if executableExists realpath; then
    catchReturn "$handler" realpath "$@" || return $?
  else
    local here && here=$(catchReturn "$handler" pwd) && here="${here%/}/" || return $?
    while [ $# -gt 0 ]; do
      if [ -L "$1" ]; then
        readlink "$1"
      elif [ -e "$1" ]; then
        local prefix=""
        [ "${1#/}" != "$1" ] || prefix="$here"
        printf "%s%s\n" "$prefix" "$1"
      else
        throwEnvironment "$handler" "$1 does not exist" || return $?
      fi
      shift
    done
  fi
}
_fileRealPath() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL returnMessage 43

# Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)
# Argument: exitCode - UnsignedInteger. Required. Exit code to return. Default is 1.
# Argument: message ... - String. Optional. Message to output
# Return Code: exitCode
# Requires: isUnsignedInteger printf returnMessage
returnMessage() {
  local handler="_${FUNCNAME[0]}"
  local code="${1:-1}" && shift 2>/dev/null
  if [ "$code" = "--help" ]; then "$handler" 0 && return; fi
  local trace="${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> "
  isUnsignedInteger "$code" || returnMessage 2 "$trace${handler#_} non-integer \"$code\"" "$@" || return $?
  if [ "$code" -gt 0 ]; then
    printf -- "%s%s %s\n" "❌ $trace" "[$code]" "${*-§}" 1>&2
  else
    printf -- "%s %s\n" "✅" "${*-§}"
  fi
  return "$code"
}
_returnMessage() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Is value an unsigned integer?
# Test if a value is a 0 or greater integer. Leading "+" is ok.
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Original: is_uint
# Argument: value - EmptyString. Value to test if it is an unsigned integer.
# Return Code: 0 - if it is an unsigned integer
# Return Code: 1 - if it is not an unsigned integer
# Requires: returnMessage
isUnsignedInteger() {
  [ $# -eq 1 ] || returnMessage 2 "Single argument only: $*" || return $?
  case "${1#+}" in --help) bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | *[!0-9]*) return 1 ;; esac
}
_isUnsignedInteger() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# <-- END of IDENTICAL returnMessage

__applicationTools() {
  local source="${BASH_SOURCE[0]}"
  local here="${source%/*}" __saved=("$@")

  set --
  __build .. bin >/dev/null || return $?

  bashSourcePath "$(fileRealPath "$here/tools/")" || return $?

  "${__saved[@]+"${__saved[@]}"}" || return $?
}

if [ "$(basename "${0##-}")" = "$(basename "${BASH_SOURCE[0]}")" ] && [ $# -gt 0 ]; then
  __applicationTools "$@"
else
  __applicationTools :
fi
