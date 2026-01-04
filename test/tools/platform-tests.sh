#!/usr/bin/env bash
#
# platform-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testWhichExists() {
  assertExitCode 0 whichExists ls || return $?
  assertExitCode 0 whichExists cat || return $?
  assertExitCode 0 whichExists ls cat grep awk sed || return $?
  assertExitCode 1 whichExists randombinarywhichusuallyneverexists || return $?
  assertExitCode 1 whichExists randombinarywhichusuallyneverexists ls cat grep awk sed || return $?
  assertExitCode 1 whichExists ls cat grep awk sed randombinarywhichusuallyneverexists || return $?
  assertExitCode 0 whichExists --any ls randombinarywhichusuallyneverexists honestgovernment || return $?
}

testGroupID() {
  BUILD_DEBUG="" assertExitCode --stdout-match "group name to a group ID" 0 groupID --help || return $?
  assertExitCode --stderr-match "Requires a group name" 2 groupID || return $?
  assertExitCode 0 groupID daemon || return $?
}
