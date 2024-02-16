#!/usr/bin/env bash
#
# git-tests.sh
#
# Git tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
declare -a tests

errorEnvironment=1

gitHasAnyRefs() {
  if [ $((0 + $(git show-ref | grep -c refs/tags))) -gt 0 ]; then
    return 0
  fi
  return 1
}

gitAddRemotesToSSHKnown() {
  local remoteHost
  local sshKnown=.ssh/known_hosts

  # shellcheck source=/dev/null
  source "./bin/build/env/HOME.sh"

  sshKnown="$HOME/$sshKnown"
  requireFileDirectory "$sshKnown" || return $?

  [ -f "$sshKnown" ] || touch "$sshKnown"

  git remote -v | awk '{ print $2 }' | cut -f 1 -d : | cut -f 2 -d @ | sort -u | while read -r remoteHost; do
    if grep -q "$remoteHost" "$sshKnown"; then
      consoleInfo "Host $remoteHost already known"
    elif ! ssh-keyscan "$remoteHost" >"$sshKnown"; then
      consoleError "Failed to add $remoteHost to $sshKnown" 1>&2
      return "$errorEnvironment"
    else
      consoleSuccess "Added $remoteHost to $sshKnown" 1>&2
    fi
  done
  chmod 700 "$HOME/.ssh" || return $?
  chmod 600 "$sshKnown" || return $?
}

tests+=(testGitVersionList)
testGitVersionList() {

  if ! gitHasAnyRefs; then
    if ! gitAddRemotesToSSHKnown; then
      return "$errorEnvironment"
    fi
    if ! git pull --tags >/dev/null 2>/dev/null; then
      consoleError "Unable to pull git tags ... failed" 1>&2
      return "$errorEnvironment"
    fi
  fi

  #  echo "PWD: $(pwd)"
  #  echo Version List:
  #  gitVersionList
  #  echo "Count: \"$(gitVersionList | wc -l)\""
  #  echo "CountT: \"$(gitVersionList | wc -l | trimSpacePipe)\""
  #  echo "Count0: \"$(($(gitVersionList | wc -l) + 0))\""
  #  echo "Count1: \"$(($(gitVersionList | wc -l) + 0))\""
  assertGreaterThan $(($(gitVersionList | wc -l | trimSpacePipe) + 0)) 0 || return $?
}

tests+=(testGitCommit)
testGitCommit() {
  assertExitCode --stderr-ok 2 gitCommit || return $?
}
