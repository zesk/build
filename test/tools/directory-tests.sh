#!/usr/bin/env bash
#
# os-tests.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

__testIsAbsolutePathData() {
  cat <<EOF
/,0
,1
/this,0
/QWERTY/,0
a/a/a/a,1
.,1
..,1
pickle,1
EOF
}

testIsAbsolutePath() {
  local path exitCode

  __testIsAbsolutePathData | while IFS=, read -r path exitCode; do
    assertExitCode --line "$LINENO" "$exitCode" isAbsolutePath "$path" || return $?
  done
}

testRequireFileDirectory() {
  local testDir="temp.$$"

  assertDirectoryDoesNotExist --line "$LINENO" "$testDir" || return $?
  assertExitCode --line "$LINENO" 0 requireFileDirectory "$testDir" || return $?
  assertDirectoryDoesNotExist --line "$LINENO" "$testDir" || return $?

  assertDirectoryDoesNotExist --line "$LINENO" "$testDir" || return $?
  assertExitCode --line "$LINENO" 0 requireFileDirectory "$testDir/place" || return $?
  assertDirectoryExists --line "$LINENO" "$testDir" || return $?

  assertExitCode --line "$LINENO" 0 rm -rf "$testDir" || return $?
}

testFileDirectoryExists() {
  assertExitCode --line "$LINENO" 0 fileDirectoryExists "${BASH_SOURCE[0]}}" || return $?
  assertNotExitCode --line "$LINENO" 0 fileDirectoryExists "${BASH_SOURCE[0]}}/not-a-dir" || return $?
}

testDirectoryRelativePath() {
  while IFS=: read -r test expected; do
    assertEquals --line "$LINENO" "$(directoryRelativePath "$test")" "$expected" || return $?
  done < <(__testDirectoryRelativePathData)
}

__testDirectoryRelativePathData() {
  cat<<'EOF'
:.
abc:
/abc:..
abc/:..
a/b/c:../..
/antidisestablishmentarianism/:../..
///////:../../../../../../..
EOF
}
