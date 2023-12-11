#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: colors.sh
# bin: git
#
# Docs: contextOpen ./docs/templates/tools/git.sh.md
#

# IDENTICAL errorArgument 1
errorArgument=2

###############################################################################
#
#            ██
#            ▀▀       ██
#   ▄███▄██   ████     ███████
#  ██▀  ▀██     ██       ██
#  ██    ██     ██       ██
#  ▀██▄▄███  ▄▄▄██▄▄▄    ██▄▄▄
#   ▄▀▀▀ ██  ▀▀▀▀▀▀▀▀     ▀▀▀▀
#   ▀████▀▀
#
#------------------------------------------------------------------------------

#
# Installs the `git` binary
# Usage: gitInstall [ package ... ]
# Argument: package - Additional packages to install
# Summary: Install git if needed
#
gitInstall() {
  whichApt git git "%@"
}

#
# Given a tag in the form "1.1.3" convert it to "v1.1.3" so it has a character prefix "v"
# Delete the old tag as well
#
veeGitTag() {
  local t="$1"

  if [ "$t" != "${t##v}" ]; then
    consoleError "Tag is already veed: $t" 1>&2
    return 1
  fi
  git tag "v$t" "$t"
  git tag -d "$t"
  git push origin "v$t" ":$t"
  git fetch -q --prune --prune-tags
}

#
# Has a lot of caveats
#
# gitRemoveFileFromHistory path/to/file
#
# usually have to `git push --force`
#
gitRemoveFileFromHistory() {
  git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch $1" HEAD
}

#
# When running git operations on a deployment host, at times it's necessary to
# add the current directory (or a directory) to the git `safe.directory` directive.
#
# This adds the directory passed to that directory in the local user's environment
#
# Usage: gitEnsureSafeDirectory [ directory ... ]
# Argument: directory - The directory to add to the `git` `safe.directory` configuration directive
# Exit Code: 0 - Success
# Exit Code: 2 - Argument is not a valid directory
# Exit Code: Other - git config error codes
#
gitEnsureSafeDirectory() {
  while [ $# -gt 0 ]; do
    if [ ! -d "$1" ]; then
      consoleError "$1 is not a directory"
      return "$errorArgument"
    fi
    if ! git config --global --get safe.directory | grep -q "$1"; then
      git config --global --add safe.directory "$1"
    fi
    shift
  done
}

#
# Delete git tag locally and at origin
#
# Usage: gitTagDelete [ tag ... ]
# Argument: tag - The tag to delete locally and remote
# Exit Code: 2 - Any stage fails will result in this exit code. Partial deletion may occur.
#
gitTagDelete() {
  local exitCode=0

  while [ $# -gt 0 ]; do
    if ! git tag -d "$1"; then
      printf "%s %s" "$(consoleError "Error deleting local tag")" "$(consoleCode "$1")" 1>&2
      exitCode=$errorArgument
    elif ! git push origin :"$1"; then
      printf "%s %s" "$(consoleError "Error deleting remote tag")" "$(consoleCode "$1")" 1>&2
      exitCode=$errorArgument
    fi
    shift
  done
  return "$exitCode"
}

#
# Remove a tag everywhere and tag again on the current branch
#
# Usage: gitTagDelete [ tag ... ]
# Argument: tag - The tag to delete locally and remote
# Exit Code: 2 - Any stage fails will result in this exit code. Partial deletion may occur.
#
gitTagAgain() {
  gitTagDelete "$1" || :
  if ! git tag "$1"; then
    printf "%s %s" "$(consoleError "Unable to tag")" "$(consoleCode "$1")" 1>&2
    return $errorArgument
  fi
  if ! git push --tags; then
    printf "%s %s %s" "$(consoleError "Unable to push")" "$(consoleCode "$1")" "$(consoleError "to remote")" 1>&2
    return $errorArgument
  fi
}
