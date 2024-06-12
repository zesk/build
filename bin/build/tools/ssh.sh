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
  local remoteHost output sshKnown verbose exitCode verboseArgs

  # IDENTICAL this_usage 4
  local this usage

  this="${FUNCNAME[0]}"
  usage="_$this"

  sshKnown=.ssh/known_hosts
  exitCode=0
  verbose=false
  verboseArgs=()

  __usageEnvironment "$usage" buildEnvironmentLoad HOME || return $?
  [ -d "$HOME" ] || __failEnvironment "$usage" "HOME directory does not exist: $HOME" || return $?

  sshKnown="$HOME/$sshKnown"
  __usageEnvironment "$usage" requireFileDirectory "$sshKnown" || return $?
  [ -f "$sshKnown" ] || touch "$sshKnown" || __failEnvironment "$usage" "Unable to create $sshKnown" || return $?

  chmod 700 "$HOME/.ssh" && chmod 600 "$sshKnown" || __failEnvironment "$usage" "Failed to set mode on .ssh correctly" || return $?

  output=$(mktemp)
  buildDebugStart ssh || :
  while [ $# -gt 0 ]; do
    case "$1" in
      --verbose)
        verbose=true
        verboseArgs=("-v")
        ;;
      *)
        remoteHost="$1"
        if grep -q "$remoteHost" "$sshKnown"; then
          ! $verbose || consoleInfo "Host $remoteHost already known"
        elif ssh-keyscan "${verboseArgs[@]+"${verboseArgs[@]+}"}" "$remoteHost" >"$output" 2>&1; then
          cat "$output" >>"$sshKnown"
          ! $verbose || consoleSuccess "Added $remoteHost to $sshKnown"
        else
          exitCode=$?
          printf "%s: %s\nOUTPUT:\n%s\nEND OUTPUT\n" "$(consoleError "Failed to add $remoteHost to $sshKnown")" "$(consoleCode)$exitCode" "$(wrapLines ">> $(consoleCode)" "$(consoleReset) <<" <"$output")" 1>&2
        fi
        ;;
    esac
    shift
  done
  buildDebugStop ssh || :
  rm "$output" 2>/dev/null || :
  return $exitCode
}
