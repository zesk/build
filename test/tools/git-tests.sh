#!/usr/bin/env bash
#
# git-tests.sh
#
# Git tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

gitAddRemotesToSSHKnown() {
  local remoteHost
  local sshKnown=.ssh/known_hosts
  local extension
  # shellcheck source=/dev/null
  source "./bin/build/env/HOME.sh"

  sshKnown="$HOME/$sshKnown"
  requireFileDirectory "$sshKnown" || return $?

  [ -f "$sshKnown" ] || touch "$sshKnown"
  __environment chmod 700 "$HOME/.ssh" || return $?
  __environment chmod 600 "$sshKnown" || return $?

  git remote -v | awk '{ print $2 }' | cut -f 1 -d : | cut -f 2 -d @ | sort -u | while read -r remoteHost; do
    extension="${remoteHost##*.}"
    if [ "$extension" = "$remoteHost" ]; then
      continue
    fi
    __environment sshAddKnownHost "$remoteHost" || return $?
  done
}

testGitVersionList() {
  # if ! gitHasAnyRefs; then
  # gitAddRemotesToSSHKnown || return $?
  # git pull --tags >/dev/null 2>&1 || _environment "Unable to pull git tags ... failed" || return $?
  # fi

  #  echo "PWD: $(pwd)"
  #  echo Version List:
  #  gitVersionList
  #  echo "Count: \"$(gitVersionList | wc -l)\""
  #  echo "CountT: \"$(gitVersionList | wc -l | trimSpace)\""
  #  echo "Count0: \"$(($(gitVersionList | wc -l) + 0))\""
  #  echo "Count1: \"$(($(gitVersionList | wc -l) + 0))\""
  assertGreaterThan $(($(gitVersionList | wc -l | trimSpace) + 0)) 0 || return $?
}

testGitCommitFailures() {
  local tempDirectory

  assertNotExitCode --line "$LINENO" --stderr-ok 0 gitCommit "" || return $?
  tempDirectory="$(mktemp -d)/a/deep/one" || _environment "mktemp" || return $?
  assertNotExitCode --line "$LINENO" --stderr-match "$tempDirectory" 0 gitCommit --home "$tempDirectory" last || return $?
  rm -rf "$tempDirectory" || :
}
