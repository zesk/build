#!/usr/bin/env bash
#
# Update .md copies
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

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

__addNoteTo() {
  statusMessage decorate info "Adding note to $1"
  cp "$1" bin/build
  printf -- "\n%s" "(this file is a copy - please modify the original)" >>"bin/build/$1"
  git add "bin/build/$1"
}

#
# Usage: {fn} [ --skip-commit ]
# Argument: --skip-commit - Skip the commit if the files change
# Requires: __catchEnvironment __throwArgument timingStart isDarwin whichExists statusMessage
# Requires: decorate __decorateExtensionEach
__updateAvailable() {
  local usage="_${FUNCNAME[0]}"
  local packageLists

  local start
  start=$(timingStart) || return $?

  local forceFlag=false
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
    --force)
      forceFlag=true
      ;;
    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local home
  home="$(__catchEnvironment "$usage" buildHome)" || return $?

  local managers=(apk debian ubuntu) allKnown=false
  if isDarwin; then
    if whichExists brew; then
      managers+=(brew)
      allKnown=true
    fi
    if whichExists port; then
      managers+=(port)
      allKnown=true
    fi
  else
    statusMessage decorate info "No brew manager available ..."
    # TODO can we put OS X inside Docker?
  fi
  directoryRequire "$home/etc/packages/" || return $?

  __catchEnvironment muzzle pushd "$home/etc/packages" || return $?

  local target ageInSeconds allManagerLists
  local allManagerLists=() manager generator
  for manager in "${managers[@]}"; do
    allManagerLists+=("$manager")
    statusMessage decorate info "Generating $manager list ..."
    generator="__${manager}Generator"
    isFunction "$generator" || __throwEnvironment "$usage" "$generator is not a function" || return $?
    if [ -f "$manager" ] && ! $forceFlag; then
      local ageInSeconds
      ageInSeconds=$(__catchEnvironment "$usage" fileModificationSeconds "$manager") || return $?
      if [ "$ageInSeconds" -lt 3600 ]; then
        statusMessage decorate warning "Skipping generated $manager ($((ageInSeconds / 60)) minutes old ..."
        continue
      fi
    fi
    # Some generate CRLF so delete CR
    "$generator" "$usage" | tr -d '\015' | sort | tee "$manager" >/dev/null || return $?
  done
  if ! $allKnown; then
    forceFlag=true
    statusMessage decorate info "No access to all package managers - forcing group generation"
  fi
  IFS=$'\n' read -d '' -r -a packageLists < <(find "." -type f ! -path '*/_*') || :

  __commonGenerator "$forceFlag" "_all" "${packageLists[@]}" || return $?
  __commonGenerator "$forceFlag" "_apk-apt" "apk" "debian" "ubuntu" || return $?
  __commonGenerator "$forceFlag" "_debian-ubuntu" "debian" "ubuntu" || return $?

  __catchEnvironment muzzle popd || return $?

  statusMessage --last timingReport "$start" "completed in"
}
___updateAvailable() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__commonGenerator() {
  local forceFlag="$1" target="$2"

  shift 2
  if $forceFlag || [ ! -f "$target" ] || ! fileIsNewest "$target" "$@"; then
    statusMessage decorate info "Generating $(basename "$target") ..."
    cat "$@" | sort | uniq -c | grep -e "^[[:space:]]*$# " | awk '{ print $2 }' | tee "$target" >/dev/null
  else
    statusMessage decorate info "$(basename "$target") is up to date"
  fi
}

__apkGenerator() {
  __catchEnvironment "$1" alpineContainer --local "$home" "/root/build/bin/build/tools.sh" "packageAvailableList" || return $?
}
__debianGenerator() {
  __catchEnvironment "$1" dockerLocalContainer --local "$home" --image debian:latest --path "/root/build" "/root/build/bin/build/tools.sh" "packageAvailableList" || return $?
}
__ubuntuGenerator() {
  __catchEnvironment "$1" dockerLocalContainer --local "$home" --image ubuntu:latest --path "/root/build" "/root/build/bin/build/tools.sh" "packageAvailableList" || return $?
}
__brewGenerator() {
  __catchEnvironment "$1" "$home/bin/build/tools.sh" "packageAvailableList" || return $?
}
__tools .. __updateAvailable "$@"
