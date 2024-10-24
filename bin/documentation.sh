#!/bin/bash
#
# Copyright: Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __source 17
# Usage: {fn} source relativeHome  [ command ... ] ]
# Load a source file and run a command
# Argument: source - Required. File. Path to source relative to application root..
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__source() {
  local me="${BASH_SOURCE[0]}" e=253
  local here="${me%/*}" a=()
  local source="$here/${2:-".."}/${1-}" && shift 2 || _return $e "missing source" || return $?
  [ -d "${source%/*}" ] || _return $e "${source%/*} is not a directory" || return $?
  [ -f "$source" ] && [ -x "$source" ] || _return $e "$source not an executable file" "$@" || return $?
  while [ $# -gt 0 ]; do a+=("$1") && shift; done
  # shellcheck source=/dev/null
  source "$source" || _return $e source "$source" "$@" || return $?
  [ ${#a[@]} -gt 0 ] || return 0
  "${a[@]}" || return $?
}

# IDENTICAL __tools 7
# Usage: {fn} [ relativeHome [ command ... ] ]
# Load build tools and run command
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__tools() {
  __source bin/build/tools.sh "$@"
}

# IDENTICAL _return 19
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
_return() {
  local r="${1-:1}" && shift
  _integer "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Is this an unsigned integer?
# Usage: {fn} value
# Exit Code: 0 - if value is an unsigned integer
# Exit Code: 1 - if value is not an unsigned integer
_integer() {
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

__buildDocumentationBuildDirectory() {
  local home="$1" subPath="$2" template="$3"
  shift 3
  documentationBuild --source "$home/bin" --template "$home/docs/_templates/$subPath" --unlinked-template "$home/docs/_templates/tools/todo.md" --unlinked-target "$home/docs/tools/todo.md" --target "$home/docs/$subPath" --function-template "$template" --page-template "$home/docs/_templates/__main.md" --see-prefix "./docs" "$@" || return $?
}

__buildDocumentationBuild() {
  local usage="_${FUNCNAME[0]}"
  local here="${BASH_SOURCE[0]%/*}" home

  __usageEnvironment "$usage" buildEnvironmentLoad APPLICATION_NAME || return $?
  lineFill . "$(consoleInfo "${APPLICATION_NAME} documentation started on $(consoleValue "$(date +"%F %T")")") "
  home=$(cd "$here/.." && pwd || _environment cd failed) || return $?

  example="$(wrapLines "    " "" <"$home/bin/build/tools/example.sh")" mapEnvironment <"$home/docs/_templates/coding.md" >"$home/docs/coding.md"

  __usageEnvironment "$usage" __buildDocumentationBuildDirectory "$home" "tools" "$(documentationTemplate "function")" "$@" || return $?

}
___buildDocumentationBuild() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools .. __buildDocumentationBuild "$@"
