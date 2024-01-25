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
