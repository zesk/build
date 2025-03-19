#!/usr/bin/env bash
#
# json-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testJSONField() {
  local handler="_return" t

  t=$(fileTemporaryName "$handler") || return $?
  printf -- "{ \"version\": 1.0 }" >"$t" || return $?
  assertEquals "1.0" "$(jsonField "$handler" "$t" .version)" || return $?

  __catchEnvironment "$handler" rm -rf "$t" || return $?
}
