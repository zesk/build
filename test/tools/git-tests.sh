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

tests+=(testGitVersionList)
testGitVersionList() {
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
  if ! git pull --tags >/dev/null 2>/dev/null; then
    consoleError "Unable to pull git tags ... failed" 1>&2
    return "$errorEnvironment"
  fi
  echo "PWD: $(pwd)"
  echo Version List:
  gitVersionList
  echo "Count: \"$(gitVersionList | wc -l)\""
  echo "CountT: \"$(gitVersionList | wc -l | trimSpacePipe)\""
  echo "Count0: \"$(($(gitVersionList | wc -l) + 0))\""
  echo "Count1: \"$(($(gitVersionList | wc -l) + 0))\""
  assertGreaterThan $(($(gitVersionList | wc -l | trimSpacePipe) + 0)) 0
}
