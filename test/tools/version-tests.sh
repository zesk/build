#!/usr/bin/env bash
#
# version-tests.sh
#
# documentation.sh tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

___testIsVersionData() {
  cat <<EOF
  0 0
  0 1.0
  0 1.1
  0 1.2.3
  0 1.2.3.4.5.6.7.8.8.10000.2.4
  1 -1
  1 -1.0
  1 ab.0
  1 v1.2.3
  1 dude
  1 1.0.1.a
EOF
}

testNewRelease() {
  assertExitCode 0 newRelease --non-interactive || return $?
}

testIsVersion() {
  ___testIsVersionData | while read -r exitCode versionSample; do
    assertExitCode "$exitCode" isVersion "$versionSample" || return $?
  done
}

testReleaseNotesSimple() {
  assertExitCode --leak BUILD_RELEASE_NOTES --stdout-match "documentation/source/release" 0 releaseNotes || return $?
  unset BUILD_RELEASE_NOTES
}

testVersionNext() {
  assertNotExitCode --stderr-match isInteger 0 nextMinorVersion A || return $?
  assertEquals "" "$(nextMinorVersion "A" 2>/dev/null || :)" || return $?
  assertExitCode --stderr-match isInteger 2 nextMinorVersion "A" || return $?

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

testReleaseNotes() {
  local home

  home=$(buildHome)

  # BUILD DOCS DEFAULT PATH
  __assertPathsEquals "$LINENO" "$home/documentation/source/release/1.0.md" "$(releaseNotes "1.0")" || return $?
  export BUILD_RELEASE_NOTES

  BUILD_RELEASE_NOTES=./foo
  __assertPathsEquals "$LINENO" "$home/documentation/source/release/1.0.md" "$(releaseNotes "1.0")" || return $?

  BUILD_RELEASE_NOTES=./foo/
  __assertPathsEquals "$LINENO" "$home/documentation/source/release/1.0.md" "$(releaseNotes "1.0")" || return $?

  BUILD_RELEASE_NOTES=/foo/
  __assertPathsEquals "$LINENO" "$home/documentation/source/release/1.0.md" "$(releaseNotes "1.0")" || return $?

  BUILD_RELEASE_NOTES=/foo
  __assertPathsEquals "$LINENO" "$home/documentation/source/release/1.0.md" "$(releaseNotes "1.0")" || return $?

  unset BUILD_RELEASE_NOTES
  # BUILD DOCS DEFAULT PATH
  __assertPathsEquals "$LINENO" "$home/documentation/source/release/1.0.md" "$(releaseNotes "1.0")" || return $?

}
