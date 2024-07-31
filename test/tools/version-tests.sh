#!/usr/bin/env bash
#
# version-tests.sh
#
# documentation.sh tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests

tests+=(testVersionNext)

testVersionNext() {
  assertEquals "" "$(nextMinorVersion "A" || :)" || return $?
  assertExitCode 2 nextMinorVersion "A" || return $?

  assertEquals "1" "$(nextMinorVersion "0")" || return $?
  assertEquals "1.1" "$(nextMinorVersion "1.0")" || return $?
  assertEquals "A.1" "$(nextMinorVersion "A.0")" || return $?
  assertEquals "1.0.0.0.0.1" "$(nextMinorVersion "1.0.0.0.0.0")" || return $?

  assertEquals "1000000" "$(nextMinorVersion "999999")" || return $?
  assertEquals "1.1000000" "$(nextMinorVersion "1.999999")" || return $?
  assertEquals "A.1000000" "$(nextMinorVersion "A.999999")" || return $?
  assertEquals "1.0.0.0.0.1000000" "$(nextMinorVersion "1.0.0.0.0.999999")" || return $?

  assertEquals "0" "$(nextMinorVersion "-1")" || return $?
  assertEquals "1.0" "$(nextMinorVersion "1.-1")" || return $?
  assertEquals "A.0" "$(nextMinorVersion "A.-1")" || return $?
  assertEquals "1.0.0.0.0.0" "$(nextMinorVersion "1.0.0.0.0.-1")" || return $?

  assertEquals "5318008" "$(nextMinorVersion "5318007")" || return $?
  assertEquals "5318007.5318008" "$(nextMinorVersion "5318007.5318007")" || return $?
  assertEquals "A.5318008" "$(nextMinorVersion "A.5318007")" || return $?
  assertEquals "5318005.5318006.5318007.5318008" "$(nextMinorVersion "5318005.5318006.5318007.5318007")" || return $?
}

__assertPathsEquals() {
  assertEquals --line "$1" "$(simplifyPath "$2")" "$(simplifyPath "$3")" || return $?
}

tests+=(testReleaseNotes)
testReleaseNotes() {
  local home

  home=$(buildHome)
  __assertPathsEquals "$LINENO" "$home/docs/release/1.0.md" "$(releaseNotes "1.0")" || return $?
  export BUILD_RELEASE_NOTES
  BUILD_RELEASE_NOTES=./foo
  __assertPathsEquals "$LINENO" "$home/foo/1.0.md" "$(releaseNotes "1.0")" || return $?
  BUILD_RELEASE_NOTES=./foo/
  __assertPathsEquals "$LINENO" "$home/foo/1.0.md" "$(releaseNotes "1.0")" || return $?
  BUILD_RELEASE_NOTES=/foo/
  __assertPathsEquals "$LINENO" "/foo/1.0.md" "$(releaseNotes "1.0")" || return $?
  BUILD_RELEASE_NOTES=/foo
  __assertPathsEquals "$LINENO" "/foo/1.0.md" "$(releaseNotes "1.0")" || return $?
  unset BUILD_RELEASE_NOTES
  __assertPathsEquals "$LINENO" "$home/docs/release/1.0.md" "$(releaseNotes "1.0")" || return $?
}
