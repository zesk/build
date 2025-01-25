#!/usr/bin/env bash
#
# Update .md copies
#
# Copyright &copy; 2025 Market Acumen, Inc.
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

__addNoteTo() {
  statusMessage decorate info "Adding note to $1"
  cp "$1" bin/build
  printf -- "\n%s" "(this file is a copy - please modify the original)" >>"bin/build/$1"
  git add "bin/build/$1"
}

#
# Usage: {fn} [ --skip-commit ]
# Argument: --skip-commit - Skip the commit if the files change
#
__updateAvailable() {
  local usage="_${FUNCNAME[0]}"
  local packageLists

  local start
  start=$(__catchEnvironment "$usage" beginTiming) || return $?

  local forceFlag=false
  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
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
        __throwArgument "$usage" "unknown #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift || __throwArgument "$usage" "missing #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
  done

  local home
  home="$(__catchEnvironment "$usage" buildHome)" || return $?

  local managers=(apk debian ubuntu) allKnown=false
  if isDarwin && whichExists brew; then
    managers+=(brew)
    allKnown=true
  else
    statusMessage decorate info "No brew manager available ..."
    # TODO look at OS X inside Docker
  fi
  requireDirectory "$home/etc/packages/" || return $?

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
      ageInSeconds=$(__catchEnvironment "$usage" modificationSeconds "$manager") || return $?
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

  statusMessage --last reportTiming "$start" "completed in"
}
___updateAvailable() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__commonGenerator() {
  local forceFlag="$1" target="$2"

  shift 2
  if $forceFlag || [ ! -f "$target" ] || ! isNewestFile "$target" "$@"; then
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
