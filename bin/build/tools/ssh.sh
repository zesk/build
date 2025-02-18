#!/usr/bin/env bash
#
# git tools, lame attempts have been made to have each function start with `git`.
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Depends: colors.sh
# bin: git
#
# Docs: contextOpen ./documentation/source/tools/ssh.md
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
# 1. `~./.ssh/known_hosts` is possibly modified (appended)
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
  local usage="_${FUNCNAME[0]}"

  local sshKnown=".ssh/known_hosts" exitCode=0 verbose=false verboseArgs=() home

  home=$(__catchEnvironment "$usage" userHome) || return $?

  sshKnown="$home/$sshKnown"
  __catchEnvironment "$usage" requireFileDirectory "$sshKnown" || return $?
  [ -f "$sshKnown" ] || touch "$sshKnown" || __throwEnvironment "$usage" "Unable to create $sshKnown" || return $?

  chmod 700 "$home/.ssh" && chmod 600 "$sshKnown" || __throwEnvironment "$usage" "Failed to set mode on .ssh correctly" || return $?

  local output
  output=$(fileTemporaryName "$usage") || return $?

  buildDebugStart ssh || :
  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --verbose)
        verbose=true
        verboseArgs=("-v")
        ;;
      *)
        local remoteHost
        remoteHost="$1"
        if grep -q "$remoteHost" "$sshKnown"; then
          ! $verbose || decorate info "Host $remoteHost already known"
        elif ssh-keyscan "${verboseArgs[@]+"${verboseArgs[@]+}"}" "$remoteHost" >"$output" 2>&1; then
          cat "$output" >>"$sshKnown"
          ! $verbose || decorate success "Added $remoteHost to $sshKnown"
        else
          exitCode=$?
          printf "%s: %s\nOUTPUT:\n%s\nEND OUTPUT\n" "$(decorate error "Failed to add $remoteHost to $sshKnown")" "$(decorate code)$exitCode" "$(wrapLines ">> $(decorate code)" "$(decorate reset) <<" <"$output")" 1>&2
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  buildDebugStop ssh || :
  rm "$output" 2>/dev/null || :
  return $exitCode
}
_sshAddKnownHost() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Set up SSH for a user with ID and backup keys in `~/.ssh`
#
# Create a key for a user for SSH authentication to other servers.
#
#
# Add .ssh key for current user
#
# Usage: {fn} [ --force ] [ server ... ]
# Argument: --force Force the program to create a new key if one exists
# Argument: server- Servers to connect to to set up authorization
#
# You will need the password for this server for the current user.
# Requires: userHome __catchEnvironment __throwEnvironment
sshSetup() {
  local sshHomePath flagForce servers keyType keyBits
  local usage="_${FUNCNAME[0]}"

  home=$(__catchEnvironment "$usage" userHome) || return $?

  local sshHomePath="$home/.ssh/" flagForce=false servers=() keyType=ed25519 keyBits=2048

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --type)
        shift
        keyType="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        case "$keyType" in ed25519 | rsa | dsa) ;; *) __throwArgument "$usage" "Key type $1 is not known: ed25519 | rsa | dsa" || return $? ;; esac
        ;;
      --bits)
        shift
        minBits=512
        keyBits=$(usageArgumentPositiveInteger "$usage" "$argument" "${1-}") || return $?
        [ "$keyBits" -ge "$minBits" ] || __throwArgument "$usage" "Key bits must be at least $minBits: $keyBits" || return $?
        ;;
      --force)
        flagForce=true
        ;;
      *)
        servers+=("$arg")
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -d "$sshHomePath" ] || mkdir -p "$sshHomePath" || __throwEnvironment "$usage" "Can not create $sshHomePath" || return $?
  __catchEnvironment "$usage" chmod 700 "$sshHomePath" || return $?

  user="$(whoami)" || __throwEnvironment "$usage" "whoami failed" || return $?
  keyName="$user@$(uname -n)" || __throwEnvironment "$usage" "uname -n failed" || return $?
  if $flagForce && [ -f "$keyName" ]; then
    [ ${#servers[@]} -gt 0 ] || _argument "Key $keyName already exists, exiting." || return $?
  else
    local newKeys=("$keyName" "${keyName}.pub")
    statusMessage decorate info "Generating $keyName (keyType $keyType $keyBits keyBits)"
    __catchEnvironment "$usage" muzzle pushd "$sshHomePath" || return $?
    __catchEnvironment "$usage" ssh-keygen -f "$keyName" -t "$keyType" -b "$keyBits" -C "$keyName" -q -N "" || _undo $? muzzle popd || return $?
    __catchEnvironment "$usage" muzzle popd || _clean $? "${newKeys[@]}" || return $?

    targetKeys=("id_${keyType}" "id_${keyType}.pub")
    local index
    for index in "${!targetKeys[@]}"; do
      __catchEnvironment "$usage" cp "${newKeys[index]}" "${targetKeys[index]}" || _clean $? "${targetKeys[@]}" "${newKeys[@]}" || return $?
    done
  fi
  local server
  for server in "${servers[@]}"; do
    local showServer

    showServer=$(decorate value "$server")
    statusMessage --last printf "%s\n" "Pushing to $showServer – (Please authenticate with sftp)"
    if ! printf "cd .ssh\n""put %s\n""quit" "$keyName.pub" | sftp "$server" >/dev/null; then
      __throwEnvironment "$usage" "failed to upload key to $showServer" || return $?
    fi
    statusMessage decorate info "Configuring $server ..."
    if ! printf "cd ~\\n""cd .ssh\n""cat *pub > authorized_keys\n""exit" | ssh -T "$server" >/dev/null; then
      __throwEnvironment "$usage" "failed to add to authorized_keys on $showServer" || return $?
    fi
    statusMessage decorate success "Completed $server"
  done
}
_sshSetup() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_generateSSHKeyPair() {
  local keyName keyType keyBits

  keyType=ed25519
  keyBits=2048
  keyName="$1"
  ssh-keygen -f "$keyName" -t "$keyType" -b $keyBits -C "$keyName" -q -N ""
}
