#!/usr/bin/env bash
#
# os-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# TODO
#  directoryClobber
#  directoryIsEmpty
#  directoryNewestFile
#  directoryOldestFile
#  directoryParent

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
    assertExitCode "$exitCode" pathIsAbsolute "$path" || return $?
  done
}

testRequireFileDirectory() {
  local testDir="temp.$$"

  assertDirectoryDoesNotExist --line "$LINENO" "$testDir" || return $?
  assertExitCode 0 fileDirectoryRequire "$testDir" || return $?
  assertDirectoryDoesNotExist --line "$LINENO" "$testDir" || return $?

  assertDirectoryDoesNotExist --line "$LINENO" "$testDir" || return $?
  assertExitCode 0 fileDirectoryRequire "$testDir/place" || return $?
  assertDirectoryExists --line "$LINENO" "$testDir" || return $?

  assertExitCode 0 fileDirectoryRequire --mode 0700 "$testDir/place" || return $?
  assertDirectoryExists --line "$LINENO" "$testDir" || return $?
  assertOutputContains "drwx------" ls -lad "$testDir/" || return $?

  assertExitCode 0 fileDirectoryRequire --mode 0750 "$testDir/place" || return $?
  assertOutputContains "drwxr-x---" ls -lad "$testDir/" || return $?

  assertExitCode 0 fileDirectoryRequire --mode 0707 "$testDir/place" || return $?
  assertOutputContains "drwx---rwx" ls -lad "$testDir/" || return $?

  assertExitCode 0 rm -rf "$testDir" || return $?
}

testFileDirectoryExists() {
  assertExitCode 0 fileDirectoryExists "${BASH_SOURCE[0]}}" || return $?
  assertNotExitCode 0 fileDirectoryExists "${BASH_SOURCE[0]}}/not-a-dir" || return $?
}

testDirectoryRelativePath() {
  local test expected
  while IFS=: read -r test expected; do
    assertEquals "$(directoryRelativePath "$test")" "$expected" || return $?
  done < <(__testDirectoryRelativePathData)
}

__testDirectoryRelativePathData() {
  cat <<'EOF'
:.
abc:
/abc:..
abc/:..
a/b/c:../..
/antidisestablishmentarianism/:../..
///////:../../../../../../..
EOF
}
