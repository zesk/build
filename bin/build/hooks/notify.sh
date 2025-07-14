#!/usr/bin/env bash
#
# Tell the operator something important
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
set -eou pipefail
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"

__hookNotifySoundName() {
  local usage="$1" soundName="$2"

  if ! darwinSoundValid "$soundName"; then
    local home original
    home=$(__catchEnvironment "$usage" buildHome) || return $?
    original="$home/etc/$soundName.mp3"
    [ -f "$original" ] || __throwArgument "usage" "No sound installed with name $(decorate code "$soundName")" || return $?
    __catchEnvironment "$usage" darwinSoundInstall --create "$home/etc/$soundName.mp3" || return $?
  fi
  printf "%s\n" "$soundName"
}

# fn: {base}
#
# Run for notifying the user of something rather important or time-consuming.
#
# Environment: BUILD_NOTIFY_SOUND - Play this sound if none is specified.
# Argument: --sound soundName - Play a sound
# Argument: --title title - Set the title of the notification
# Argument: message ... - Display this message (one per line) in the notification.
__hookNotify() {
  local usage="_${FUNCNAME[0]}"

  local title soundName="" ss=()

  title="$(buildEnvironmentGet APPLICATION_NAME)"
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
    --sound)
      shift
      soundName=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
      ;;
    --title)
      shift
      title=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
      ;;
    *)
      break
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  if isDarwin; then
    if [ -n "$soundName" ]; then
      if [ "$soundName" = "-" ]; then
        ss=()
      else
        soundName=$(__hookNotifySoundName "$usage" "$soundName") || return $?
        ss=(--sound "$soundName")
      fi
    else
      soundName=$(buildEnvironmentGet BUILD_NOTIFY_SOUND)
      if [ -n "$soundName" ] && [ "$soundName" != "-" ]; then
        soundName=$(__hookNotifySoundName "$usage" "$soundName") || return $?
        ss=(--sound "$soundName")
      fi
    fi
    local message
    message="$(__catchEnvironment "$usage" stripAnsi <<<"$*")" || return $?
    [ -n "$message" ] || message="Silence is golden."
    muzzle darwinNotification "${ss[@]+"${ss[@]}"}" --title "$title" "$message"
  else
    decorate notice "NOTIFY: $title"
    printf "%s\n" "$*" | decorate info | decorate wrap "$(decorate notice "NOTIFY:")"
  fi
}
___hookNotify() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookNotify "$@"
