#!/bin/bash
#
# Build Build
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#
# documentTemplate: ./docs/_templates/__binary.md

# IDENTICAL __source 19

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

# Load build tools and run command
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: __source _return
__tools() {
  __source bin/build/tools.sh "$@"
}

# IDENTICAL _return 26

# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Required. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
# Requires: isUnsignedInteger printf _return
_return() {
  local r="${1-:1}" && shift 2>/dev/null
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

__buildDebugColors() {
  printf -- "BUILD_COLORS=\"%s\"\n" "${BUILD_COLORS-}"
  printf -- "tput colors %s" "$(tput colors 2>&1 || :)"
  if hasColors; then
    decorate success "Has colors"
  else
    decorate error "No colors ${BUILD_COLORS-¢}"
  fi
  decorate pair "$width" "TERM" "${TERM-¢}"
  decorate pair "$width" "DISPLAY" "${DISPLAY-}"
  decorate pair "$width" "BUILD_COLORS" "${BUILD_COLORS-}"

}

#
# Build Zesk Build
#
# Argument: --debug - Flag. Debug TERM info.
__buildBuild() {
  local usage="_${FUNCNAME[0]}"
  local home
  local width=25
  export BUILD_COLORS

  __catchEnvironment "$usage" awsInstall || return $?

  local target cloudFrontID
  target=$(buildEnvironmentGet "DOCUMENTATION_S3_PREFIX") || return $?
  cloudFrontID=$(buildEnvironmentGet "DOCUMENTATION_CLOUDFRONT_ID") || return $?

  home=$(__catchEnvironment "$usage" buildHome) || return $?
  if [ "${1-}" = "--debug" ]; then
    __buildDebugColors
    shift
  fi

  if ! "$home/bin/update-md.sh" --skip-commit; then
    __catchEnvironment "$usage" "Can not update the Markdown files" || return $?
  fi

  if gitRepositoryChanged; then
    printf -- "%s\n" "CHANGES:" || :
    gitShowChanges | wrapLines "$(decorate code)    " "$(decorate reset)"
    git commit -m "Build version $(hookRun version-current)" -a || :
    git push origin || :
  fi
  "$home/bin/build/deprecated.sh" || __throwEnvironment "$usage" "Deprecated failed" || return $?
  "$home/bin/build/identical-repair.sh" || __throwEnvironment "$usage" "Identical repair failed" || return $?

  if [ -n "$target" ]; then
    [ -n "$target" ] || __throwEnvironment "$usage" "DOCUMENTATION_S3_PREFIX is blank" || return $?
    [ "$target" != "${target#s3://}" ] || __throwEnvironment "$usage" "DOCUMENTATION_S3_PREFIX=$(decorate code "$target") is NOT a S3 URL" || return $?

    [ -n "$cloudFrontID" ] || __throwEnvironment "$usage" "DOCUMENTATION_CLOUDFRONT_ID is blank" || return $?

    local rootShow rootPath="$home/documentation/site"
    rootShow=$(decorate file "$rootPath")
    if [ -d "$home/documentation/site" ]; then
      statusMessage decorate info "Removing $rootShow" || return $?
      __catchEnvironment "$usage" rm -rf "$rootPath" || return $?
    fi
    "$home/bin/documentation.sh" || __throwEnvironment "$usage" "Documentation failed" || return $?
    [ -d "$home/documentation/site" ] || __throwEnvironment "$usage" "Documentation failed to create $rootShow" || return $?
    __catchEnvironment "$usage" aws s3 sync --delete "$rootPath" "$target" || return $?
    __catchEnvironment "$usage" aws cloudfront create-invalidation --distribution-id "$cloudFrontID" --paths / || return $?
  fi
  decorate success Built successfully.
}
___buildBuild() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools .. __buildBuild "$@"
