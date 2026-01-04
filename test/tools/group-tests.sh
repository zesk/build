#!/usr/bin/env bash
#
# group tests
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testGroupID() {
  assertExitCode 0 groupID daemon || return $?
  assertExitCode 0 isInteger "$(groupID daemon)" || return $?

  assertExitCode 0 groupID wheel || return $?
  assertEquals --display "groupID wheel" 0 "$(groupID wheel)" || return $?
}
