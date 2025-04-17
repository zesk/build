#!/usr/bin/env bash
#
# json-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testJSONField() {
  local handler="_return" t

  t=$(fileTemporaryName "$handler") || return $?

  printf -- "%s\n" "{ \"version\": 12345 }" >"$t" || return $?

  assertExitCode --stdout-match 12345 --line "$LINENO" 0 jsonField "$handler" "$t" ".version" || return $?
  assertEquals "12345" "$(jsonField "$handler" "$t" ".version")" || return $?

  __catchEnvironment "$handler" rm -rf "$t" || return $?
}
