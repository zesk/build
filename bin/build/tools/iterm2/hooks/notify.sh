#!/usr/bin/env bash
#
# iTerm attention seeking
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../../../tools.sh" || exit 121

# fn: {base}
#
# Run for notifying the user of something rather important or time-consuming.
#
# Environment: BUILD_NOTIFY_SOUND - Play this sound if none is specified.
# Argument: --sound soundName - Play a sound
# Argument: --title title - Set the title of the notification
# Argument: message ... - Display this message (one per line) in the notification.
__iTerm2Notify() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@")

  if isiTerm2; then
    iTerm2Attention !
    iTerm2Attention start
  fi
  # IDENTICAL hookRunOptionalNext 1
  catchReturn "$handler" hookRunOptional --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "${__saved[@]+"${__saved[@]}"}" || return $?
}
___iTerm2Notify() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__iTerm2Notify "$@"
