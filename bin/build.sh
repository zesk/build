#!/bin/bash
#
# Build Build
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#
# documentTemplate: ./docs/_templates/__binary.md

# IDENTICAL __source 21

# Load a source file and run a command
# Argument: source - Required. File. Path to source relative to application root..
# Argument: relativeHome - Optional. Directory. Path to application root. Defaults to `..`
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: _return
# Security: source
# Exit Code: 253 - source failed to load (internal error)
# Exit Code: 0 - source loaded (and command succeeded)
# Exit Code: ? - All other codes are returned by the command itself
__source() {
  local here="${BASH_SOURCE[0]%/*}" e=253
  local source="$here/${2:-".."}/${1-}" && shift 2 || _return $e "missing source" || return $?
  [ -d "${source%/*}" ] || _return $e "${source%/*} is not a directory" || return $?
  [ -f "$source" ] && [ -x "$source" ] || _return $e "$source not an executable file" "$@" || return $?
  local a=("$@") && set --
  # shellcheck source=/dev/null
  source "$source" || _return $e source "$source" "$@" || return $?
  [ ${#a[@]} -gt 0 ] || return 0
  "${a[@]}" || return $?
}

# IDENTICAL __tools 8

# Load build tools and run command
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: __source
__tools() {
  __source bin/build/tools.sh "$@"
}

# IDENTICAL _return 28

# Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)
# Argument: exitCode - Required. UnsignedInteger. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output
# Exit Code: exitCode
# Requires: isUnsignedInteger printf _return
_return() {
  local to=1 icon="✅" code="${1:-1}" && shift 2>/dev/null
  isUnsignedInteger "$code" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer \"$code\"" "$@" || return $?
  [ "$code" -eq 0 ] || icon="❌ [$code]" && to=2
  printf -- "%s %s\n" "$icon" "${*-§}" 1>&"$to"
  return "$code"
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
  case "${1#+}" in --help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | *[!0-9]*) return 1 ;; esac
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
  decorate pair "TERM" "${TERM-¢}"
  decorate pair "DISPLAY" "${DISPLAY-}"
  decorate pair "BUILD_COLORS" "${BUILD_COLORS-}"

}

#
# Build Zesk Build
#
# Argument: --debug - Flag. Debug TERM info.
# Argument: --documentation - Flag. Build the documentation.
# Argument: --no-documentation - Flag. Do not build the documentation. (Default)
# Argument: --commit - Flag. Commit any changes found.
# Argument: --no-commit - Flag. Do not commit any changes found, but leave the local repository modified. (Default)
# Argument: --debug - Flag. Debug TERM info.
__buildBuild() {
  local usage="_${FUNCNAME[0]}"

  local debugFlag=false makeDocumentation=false commitChanges=false

  export BUILD_COLORS

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --documentation)
      makeDocumentation=true
      ;;
    --no-documentation)
      makeDocumentation=false
      ;;
    --commit)
      commitChanges=true
      ;;
    --no-commit)
      commitChanges=false
      ;;
    --debug)
      __buildDebugColors
      debugFlag=true
      ;;
    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local start
  start=$(timingStart)

  ! $debugFlag || statusMessage decorate info "Installing AWS ..."
  __catchEnvironment "$usage" awsInstall || return $?

  local home
  home=$(__catchEnvironment "$usage" buildHome) || return $?

  ! $debugFlag || statusMessage decorate info "Updating markdown ..."
  if ! "$home/bin/update-md.sh" --skip-commit; then
    __catchEnvironment "$usage" "Can not update the Markdown files" || return $?
  fi

  ! $debugFlag || statusMessage decorate warning "Running deprecated ..."
  "$home/bin/build/deprecated.sh" || __throwEnvironment "$usage" "Deprecated failed" || return $?

  ! $debugFlag || statusMessage decorate warning "Running identical ..."
  "$home/bin/build/identical-repair.sh" || __throwEnvironment "$usage" "Identical repair failed" || return $?

  if $makeDocumentation; then
    local path rootShow rootPath="$home/documentation/site"
    rootShow=$(decorate file "$rootPath")
    for path in "$rootPath" "$home/documentation/.docs"; do
      if [ -d "$path" ]; then
        statusMessage decorate warning "Removing $path for build" || return $?
        __catchEnvironment "$usage" rm -rf "$path" || return $?
      fi
    done
    ! $debugFlag || statusMessage decorate warning "Building documentation ..."
    "$home/bin/documentation.sh" || __throwEnvironment "$usage" "Documentation failed" || return $?
    [ -d "$rootPath" ] || __throwEnvironment "$usage" "Documentation failed to create $rootShow" || return $?
  fi

  if $commitChanges && gitRepositoryChanged; then
    ! $debugFlag || statusMessage decorate info "Repository changed, committing ..."
    printf -- "%s\n" "CHANGES:" || :
    gitShowChanges | decorate code | decorate wrap "    "
    {
      ! git commit -m "Build version $(hookRun version-current)" -a && git push origin
    } || statusMessage --last decorate error "Commit or push failed. Continuing."
  elif gitRepositoryChanged; then
    ! $debugFlag || statusMessage --last decorate warning "Local repository changed."
  fi
  statusMessage --last "$start" "Built successfully in"
}
___buildBuild() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools .. __buildBuild "$@"
