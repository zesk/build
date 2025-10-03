#!/usr/bin/env bash
#
# json-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testJSONField() {
  local handler="returnMessage" target

  target=$(fileTemporaryName "$handler") || return $?

  printf -- "%s\n" "{ \"version\": 12345 }" >"$target" || return $?

  assertExitCode --stdout-match 12345 0 jsonField "$handler" "$target" ".version" || return $?
  assertEquals "12345" "$(jsonField "$handler" "$target" ".version")" || return $?

  __catchEnvironment "$handler" rm -rf "$target" || return $?
}

__testJSONSetValue() {
  printf "%s\n" "3.2.$(incrementor jsonSetValueTest)"
}

testJSONSetValue() {
  local handler="returnMessage" tempDir target

  tempDir=$(fileTemporaryName "$handler" -d) || return $?

  __catchEnvironment "$handler" muzzle incrementor 0 jsonSetValueTest || return $?

  target="$tempDir/file.json"

  local runner=(housekeeper --path "$tempDir" --ignore 'file.json$')

  __catchEnvironment "$handler" printf -- "%s\n" "{}" >"$target" || return $?

  assertExitCode --stdout-match 3.2.1 --stdout-match "updated" 0 "${runner[@]}" jsonSetValue --generator __testJSONSetValue "$target" || return $?
  assertFileContains "$target" "3.2.1" "version" || return $?

  assertExitCode --stdout-match 3.2.2 --stdout-match "updated" 0 "${runner[@]}" jsonSetValue --key version --generator __testJSONSetValue "$target" || return $?
  assertFileContains "$target" "3.2.2" "version" || return $?

  __catchEnvironment "$handler" muzzle incrementor 1 jsonSetValueTest || return $?

  assertExitCode --stdout-match 3.2.2 --stdout-match "up to date" 0 "${runner[@]}" jsonSetValue --generator __testJSONSetValue --key version "$target" || return $?
  assertFileContains "$target" "3.2.2" "version" || return $?

  assertExitCode --stdout-match 54321 --stdout-match "updated" 0 "${runner[@]}" jsonSetValue --key "gatekeeper" --value "54321" "$target" || return $?
  assertFileContains "$target" "3.2.2" "version" "54321" "gatekeeper" || return $?

  assertExitCode --stdout-match 54321 --stdout-match "up to date" 0 "${runner[@]}" jsonSetValue --key "gatekeeper" --value "54321" "$target" || return $?
  assertFileContains "$target" "3.2.2" "version" "54321" "gatekeeper" || return $?

  assertExitCode --stdout-match 54321 --stdout-match "up to date" "$(returnCode identical)" "${runner[@]}" jsonSetValue --status --key "gatekeeper" --value "54321" "$target" || return $?
  assertFileContains "$target" "3.2.2" "version" "54321" "gatekeeper" || return $?

  __catchEnvironment "$handler" rm -rf "$tempDir" || return $?

}
