#!/usr/bin/env bash
#
# platform-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testWhichExists() {
  assertExitCode 0 executableExists ls || return $?
  assertExitCode 0 executableExists cat || return $?
  assertExitCode 0 executableExists ls cat grep awk sed || return $?
  assertExitCode 1 executableExists randombinarywhichusuallyneverexists || return $?
  assertExitCode 1 executableExists randombinarywhichusuallyneverexists ls cat grep awk sed || return $?
  assertExitCode 1 executableExists ls cat grep awk sed randombinarywhichusuallyneverexists || return $?
  assertExitCode 0 executableExists --any ls randombinarywhichusuallyneverexists honestgovernment || return $?
}

testGroupID() {
  BUILD_DEBUG="" assertExitCode --stdout-match "group name to a group ID" 0 groupID --help || return $?
  assertExitCode --stderr-match "Requires a group name" 2 groupID || return $?
  assertExitCode 0 groupID daemon || return $?
}

# Nice.
testPathShow() {
  assertExitCode 0 pathShow || return $?
}
