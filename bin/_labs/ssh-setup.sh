#!/bin/bash
#
# Set up SSH for a user with ID and backup keys in `~/.ssh`
#
# Copyright &copy; 2024, Market Acumen, Inc.
#
# Created 2005/01/06 05:45:46 by kent
#
set -eou pipefail

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
    local usage

  usage="_${FUNCNAME[0]}"

  __usageEnvironment "$usage" buildEnvironmentLoad HOME || return $?
  [ -d "${HOME-}" ] || __failEnvironment "$usage" "HOME is not defined and is required" || return $?

  sshHomePath="$HOME/.ssh/"
  flagForce=0
  servers=()
  keyType=ed25519
  keyBits=2048

  while [ $# != 0 ]; do
    arg="$1"
    [ -n "$arg" ] || __failArgument "$usage" "blank argument" || return $?
    case "$arg" in
      --type)
        shift || __failArgument "$usage" "missing $arg" || return $?
        case "$1" in
          ed25519 | rsa | dsa)
            keyType=$1
            ;;
          *)
            __failArgument "$usage" "Key type $1 is not known: ed25519 | rsa | dsa" || return $?
            ;;
        esac
        ;;
      --bits)
        shift || __failArgument "$usage" "missing $arg" || return $?
        minBits=512
        [ "$(("$1" + 0))" -ge "$minBits" ] || __failArgument "$usage" "Key bits is too small $minBits: $1 -> $(("$1" + 0))" || return $?
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

  [ -d "$sshHomePath" ] || mkdir -p .ssh/ || __failEnvironment "$usage" "Can not create $sshHomePath" || return $?
  __usageEnvironment "$usage" chmod 700 "$sshHomePath" || return $?
  __usageEnvironment "$usage" cd "$sshHomePath" || return $?
  user="$(whoami)" || __failEnvironment "$usage" "whoami failed" || return $?
  keyName="$user@$(uname -n)" || __failEnvironment "$usage" "uname -n failed" || return $?
  if [ $flagForce = 0 ] && [ -f "$keyName" ]; then
    [ ${#servers[@]} -gt 0 ] || _argument "Key $keyName already exists, exiting." || return $?
  else
    statusMessage consoleInfo "Generating $keyName (keyType $keyType $keyBits keyBits)"
    __usageEnvironment "$usage" ssh-keygen -f "$keyName" -t "$keyType" -b $keyBits -C "$keyName" -q -N "" || return $?
    __usageEnvironment "$usage" cp "$keyName" id_"$keyType" || return $?
    __usageEnvironment "$usage" cp "$keyName".pub id_"$keyType".pub || return $?
  fi
  for s in "${servers[@]}"; do
    echo "Uploading key and modifying authorized_keys with $s"
    echo "(Please enter password twice)"
    if ! printf "cd .ssh\n""put %s\n""quit" "$keyName.pub" | sftp "$s" >/dev/null; then
      __failEnvironment "$usage" "$s failed to upload key" || return $?
    fi
    if ! printf "cd ~\\n""cd .ssh\n""cat *pub > authorized_keys\n""exit" | ssh -T "$s" >/dev/null; then
      __failEnvironment "$usage" "$s failed to add to authorized keys" || return $?
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
