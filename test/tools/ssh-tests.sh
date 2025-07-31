#!/usr/bin/env bash
#
# ssh-tests.sh
#
# SSH tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testSSHAddKnownHosts() {
  local handler="_return"
  local tempHome
  local sampleDomainA sampleDomainB

  __mockValue HOME

  export HOME

  tempHome="$(fileTemporaryName "$handler" -d)" || return $?

  HOME="$tempHome"

  sampleDomainA=github.com
  sampleDomainB=bitbucket.org

  assertDirectoryDoesNotExist "$tempHome/.ssh" || return $?

  assertExitCode --stderr-match "Need at least one host" 2 sshKnownHostAdd || return $?

  assertDirectoryDoesNotExist "$tempHome/.ssh" || return $?

  assertExitCode 0 sshKnownHostAdd "$sampleDomainA" || return $?

  assertDirectoryExists "$tempHome/.ssh" || return $?
  assertFileExists "$tempHome/.ssh/known_hosts" || return $?

  assertFileContains "$tempHome/.ssh/known_hosts" "$sampleDomainA" || return $?
  assertFileDoesNotContain "$tempHome/.ssh/known_hosts" "$sampleDomainB" || return $?

  assertExitCode 0 sshKnownHostAdd "$sampleDomainB" || return $?
  assertFileContains "$tempHome/.ssh/known_hosts" "$sampleDomainA" || return $?
  assertFileContains "$tempHome/.ssh/known_hosts" "$sampleDomainB" || return $?

  __catch "$handler" rm -rf "$tempHome" || return $?

  __mockValueStop HOME

  return 0
}

testSSHRemoveKnownHosts() {
  local handler="_return"
  local tempHome debugFlag=false
  local sampleDomainA sampleDomainB sampleDomainC

  __mockValue HOME

  export HOME

  tempHome="$(fileTemporaryName "$handler" -d)" || return $?

  HOME="$tempHome"

  sampleDomainA=github.com
  sampleDomainB=bitbucket.org
  sampleDomainC=marketacumen.com

  authFile=$(sshKnownHostsFile) || return $?

  assertDirectoryDoesNotExist "$tempHome/.ssh" || return $?

  assertExitCode --stderr-match "Need at least one host" 2 sshKnownHostRemove || return $?

  assertExitCode 0 sshKnownHostAdd "$sampleDomainA" "$sampleDomainB" "$sampleDomainC" || return $?
  ! $debugFlag || dumpPipe "Added ALL domains" <"$authFile"

  assertDirectoryExists "$tempHome/.ssh" || return $?
  assertFileExists "$authFile" || return $?
  assertFileContains "$authFile" "$sampleDomainA" "$sampleDomainB" "$sampleDomainC" || return $?

  assertExitCode 0 sshKnownHostRemove "$sampleDomainB" || return $?
  ! $debugFlag || dumpPipe "Removed $sampleDomainB" <"$authFile"

  assertFileContains "$authFile" "$sampleDomainA" "$sampleDomainC" || return $?
  assertFileDoesNotContain "$authFile" "$sampleDomainB" || return $?

  assertExitCode 0 sshKnownHostRemove "$sampleDomainA" || return $?
  ! $debugFlag || dumpPipe "Removed $sampleDomainA" <"$authFile"
  assertFileContains "$authFile" "$sampleDomainC" || return $?
  assertFileDoesNotContain "$authFile" "$sampleDomainA" "$sampleDomainB" || return $?

  assertExitCode 0 sshKnownHostRemove "$sampleDomainC" || return $?
  ! $debugFlag || dumpPipe "Removed $sampleDomainC" <"$authFile"
  assertFileDoesNotContain "$authFile" "$sampleDomainA" "$sampleDomainB" "$sampleDomainC" || return $?

  __mockValueStop HOME

  __catch "$handler" rm -rf "$tempHome" || return $?

  return 0

}
