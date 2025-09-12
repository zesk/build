#!/usr/bin/env bash
#
# platform-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
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
