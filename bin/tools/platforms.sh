#!/usr/bin/env bash
#
# Different OS (platforms) tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

buildTestPlatforms() {
  local handler="_${FUNCNAME[0]}"

  local testHome
  testHome="$(__catch "$handler" buildHome)" || return $?

  local platforms="$testHome/etc/platform.txt"
  [ -f "$platforms" ] || __throwArgument "$handler" "Missing test directory" || return $?

  __buildTestRequirements "$handler" || return $?

  local image exitCode=0
  while read -r image; do
    bigText "Test: $image" | decorate success
    if ! __echo dockerLocalContainer --local "$testHome" --path "/var/buildTest" --verbose --handler "$handler" --image "$image" "/var/buildTest/bin/test.sh" "$@"; then
      exitCode=1
      decorate error "$image failed"
    fi
  done <"$platforms"
  return $exitCode
}
_buildTestPlatforms() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
