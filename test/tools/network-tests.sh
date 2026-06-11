#!/usr/bin/env bash
#
# network-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Test-Plumber: false
testNetworkIPList() {
  assertExitCode --leak __BUILD_LOADER --leak OSTYPE --stdout-match "127.0.0.1" 0 networkIPList --install || return $?
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

__dataNetworkNameValid() {
  cat <<'EOF'
0 yes
1 [n@o] invalid characters
0 marketacumen.com
1 antidisestablishmentarianism-antidisestablishmentarianism-antidisestablishmentarianism.com greater than 63
1 @ invalid characters
1 this-would-totally-work-if-it-did-not-have–mdash-hidden invalid characters
0 localhost
0 127.0.0.1
0 [2111:db8:85a3:8d3:1319:8a2e:370:7348]
0 fe80::1ff:fe23:4567:890a%3
0 fe80::1ff:fe23:4567:890a%eth2
EOF
}

testNetworkNameValid() {
  local expected networkName errorString && while read -r expected networkName errorString; do
    local ee=()
    [ -z "$errorString" ] || ee+=(--stderr-match "$errorString")
    statusMessage decorate info "networkNameValid $networkName -> $expected [$errorString]"
    assertExitCode "${ee[@]+"${ee[@]}"}" "$expected" networkNameValid "$networkName" || return $?
  done < <(__dataNetworkNameValid)
}

__dataNetworkIPValid() {
  cat <<'EOF'
1 yes IP syntax
1 [n@o] IP syntax
1 marketacumen.com IP syntax
1 antidisestablishmentarianism-antidisestablishmentarianism-antidisestablishmentarianism.com IP syntax
1 @ IP syntax
1 this-would-totally-work-if-it-did-not-have–mdash-hidden IP syntax
1 localhost IP syntax
0 127.0.0.1
1 [2111:db8:85a3:8d3:1319:8a2e:370:7348] invalid IP6 segment
0 fe80::1ff:fe23:4567:890a%3
0 fe80::1ff:fe23:4567:890a%eth2
0 ::1
1 :1 invalid IP6
EOF
}

testNetworkIPValid() {
  local expected ipSample errorString && while read -r expected ipSample errorString; do
    local ee=()
    [ -z "$errorString" ] || ee+=(--stderr-match "$errorString")
    statusMessage decorate info "networkIPValid $ipSample -> $expected [$errorString]"
    assertExitCode "${ee[@]+"${ee[@]}"}" "$expected" networkIPValid "$ipSample" || return $?
  done < <(__dataNetworkIPValid)
}
