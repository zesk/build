#!/usr/bin/env bash
#
# network-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Test-Plumber: false
testNetworkIPList() {
  assertExitCode --leak OSTYPE --stdout-match "127.0.0.1" 0 networkIPList --install || return $?
}

# Leaks OSTYPE
# Test-Plumber: false
testNetworkMACAddressList() {
  local handler="returnMessage"
  local temp

  temp="$(fileTemporaryName "$handler")" || return $?

  catchEnvironment "$handler" networkMACAddressList >"$temp" || return $?

  # Assert 1 < 2
  assertLessThanOrEqual 1 "$(fileLineCount "$temp")" || return $?
  assertFileContains "$temp" ":" || return $?

  dumpPipe "MAC addresses" <"$temp"
  rm -f "$temp" || return $?
}
