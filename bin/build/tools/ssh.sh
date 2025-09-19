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

sshKnownHostsFile() {
  local handler="_${FUNCNAME[0]}"

  sshKnown=$(__catch "$handler" userHome ".ssh/known_hosts") || return $?

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --create)
      local sshHome
      sshHome=$(__catchEnvironment "$handler" dirname "$sshKnown") || return $?
      if [ ! -d "$sshHome" ]; then
        sshHome=$(__catch "$handler" directoryRequire "$sshHome") || return $?
      fi
      [ -f "$sshKnown" ] || touch "$sshKnown" || __throwEnvironment "$handler" "Unable to create $sshKnown" || return $?
      __catchEnvironment "$handler" chmod 700 "$sshHome" || return $?
      __catchEnvironment "$handler" chmod 600 "$sshKnown" || return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done
  printf "%s\n" "$sshKnown"
}
_sshKnownHostsFile() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

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
sshKnownHostAdd() {
  local handler="_${FUNCNAME[0]}"

  local exitCode=0 verbose=false sshKnown=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose) verbose=true ;;
    *)
      [ -n "$sshKnown" ] || sshKnown="$(__catchEnvironment "$handler" sshKnownHostsFile --create)" || return $?

      local remoteHost="$1"

      if grep -q "$remoteHost" "$sshKnown"; then
        ! $verbose || decorate info "Host $remoteHost already known"
      else
        local output
        output=$(fileTemporaryName "$handler") || return $?
        if ssh-keyscan "${verboseArgs[@]+"${verboseArgs[@]+}"}" "$remoteHost" >"$output" 2>&1; then
          __catchEnvironment "$handler" cat "$output" >>"$sshKnown" || returnClean $? "$output" || return $?
          __catch "$handler" rm -f "$output" || return $?
          ! $verbose || decorate success "Added $remoteHost to $sshKnown"
        else
          exitCode=$?
          __catch "$handler" rm -f "$output" || return $?
          printf "%s: %s\nOUTPUT:\n%s\nEND OUTPUT\n" "$(decorate error "Failed to add $remoteHost to $sshKnown")" "$(decorate code "$exitCode")" "$(decorate code <"$output" | decorate wrap ">> ")" 1>&2
        fi
      fi
      ;;
    esac
    shift
  done
  [ -n "$sshKnown" ] || __throwArgument "$handler" "Need at least one host to add" || return $?

  return $exitCode
}
_sshKnownHostAdd() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

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
# Argument: host0 ... - String. Optional. One ore more hosts to add to the known hosts file
# Argument: --skip-backup | --no-backup - Flag. Optional. Skip the file backup as `name.$(todayDate)`
# Argument: --verbose - Flag. Optional. Be verbose.
#
# If no arguments are passed, the default behavior is to set up the `~/.ssh` directory and create the known hosts file.
#
sshKnownHostRemove() {
  local handler="_${FUNCNAME[0]}"

  local sshKnown="" exitCode=0 verbose=false verboseArgs=() backupFlag=true

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --skip-backup | --no-backup)
      backupFlag=false
      ;;
    --verbose)
      verbose=true
      verboseArgs=("-v")
      ;;
    *)
      [ -n "$sshKnown" ] || sshKnown="$(__catchEnvironment "$handler" sshKnownHostsFile)" || return $?

      local remoteHost="$1"
      if ! grepSafe -q -e "$(quoteGrepPattern "$remoteHost")" <"$sshKnown"; then
        ! $verbose || decorate info "Host $remoteHost already removed"
      else
        local backupName

        backupName="$sshKnown.$(todayDate)"
        if $backupFlag && [ -f "$backupName" ]; then
          ! $verbose || decorate info "Rotating $(decorate file "$backupName")"
          __catchEnvironment "$handler" rotateLog "$backupName" 9 || return $?
        fi
        __catchEnvironment "$handler" cp "$sshKnown" "$backupName" || return $?
        __catchEnvironment "$handler" grepSafe -v -e "$(quoteGrepPattern "$remoteHost")" <"$backupName" >"$sshKnown" || return $?
        # If backupFlag is true -> do not delete the backupName
        $backupFlag || __catchEnvironment "$handler" rm -f "$backupName" || return $?
        ! $verbose || decorate success "Removed $(decortae value "$remoteHost") from $(decorate file "$sshKnown")"
      fi
      ;;
    esac
    shift
  done
  [ -n "$sshKnown" ] || __throwArgument "$handler" "Need at least one host to remove" || return $?
}
_sshKnownHostRemove() {
  # __IDENTICAL__ usageDocument 1
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
  local handler="_${FUNCNAME[0]}"

  home=$(__catch "$handler" userHome) || return $?

  local sshHomePath="$home/.ssh/" flagForce=false servers=() keyType=ed25519 keyBits=2048

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --type)
      shift
      keyType="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      case "$keyType" in ed25519 | rsa | dsa) ;; *) __throwArgument "$handler" "Key type $1 is not known: ed25519 | rsa | dsa" || return $? ;; esac
      ;;
    --bits)
      shift
      minBits=512
      keyBits=$(usageArgumentPositiveInteger "$handler" "$argument" "${1-}") || return $?
      [ "$keyBits" -ge "$minBits" ] || __throwArgument "$handler" "Key bits must be at least $minBits: $keyBits" || return $?
      ;;
    --force)
      flagForce=true
      ;;
    *)
      servers+=("$argument")
      ;;
    esac
    shift
  done

  [ -d "$sshHomePath" ] || mkdir -p "$sshHomePath" || __throwEnvironment "$handler" "Can not create $sshHomePath" || return $?
  __catchEnvironment "$handler" chmod 700 "$sshHomePath" || return $?

  user="$(whoami)" || __throwEnvironment "$handler" "whoami failed" || return $?
  keyName="$user@$(uname -n)" || __throwEnvironment "$handler" "uname -n failed" || return $?
  if $flagForce && [ -f "$keyName" ]; then
    [ ${#servers[@]} -gt 0 ] || _argument "Key $keyName already exists, exiting." || return $?
  else
    local newKeys=("$keyName" "${keyName}.pub")
    statusMessage decorate info "Generating $keyName (keyType $keyType $keyBits keyBits)"
    __catchEnvironment "$handler" muzzle pushd "$sshHomePath" || return $?
    __catchEnvironment "$handler" ssh-keygen -f "$keyName" -t "$keyType" -b "$keyBits" -C "$keyName" -q -N "" || returnUndo $? muzzle popd || return $?
    __catchEnvironment "$handler" muzzle popd || returnClean $? "${newKeys[@]}" || return $?

    targetKeys=("id_${keyType}" "id_${keyType}.pub")
    local index
    for index in "${!targetKeys[@]}"; do
      __catchEnvironment "$handler" cp "${newKeys[index]}" "${targetKeys[index]}" || returnClean $? "${targetKeys[@]}" "${newKeys[@]}" || return $?
    done
  fi
  local server
  for server in "${servers[@]}"; do
    local showServer

    showServer=$(decorate value "$server")
    statusMessage --last printf "%s\n" "Pushing to $showServer – (Please authenticate with sftp)"
    if ! printf "cd .ssh\n""put %s\n""quit" "$keyName.pub" | sftp "$server" >/dev/null; then
      __throwEnvironment "$handler" "failed to upload key to $showServer" || return $?
    fi
    statusMessage decorate info "Configuring $server ..."
    if ! printf "cd ~\\n""cd .ssh\n""cat *pub > authorized_keys\n""exit" | ssh -T "$server" >/dev/null; then
      __throwEnvironment "$handler" "failed to add to authorized_keys on $showServer" || return $?
    fi
    statusMessage decorate success "Completed $server"
  done
}
_sshSetup() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_generateSSHKeyPair() {
  local keyName keyType keyBits

  keyType=ed25519
  keyBits=2048
  keyName="$1"
  ssh-keygen -f "$keyName" -t "$keyType" -b $keyBits -C "$keyName" -q -N ""
}
