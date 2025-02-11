#!/usr/bin/env bash
#
# iTerm attention seeking
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

set -eou pipefail
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../../../tools.sh" || exit 99

# fn: {base}
#
# Run for notifying the user of something rather important or time-consuming.
#
# Environment: BUILD_NOTIFY_SOUND - Play this sound if none is specified.
# Argument: --sound soundName - Play a sound
# Argument: --title title - Set the title of the notification
# Argument: message ... - Display this message (one per line) in the notification.
__hookiTerm2Notify() {
  export BUILD_HOOK_DIRS
  buildEnvironmentLoad BUILD_HOOK_DIRS || return $?
  if isiTerm2; then
    iTerm2Attention !
    iTerm2Attention start
  fi
  __echo hookRunOptional --next "${BASH_SOURCE[0]}" "notify" "$@"
  echo "BUILD_HOOK_DIRS=$BUILD_HOOK_DIRS"
}

__hookiTerm2Notify "$@"
