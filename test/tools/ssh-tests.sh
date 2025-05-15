#!/usr/bin/env bash
#
# ssh-tests.sh
#
# SSH tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testSSHAddKnownHosts() {
  local tempHome
  local sampleDomainA sampleDomainB

  __mockValue HOME

  export HOME

  tempHome="$(mktemp -d)" || return $?

  HOME="$tempHome"

  sampleDomainA=github.com
  sampleDomainB=bitbucket.org

  assertDirectoryDoesNotExist "$tempHome/.ssh" || return $?

  assertExitCode 0 sshKnownHostAdd || return $?

  assertDirectoryExists "$tempHome/.ssh" || return $?
  assertFileExists "$tempHome/.ssh/known_hosts" || return $?
  assertFileDoesNotContain "$tempHome/.ssh/known_hosts" $sampleDomainA || return $?
  assertFileDoesNotContain "$tempHome/.ssh/known_hosts" $sampleDomainB || return $?

  assertExitCode 0 sshKnownHostAdd "$sampleDomainA" || return $?
  assertFileContains "$tempHome/.ssh/known_hosts" $sampleDomainA || return $?
  assertFileDoesNotContain "$tempHome/.ssh/known_hosts" $sampleDomainB || return $?

  assertExitCode 0 sshKnownHostAdd "$sampleDomainB" || return $?
  assertFileContains "$tempHome/.ssh/known_hosts" $sampleDomainA || return $?
  assertFileContains "$tempHome/.ssh/known_hosts" $sampleDomainB || return $?

  __mockValue HOME "" --end

  return 0
}

testSSHRemoveKnownHosts() {
  local tempHome debugFlag=false
  local sampleDomainA sampleDomainB sampleDomainC

  __mockValue HOME

  export HOME

  tempHome="$(mktemp -d)" || return $?

  HOME="$tempHome"

  sampleDomainA=github.com
  sampleDomainB=bitbucket.org
  sampleDomainC=marketacumen.com

  authFile=$(sshKnownHostsFile) || return $?

  assertDirectoryDoesNotExist "$tempHome/.ssh" || return $?

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

  __mockValue HOME "" --end

  return 0

}
