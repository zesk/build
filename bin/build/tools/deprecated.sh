#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Graveyard for code
#
# You should stop using these. Soon. Now. Yesterday.
#
# This file should be ignored by the other deprecated.sh
#

# Not keeping this around will break old scripts, so don't be a ...
# Deprecated: 2025-01-15
runHook() {
  hookRun "$@"
}

# Not keeping this around will break old scripts, so don't be a ...
# Deprecated: 2025-01-15
runHookOptional() {
  hookRunOptional "$@"
}

# Deprecated: 2024
consoleReset() {
  if hasColors; then
    printf "\e[0m"
  fi
}

# Deprecated: 2024
consoleBlackBackground() {
  __consoleEscape '\033[48;5;0m' '\033[0m' "$@"
}

# list of ignore flags for `find`
__deprecatedIgnore() {
  printf -- "%s\n" "!" -name 'deprecated.txt' "!" -name 'deprecated.sh' "!" -name 'deprecated.md' "!" -path '*/docs/release/*' ! -path "*/.*/*"
}

# Find files which match a token
__deprecatedFind() {
  local ignoreStuff=()
  read -d '' -r -a ignoreStuff < <(__deprecatedIgnore) || [ "${#ignoreStuff[@]}" -gt 0 ] || _environment "__deprecatedIgnore empty?" || return $?
  while [ "$#" -gt 0 ]; do
    if find . -type f -name '*.sh' "${ignoreStuff[@]}" -print0 | xargs -0 grep -q "$1"; then
      return 0
    fi
    shift
  done
  return 1
}

# Usage: {fn} search replace [ additionalCannonArgs ]
__deprecatedCannon() {
  local from="$1" to="$2" ignoreStuff=()
  shift 2
  read -d '' -r -a ignoreStuff < <(__deprecatedIgnore) || [ "${#ignoreStuff[@]}" -gt 0 ] || _environment "__deprecatedIgnore empty?" || return $?
  statusMessage printf "%s %s \n" "$(decorate warning "$from")" "$(decorate success "$to")"
  # ignore should go at the end so it has priority over previous entries
  cannon "$from" "$to" "$@" "${ignoreStuff[@]}"
}

__deprecatedTokens() {
  local ignoreStuff exitCode=0 start results
  read -d '' -r -a ignoreStuff < <(__deprecatedIgnore) || :
  results=$(__environment mktemp) || return $?
  start=$(__environment beginTiming) || return $?
  for deprecatedToken in "$@"; do
    statusMessage decorate info "Looking for deprecated token $(decorate code "$deprecatedToken") ..."
    if find . -type f "${ignoreStuff[@]+"${ignoreStuff[@]}"}" -print0 | xargs -0 grep -l -e "$deprecatedToken" >"$results"; then
      statusMessage --last decorate error "DEPRECATED token $(decorate code "$deprecatedToken") found"
      wrapLines "$(decorate code)" "$(decorate reset)" <"$results" || _clean $? "$results" || return $?
      exitCode=1
    fi
  done
  __environment rm -rf "$results" || return $?
  statusMessage --last reportTiming "$start" "Deprecated token scan took"
  return "$exitCode"
}
