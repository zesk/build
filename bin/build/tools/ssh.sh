#!/usr/bin/env bash
#
# git tools, lame attempts have been made to have each function start with `git`.
#
# Copyright &copy; 2025 Market Acumen, Inc.
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
  local remoteHost output sshKnown verbose exitCode verboseArgs

  local usage

  usage="_${FUNCNAME[0]}"

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
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
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
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
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
    statusMessage decorate info "Generating $keyName (keyType $keyType $keyBits keyBits)"
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
