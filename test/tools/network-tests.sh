#!/usr/bin/env bash
#
# network-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Plumber: false
testNetworkIPList() {
  assertExitCode --leak OSTYPE --stdout-match "127.0.0.1" 0 networkIPList --install || return $?
}

# Leaks OSTYPE
# Plumber: false
testNetworkMACAddressList() {
  local handler="_return"
  local temp

  temp="$(fileTemporaryName "$handler")" || return $?

  __catchEnvironment "$handler" networkMACAddressList >"$temp" || return $?

  # Assert 1 < 2
  assertLessThanOrEqual 1 "$(fileLineCount "$temp")" || return $?
  assertFileContains "$temp" ":" || return $?

  dumpPipe "MAC addresses" <"$temp"
  rm -f "$temp" || return $?
}
