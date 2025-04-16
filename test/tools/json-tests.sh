#!/usr/bin/env bash
#
# json-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testJSONField() {
  local handler="_return" t

  t=$(fileTemporaryName "$handler") || return $?
  echo "t=$t"
  printf -- "%s\n" "{ \"version\": 1.0e3 }" >"$t" || return $?
  dumpPipe t <"$t"
  assertExitCode --stdout-match 1000 --line "$LINENO" 0 jsonField "$handler" "$t" .version || return $?
  assertEquals "1000" "$(jsonField "$handler" "$t" .version)" || return $?

  __catchEnvironment "$handler" rm -rf "$t" || return $?
}
