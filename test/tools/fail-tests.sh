#!/usr/bin/env bash
#
# fail-tests.sh
#
# Fail tests - tests which are designed to fail
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__leakyThing() {
  export DOGMA=1000
  declare -x DOGMA
  declare -x dogma
  export dogma=1000
  decorate notice "My karma ran over my dogma."
}

# Test-Plumber: true
# Test-Fail: true
testHasPlumberLeaks() {
  __leakyThing || return $?
}

# Test-Housekeeper: true
testHasHousekeeperLeaks() {
  local handler="returnMessage"
  local dogma
  dogma=$(fileTemporaryName "$handler") || return $?
  false || catchEnvironment "$handler" rm -rf "$dogma" || return $?
}

# Test-Build-Home: true
testBuildHomeFlag() {
  assertEquals "$(pwd)" "$(buildHome)" || return $?
}

# Test-Build-Home: false
testBuildHomeFlagNot() {
  assertNotEquals "$(pwd)" "$(buildHome)" || return $?
}

# Test-Housekeeper: false
# Test-Plumber: false
testHasLeaks() {
  local handler="returnMessage"
  dogma=$(fileTemporaryName "$handler") || return $?
}
