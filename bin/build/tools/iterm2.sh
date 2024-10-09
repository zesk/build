#!/usr/bin/env bash
#      _ _____                   ____
#     (_)_   _|__ _ __ _ __ ___ |___ \
#     | | | |/ _ \ '__| '_ ` _ \  __) |
#     | | | |  __/ |  | | | | | |/ __/
#     |_| |_|\___|_|  |_| |_| |_|_____|
#
# by George Nachman and Contributors
#
# URL: https://iterm2.com/
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: ./docs/_templates/tools/iterm2.md
# Test: ./test/tools/iterm2-tests.sh

# Is the current console iTerm2?
isiTerm2() {
  export LC_TERMINAL
  __environment buildEnvironmentLoad LC_TERMINAL || return $?
  [ "${LC_TERMINAL-}" = "iTerm2" ]
}

# Set the badge for the iTerm2 console
# Usage: {fn} [ --ignore | -i ] message ...
# Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.
# Argument: message ... - Any message to display as the badge
# Environment: LC_TERMINAL
iTerm2Badge() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved
  local message=() wrongTerminalFails=true

  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --ignore | -i)
        wrongTerminalFails=false
        ;;
      *)
        message+=("$argument")
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  if isiTerm2; then
    printf "\e]1337;SetBadgeFormat=%s\a" "$(printf "%s" "${message[*]}" | base64)"
  elif $wrongTerminalFails; then
    __failEnvironment "$usage" "Terminal does not support badges: $(consoleCode "$LC_TERMINAL")" || return $?
  fi
}
_iTerm2Badge() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Load $HOME/.iterm2_shell_integration.bash if it exists
# Environment: LC_TERMINAL
# Environment: TERM
iTerm2Init() {
  local usage="_${FUNCNAME[0]}"
  local source
  ! isiTerm2 && return 0
  __environment buildEnvironmentLoad TERM || return $?
  # iTerm2 customizations
  set +ue
  source="${HOME}/.iterm2_shell_integration.bash"
  # shellcheck source=/dev/null
  [ ! -x "$source" ] || source "$source" || __failEnvironment "source $source failed" || return $?
}
_iTerm2Init() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
