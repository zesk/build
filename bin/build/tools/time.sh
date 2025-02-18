#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/time.md
# Test: ./test/tools/time-tests.sh

#
# Summary: Start a timer
#
# Outputs the offset in milliseconds from January 1, 1970.
#
# Usage: timingStart
# Example:     init=$(timingStart)
# Example:     ...
# Example:     timingReport "$init" "Completed in"
# Requires: __timestamp, _environment
timingStart() {
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$usage" "$@" || return 0
  __timestamp 2>/dev/null || __throwEnvironment "$usage" __timestamp || return $?
}
_timingStart() {
  ! false || timingStart --help
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Format a timout output (milliseconds) as seconds using a decimal
timingFormat() {
  local usage="_${FUNCNAME[0]}"
  while [ $# -gt 0 ]; do
    local delta="$1" seconds remainder text
    isUnsignedInteger "$delta" || __throwArgument "$usage" "Not an integer: \"$delta\"" || return $?
    seconds=$((delta / 1000))
    remainder=$((delta % 1000))
    text=$(printf -- "%d.%03d\n" "$seconds" "$remainder")
    # Lazy but works
    text=${text%0} && text=${text%0} && text=${text%0} && text=${text%.}
    printf "%s\n" "$text"
    shift
  done
}
_timingFormat() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Outputs the timing in magenta optionally prefixed by a message in green
#
# Usage: timingReport "$startTime" outputText...
# Summary: Output the time elapsed
# Outputs a nice colorful message showing the number of seconds elapsed as well as your custom message.
# Usage: timingReport start [ message ... ]
# Argument: start - Unix timestamp seconds of start timestamp
# Argument: message - Any additional arguments are output before the elapsed value computed
# Exit code: 0 - Exits with exit code zero
# Example:    init=$(timingStart)
# Example:    ...
# Example:    timingReport "$init" "Deploy completed in"
timingReport() {
  local usage="_${FUNCNAME[0]}"

  local start="${1-}"
  isInteger "$start" || __throwArgument "$usage" "Not an integer: \"$start\"" || return $?
  shift
  local prefix=
  if [ $# -gt 0 ]; then
    prefix="$(decorate green "$@") "
  fi
  local delta value seconds
  delta=$(($(timingStart) - start)) || return $?
  value=$(timingFormat "$delta") || return $?
  seconds=2
  [ "$value" != "1.000" ] || seconds=1
  printf "%s%s\n" "$prefix" "$(decorate bold-magenta "$value $(plural "$seconds" second seconds)")"
}
_timingReport() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
