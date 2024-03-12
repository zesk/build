#!/usr/bin/env bash
#
# git tools, lame attempts have been made to have each function start with `git`.
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh
# bin: git
#
# Docs: contextOpen ./docs/_templates/tools/ssh.md
# Test: contextOpen ./test/bin/ssh-tests.sh

# IDENTICAL errorEnvironment 1
errorEnvironment=1

#
#
# Adds the host to the `~/.known_hosts` if it is not found in it already
#
# Side effects:
# 1. `~/.ssh` may be created if it does not exist
# 1. `~/.ssh` mode is set to `0700` (read/write/execute user)
# 1. `~/.ssh/known_hosts` is created if it does not exist
# 1. `~/.ssh/known_hosts` mode is set to `0600` (read/write user)
# 1. ~./.ssh/known_hosts` is possibly modified (appended)
#
# If this function fails then ~/.ssh/known_hosts may be modified for any hosts which did not fail
#
# Exit Code: 1 - Environment errors
# Exit Code: 0 - All hosts exist in or were successfully added to the known hosts file
# Usage: {fn} [ host0 ]
#
# Argument: host0 - String. Optional. One ore more hosts to add to the known hosts file
#
# If no arguments are passed, the default behavior is to set up the `~/.ssh` directory and create the known hosts file.
#
sshAddKnownHost() {
  local remoteHost output sshKnown verbose exitCode

  sshKnown=.ssh/known_hosts
  exitCode=0
  verbose=false

  if ! buildEnvironmentLoad HOME; then
    return 1
  fi

  if [ ! -d "$HOME" ]; then
    consoleError "HOME directory does not exist: $HOME" 1>&2
    return "$errorEnvironment"
  fi
  sshKnown="$HOME/$sshKnown"
  if ! requireFileDirectory "$sshKnown"; then
    consoleError "Failed to create .ssh directory" 1>&2
    return "$errorEnvironment"
  fi
  if [ ! -f "$sshKnown" ] && ! touch "$sshKnown"; then
    consoleError "Unable to create $sshKnown" 1>&2
    return "$errorEnvironment"
  fi
  if ! chmod 700 "$HOME/.ssh" || ! chmod 600 "$sshKnown"; then
    consoleError "Failed to set mode on .ssh correctly" 1>&2
    return "$errorEnvironment"
  fi

  output=$(mktemp)
  buildDebugStart ssh || :
  while [ $# -gt 0 ]; do
    case "$1" in
      --verbose)
        verbose=true
        ;;
      *)
        remoteHost="$1"
        if grep -q "$remoteHost" "$sshKnown"; then
          ! $verbose || consoleInfo "Host $remoteHost already known"
        elif ssh-keyscan "$remoteHost" >"$output" 2>&1; then
          cat "$output" >>"$sshKnown"
          ! $verbose || consoleSuccess "Added $remoteHost to $sshKnown"
        else
          printf "%s: %s\n%s\n" "$(consoleError "Failed to add $remoteHost to $sshKnown")" "$(consoleCode)$exitCode" "$(prefixLines "$(consoleCode)" <"$output")" 1>&2
          exitCode=$errorEnvironment
        fi
        ;;
    esac
    shift
  done
  buildDebugStop ssh || :
  rm "$output" 2>/dev/null || :
  return $exitCode
}
