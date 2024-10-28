#!/usr/bin/env bash
#
# Update .md copies
#
# Copyright &copy; 2024 Market Acumen, Inc.
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

__addNoteTo() {
  statusMessage consoleInfo "Adding note to $1"
  cp "$1" bin/build
  printf "\n%s" "(this file is a copy - please modify the original)" >>"bin/build/$1"
  git add "bin/build/$1"
}

#
# Usage: {fn} [ --skip-commit ]
# Argument: --skip-commit - Skip the commit if the files change
#
__updateAvailable() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved
  local home manager managers target generator forceFlag=false ageInSeconds allManagerLists allKnown=false
  local packageLists

  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --force)
        forceFlag=true
        ;;
      *)
        # IDENTICAL argumentUnknown 1
        __failArgument "$usage" "unknown argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  home="$(__usageEnvironment "$usage" buildHome)" || return $?

  managers=(apk debian ubuntu)
  if [ "$(uname -s)" = "Darwin" ] && whichExists brew; then
    managers+=(brew)
    allKnown=true
  else
    statusMessage consoleInfo "No brew manager available ..."
    # TODO look at OS X inside Docker
  fi
  requireDirectory "$home/etc/packages/" || return $?

  __usageEnvironment muzzle pushd "$home/etc/packages" || return $?

  allManagerLists=()
  for manager in "${managers[@]}"; do
    allManagerLists+=("$manager")
    statusMessage consoleInfo "Generating $manager list ..."
    generator="__${manager}Generator"
    isFunction "$generator" || __failEnvironment "$usage" "$generator is not a function" || return $?
    if [ -f "$manager" ] && ! $forceFlag; then
      ageInSeconds=$(__usageEnvironment "$usage" modificationSeconds "$manager") || return $?
      if [ "$ageInSeconds" -lt 3600 ]; then
        statusMessage consoleWarning "Skipping generated $manager ($((ageInSeconds / 60)) minutes old ..."
        continue
      fi
    fi
    # Some generate CRLF so delete CR
    "$generator" "$usage" | tr -d '\015' | sort | tee "$manager" >/dev/null || return $?
  done
  if ! $allKnown; then
    forceFlag=true
    statusMessage consoleInfo "No access to all package managers - forcing group generation"
  fi
  IFS=$'\n' read -d '' -r -a packageLists < <(find "." -type f ! -path '*/_*') || :

  __commonGenerator "$forceFlag" "_all" "${packageLists[@]}" || return $?
  __commonGenerator "$forceFlag" "_apk-apt" "apk" "debian" "ubuntu" || return $?
  __commonGenerator "$forceFlag" "_debian-ubuntu" "debian" "ubuntu" || return $?

  __usageEnvironment muzzle popd || return $?

  clearLine
}
___updateAvailable() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__commonGenerator() {
  local forceFlag="$1" target="$2"

  shift 2
  if $forceFlag || [ ! -f "$target" ] || ! isNewestFile "$target" "$@"; then
    statusMessage consoleInfo "Generating $(basename "$target") ..."
    cat "$@" | sort | uniq -c | grep -e "^[[:space:]]*$# " | awk '{ print $2 }' | tee "$target" >/dev/null
  else
    statusMessage consoleInfo "$(basename "$target") is up to date"
  fi
}

__apkGenerator() {
  __usageEnvironment "$1" alpineContainer --local "$home" "/root/build/bin/build/tools.sh" "packageAvailableList" || return $?
}
__debianGenerator() {
  __usageEnvironment "$1" dockerLocalContainer --local "$home" --image debian:latest --path "/root/build" "/root/build/bin/build/tools.sh" "packageAvailableList" || return $?
}
__ubuntuGenerator() {
  __usageEnvironment "$1" dockerLocalContainer --local "$home" --image ubuntu:latest --path "/root/build" "/root/build/bin/build/tools.sh" "packageAvailableList" || return $?
}
__brewGenerator() {
  __usageEnvironment "$1" "$home/bin/build/tools.sh" "packageAvailableList" || return $?
}
__tools .. __updateAvailable "$@"