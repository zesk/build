#!/usr/bin/env bash
#
# git-tests.sh
#
# Git tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
declare -a tests

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
  __environment chmod 700 "$HOME/.ssh" || return $?
  __environment chmod 600 "$sshKnown" || return $?

  git remote -v | awk '{ print $2 }' | cut -f 1 -d : | cut -f 2 -d @ | sort -u | while read -r remoteHost; do
    if grep -q "$remoteHost" "$sshKnown"; then
      consoleInfo "Host $remoteHost already known"
    elif ssh-keyscan "$remoteHost" >"$sshKnown"; then
      printf "%s %s %s %s\n" "$(consoleSuccess "Added")" "$(consoleInfo "$remoteHost")" "$(consoleSuccess "to")" "$(consoleCode "$sshKnown")"
    else
      _environment "$(printf "%s %s %s %s\n" "$(consoleError "Failed to add")" "$(consoleInfo "$remoteHost")" "$(consoleError "to")" "$(consoleCode "$sshKnown")")" || return $?
    fi
  done
}

tests+=(testGitVersionList)
testGitVersionList() {

  if ! gitHasAnyRefs; then
    gitAddRemotesToSSHKnown || return $?
    git pull --tags >/dev/null 1>&2 || _environment "Unable to pull git tags ... failed" || return $?
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

tests+=(testGitCommitFailures)
testGitCommitFailures() {
  local here tempDirectory

  assertExitCode --stderr-ok 2 gitCommit "" || return $?
  assertExitCode --stderr-ok 1 gitCommit || return $?
  here=$(pwd) || _environment pwd || return $?
  tempDirectory=$(mktemp -d) || _environment "mktemp" || return $?
  __environment cd "$tempDirectory" || return $?
  __environment rm -rf "$tempDirectory" || return $?
  assertExitCode --stderr-match "pwd" 1 gitCommit last || return $?
  __environment cd "$here" || return $?
  # assertExitCode --stderr-match "No changes" 1 gitCommit last || return $?
  # assertExitCode --stderr-match 'Author identity unknown' 1 gitCommit last || return $?
  assertExitCode --stderr-ok 1 gitCommit last || return $?
  consoleInfo gitCommit last output:
  gitCommit last 2>&1 | wrapLines "$(consoleCode)" "$(consoleReset)" || :
  #
  consoleSuccess "Need output from pipeline"

  #
  # Output of last command in local container:
  #
  #    Author identity unknown
  #
  #    *** Please tell me who you are.
  #
  #    Run
  #
  #      git config --global user.email "you@example.com"
  #      git config --global user.name "Your Name"
  #
  #    to set your account's default identity.
}
