#!/bin/bash
#
# Set up SSH for a user with ID and backup keys in `~/.ssh`
#
# Copyright &copy; 2024, Market Acumen, Inc.
#
# Created 2005/01/06 05:45:46 by kent
#
set -eou pipefail

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

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
#
sshSetup() {
  local arg sshHomePath flagForce servers keyType keyBits

  if ! buildEnvironmentLoad HOME; then
    "_${FUNCNAME[0]}" "$errorEnvironment" "buildEnvironmentLoad HOME failed" || return $?
  fi
  if [ ! -d "${HOME-}" ]; then
    _sshSetup "$errorEnvironment" "HOME is not defined and is required" || return $?
  fi
  sshHomePath="$HOME/.ssh/"
  flagForce=0
  servers=()
  keyType=ed25519
  keyBits=2048

  while [ $# != 0 ]; do
    arg="$1"
    if [ -z "$arg" ]; then
      _sshSetup "$errorArgument" "Empty argument" || return $?
    fi
    case "$arg" in
      --type)
        shift || _sshSetup "$errorArgument" "Missing $arg" || return $?
        case "$1" in
          ed25519 | rsa | dsa)
            keyType=$1
            ;;
          *)
            _sshSetup "$errorArgument" "Key type $1 is not known: ed25519 | rsa | dsa" || return $?
            ;;
        esac
        ;;
      --bits)
        shift || _sshSetup "$errorArgument" "Missing $arg" || return $?
        minBits=512
        if [ "$(("$1" + 0))" -lt "$minBits" ]; then
          _sshSetup "$errorArgument" "Key bits is too $minBits: $1 -> $(("$1" + 0))" || return $?
        fi
        ;;
      --help)
        usage 0
        return 0
        ;;
      --force)
        flagForce=1
        ;;
      *)
        servers+=("$arg")
        ;;
    esac
    shift
  done

  if [ ! -d "$sshHomePath" ] && ! mkdir -p .ssh/; then
    consoleError "Can't create $sshHomePath" 1>&2
    return 1
  fi
  chmod 700 "$sshHomePath"
  cd "$sshHomePath"
  user="$(whoami)"
  keyName="$user@$(uname -n)"
  if [ $flagForce = 0 ] && [ -f "$keyName" ]; then
    if [ ${#servers[@]} = 0 ]; then
      echo "Key $keyName already exists, exiting." 1>&2
      exit $errorArgument
    fi
  else
    echo "Generating $keyName (keyType $keyType $keyBits keyBits)"
    ssh-keygen -f "$keyName" -t "$keyType" -b $keyBits -C "$keyName" -q -N ""
    cp "$keyName" id_"$keyType"
    cp "$keyName".pub id_"$keyType".pub
  fi
  for s in "${servers[@]}"; do
    echo "Uploading key and modifying authorized_keys with $s"
    echo "(Please enter password twice)"
    if ! printf "cd .ssh\n""put %s\n""quit" "$keyName.pub" | sftp "$s" >/dev/null; then
      _sshSetup $errorEnvironment "$s failed to upload key" || return $?
    fi
    if ! printf "cd ~\\n""cd .ssh\n""cat *pub > authorized_keys\n""exit" | ssh -T "$s" >/dev/null; then
      _sshSetup "$errorEnvironment" "$s failed to add to authorized keys" || return $?
    fi
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

sshSetup "$@"
