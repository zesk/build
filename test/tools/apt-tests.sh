#!/usr/bin/env bash
#
# apt-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testAptIsInstalled() {
  assertExitCode 0 aptIsInstalled --help || return $?
  if whichExists apt; then
    assertExitCode 0 aptIsInstalled || return $?
  else
    assertExitCode 1 aptIsInstalled || return $?
  fi
}

# Tag: slow
testAptKeyAdd() {
  if aptIsInstalled; then
    assertExitCode 0 aptKeyAddHashicorp || return $?
    assertExitCode 0 aptKeyRemoveHashicorp || return $?
    assertExitCode 0 aptKeyAddOpenTofu || return $?
    assertExitCode 0 aptKeyRemoveOpenTofu || return $?
  fi
}

testAptKeyRingDirectory() {
  if aptIsInstalled; then
    assertExitCode 0 aptKeyRingDirectory || return $?
    assertExitCode 0 aptSourcesDirectory || return $?
    assertDirectoryExists "$(aptKeyRingDirectory)" || return $?
    assertDirectoryExists "$(aptSourcesDirectory)" || return $?
  fi
}

testAptNonInteractive() {
  if aptIsInstalled; then
    assertExitCode 0 aptNonInteractive update || return $?
  fi
}
