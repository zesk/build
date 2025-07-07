#!/usr/bin/env bash
#
# network-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testNetworkIPList() {
  assertExitCode --stdout-match "127.0.0.1" 0 networkIPList --install || return $?
}

testNetworkMACAddressList() {
  local usage="_return"
  local temp

  temp="$(fileTemporaryName "$usage")" || return $?

  __catchEnvironment "$usage" networkMACAddressList >"$temp" || return $?

  # Assert 1 < 2
  assertLessThanOrEqual 1 "$(fileLineCount "$temp")" || return $?
  assertFileContains "$temp" ":" || return $?

  dumpPipe "MAC addresses" <"$temp"
  rm -f "$temp" || return $?
}
