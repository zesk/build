#!/bin/bash
#
# Copyright: Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __tools 17
# Usage: {fn} [ relative [ command ... ] ]
# Load build tools and run command
# Argument: relative - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
__tools() {
  local source="${BASH_SOURCE[0]}" e=253
  local here="${source%/*}"
  local tools="$here/${1:-".."}/bin/build"
  [ -d "$tools" ] || _return $e "$tools is not a directory" || return $?
  tools="$tools/tools.sh"
  [ -x "$tools" ] || _return $e "$tools not executable" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return $e source "$tools" "$@" || return $?
  shift
  [ $# -eq 0 ] && return 0
  "$@" || return $?
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

# END of IDENTICAL _return

#
# Documentation configuration
#
_buildDocumentationPaths() {
  cat <<EOF
tools function
hooks hook
bin binary
EOF
}

__buildDocumentationBuildDirectory() {
  local home="$1" subPath="$2" template="$3"
  shift 3
  __environment documentationBuild --source "$home/bin" --template "$home/docs/_templates/$subPath" --unlinked-template "$home/docs/_templates/tools/todo.md" --unlinked-target "$home/docs/tools/todo.md" --target "$home/docs/$subPath" --function-template "$template" --page-template "$home/docs/_templates/__main.md" --see-prefix "./docs" "$@" || return $?
}

__buildDocumentationBuild() {
  local here="${BASH_SOURCE[0]%/*}" home subPath templateCode

  home=$(cd "$here/.." && pwd || _environment cd failed) || return $?
  case "$1" in
    --unlinked)
      documentationUnlinked
      return 0
      ;;
    --unlinked-update)
      __buildDocumentationBuildDirectory "$home" "tools" "$(documentationTemplate "function")" "$@"
      ;;
    *)
      documentationTemplateUpdate "$home/docs/_templates" "$home/docs/_templates/_parts" || return $?
      while read -r subPath templateCode; do
        template="$(__environment documentationTemplate "$templateCode")" || return $?
        __buildDocumentationBuildDirectory "$home" "$subPath" "$template" "$@" || return $?
      done < <(_buildDocumentationPaths)
      ;;
  esac
}
__tools .. __buildDocumentationBuild "$@"
