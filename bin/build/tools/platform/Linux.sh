#!/usr/bin/env bash
#
# TOP-LEVEL PLATFORM INCLUDE
#
# Most Linux fall here: Alpine Ubuntu Debian FreeBSD
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__loadLinuxFunctions() {
  local here="$1"

  # shellcheck source=/dev/null
  source "$here/not-Darwin.sh"

  if isAlpine; then
    # shellcheck source=/dev/null
    source "$here/Alpine.sh"
  else
    # shellcheck source=/dev/null
    source "$here/not-Alpine.sh"

    if [ -f /etc/debian_version ]; then
      # shellcheck source=/dev/null
      source "$here/Debian.sh"
    elif [ -f /etc/fedora-release ]; then
      # shellcheck source=/dev/null
      source "$here/Fedora.sh"
    else
      # shellcheck source=/dev/null
      source "$here/Ubuntu.sh"
    fi
  fi
}

__loadLinuxFunctions "${BASH_SOURCE[0]%/*}"
