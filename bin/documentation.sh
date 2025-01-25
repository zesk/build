#!/bin/bash
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL __source 19
# Usage: {fn} source relativeHome  [ command ... ] ]
# Load a source file and run a command
# Argument: source - Required. File. Path to source relative to application root..
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: _return
# Security: source
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

# IDENTICAL __tools 8
# Usage: {fn} [ relativeHome [ command ... ] ]
# Load build tools and run command
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: __source _return
__tools() {
  __source bin/build/tools.sh "$@"
}

# IDENTICAL _return 25
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
# Requires: isUnsignedInteger printf
_return() {
  local r="${1-:1}" && shift
  isUnsignedInteger "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf -- "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Test if an argument is an unsigned integer
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Original: is_uint
# Usage: {fn} argument ...
# Exit Code: 0 - if it is an unsigned integer
# Exit Code: 1 - if it is not an unsigned integer
# Requires: _return
isUnsignedInteger() {
  [ $# -eq 1 ] || _return 2 "Single argument only: $*" || return $?
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

__buildDocumentationBuildDirectory() {
  local home="$1" subPath="$2" template="$3"
  shift 3
  documentationBuild --source "$home/bin" --template "$home/docs/_templates/$subPath" --unlinked-template "$home/docs/_templates/tools/todo.md" --unlinked-target "$home/docs/tools/todo.md" --target "$home/docs/$subPath" --function-template "$template" --page-template "$home/docs/_templates/__main.md" --see-prefix "./docs" "$@" || return $?
}

# Build the build documentation
# See: documentationBuild
__buildDocumentationBuild() {
  local usage="_${FUNCNAME[0]}"
  local here="${BASH_SOURCE[0]%/*}" home

  __catchEnvironment "$usage" buildEnvironmentLoad APPLICATION_NAME || return $?
  lineFill . "$(decorate info "${APPLICATION_NAME} documentation started on $(decorate value "$(date +"%F %T")")") "
  home=$(cd "$here/.." && pwd || _environment cd failed) || return $?

  example="$(wrapLines "    " "" <"$home/bin/build/tools/example.sh")" mapEnvironment <"$home/docs/_templates/coding.md" >"$home/docs/coding.md"

  if [ "${1-}" != "--clean" ]; then
    local newestParts newestDocs
    newestParts=$(directoryNewestFile "$home/docs/_templates/_parts")
    newestDocs=$(directoryNewestFile "$home/docs")
    if isNewestFile "$newestParts" "$newestDocs"; then
      documentationTemplateUpdate "$home/docs" "$home/docs/_templates/_parts" || return $?
    fi
  fi
  # This was more complex before fix it later
  for f in "$home/docs/_templates/"*.md; do
    local name target
    name=$(basename "$f") target="$home/docs/$name"
    [ "${name#_}" = "$name" ] || continue
    if isNewestFile "$f" "$target"; then
      cp "$f" "$target"
    fi
  done

  __catchEnvironment "$usage" __buildDocumentationBuildDirectory "$home" "tools" "$(documentationTemplate "function")" "$@" || return $?

}
___buildDocumentationBuild() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools .. __buildDocumentationBuild "$@"
