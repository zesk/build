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

  if ! insideDocker; then
    # shellcheck source=/dev/null
    source "$here/_isExecutable.sh"
  else
    # shellcheck source=/dev/null
    source "$here/_isExecutable.docker.sh"
  fi

  if isAlpine; then
    # shellcheck source=/dev/null
    source "$here/Alpine.sh"
  else
    # shellcheck source=/dev/null
    source "$here/not-Alpine.sh"

    if [ -f /etc/debian_version ]; then
      # shellcheck source=/dev/null
      source "$here/Debian.sh"
    else
      # shellcheck source=/dev/null
      source "$here/Ubuntu.sh"
    fi
  fi
}

__loadLinuxFunctions "${BASH_SOURCE[0]%/*}"
