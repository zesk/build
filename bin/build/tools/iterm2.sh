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
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./docs/_templates/tools/iterm2.md
# Test: ./test/tools/iterm2-tests.sh

# Is the current console iTerm2?
# Fails if LC_TERMINAL is `iTerm2`
# Fails also if TERM is `screen`
isiTerm2() {
  export LC_TERMINAL TERM
  [ "${LC_TERMINAL-}" = "iTerm2" ] && [ "${TERM-}" != "screen" ]
}

# Internal
# iTerm "os command" perhaps?
function _iTerm2_osc {
  printf "\033]%s\007" "$1"
}

# Set an iTerm name to value
# Usage: name value
function _iTerm2_setValue {
  _iTerm2_osc "$(printf "1337;%s=%s" "$@")"
}

# e.g. SetBadgeFormat
function _iTerm2_setBase64Value {
  local name="${1-}"
  [ -n "$name" ] || _argument "${FUNCNAME[0]} name is blank" || return $?
  shift && _iTerm2_setValue "$name" "$(printf "%s\n" "$@" | base64 | tr -d '\n')"
}

# Run before pre-exec functions (in other implementation)
function __iTerm2PreExecution() {
  _iTerm2_osc "133;C;"
}

# Usage: iTerm2SetUserVariable key value
function iTerm2SetUserVariable() {
  local name="${1-}" value="${2-}"

  name=$(usageArgumentEnrivonmentVariable "$usage" "name" "$name") || return $?
  _iTerm2_setValue "SetUserVar" "$(printf "%s" "$value" | base64 | tr -d '\n')"
}

__iTerm2_version() {
  _iTerm2_osc "1337;ShellIntegrationVersion=8;shell=bash"
}

# prefix -> mark
# output is suppressed, I believe, or something
__iTerm2_prefix() {
  _iTerm2_osc "133;D;\$?"
}

# mark -> suffix - prompt begins
__iTerm2_mark() {
  _iTerm2_osc "133;A;\$?"
}

# suffix - prompt ends, everything *after* is a command, next line is output
__iTerm2_suffix() {
  _iTerm2_osc "133;B"
}

__iTerm2UpdateState() {
  local host=""
  export USER PWD __ITERM2_HOST __ITERM2_HOST_TIME

  __iTerm2_prefix
  host=${__ITERM2_HOST-}
  if [ -n "$host" ] || [ "$(date +%s)" -gt $((${__ITERM2_HOST_TIME-0} + 60)) ]; then
    __ITERM2_HOST=$(hostname)
    __ITERM2_HOST_TIME=$(date +%s)
  fi
  _iTerm2_setValue "RemoteHost" "$USER@$__ITERM2_HOST"
  _iTerm2_setValue "CurrentDir" "$PWD"
}

# Add support for iTerm2 to bashPrompt
# If you are wondering what this does - it delimits the prompt, your command, and the output in the console so iTerm2 can be nice and let you
# select it.
# It also reports the host, user and current directory back to iTerm2 on every prompt command.
#
# See: bashPrompt
# Requires: __catchEnvironment muzzle bashPrompt bashPromptMarkers iTerm2UpdateState
# Requires: __iTerm2_mark __iTerm2_suffix __iTerm2UpdateState
# Environment: __ITERM2_HOST
# Environment: __ITERM2_HOST_TIME
iTerm2PromptSupport() {
  local usage="_${FUNCNAME[0]}"

  __catchEnvironment "$usage" muzzle bashPromptMarkers "$(__iTerm2_mark)" "$(__iTerm2_suffix)" || return $?
  __catchEnvironment "$usage" bashPrompt --first __iTerm2PreExecution --last __iTerm2UpdateState || return $?
}
_iTerm2PromptSupport() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Installs iTerm2 aliases which are:
#
# - `it2check` - Check compatibility of these scripts (non-zero exit means non-compatible)
# - `imgcat` - Take an image file and output it to the console
# - `imgls` - List a directory and show thumbnails (in the console)
# - `it2attention` - Get attention from the operator
# - `it2getvar` - Get a variable value
# - `it2dl` - Download a file to the operator system's configured download folder
# - `it2ul` - Upload a file from the operator system to the remote
# - `it2copy` - Copy to clipboard from file or stdin
# - `it2setcolor` - Set console colors interactively
# - `it2setkeylabel` - Set key labels interactively
# - `it2universion` - Set, push, or pop Unicode version
iTerm2Aliases() {
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$@" || return 0

  local home skipped=()

  home=$(__catchEnvironment "$usage" userHome) || return $?

  [ -d "$home/.iterm2" ] || __throwEnvironment "$usage" "Missing ~/.iterm2" || return $?

  for item in imgcat imgls it2attention it2check it2copy it2dl it2ul it2getvar it2setcolor it2setkeylabel it2universion; do
    local target="$home/.iterm2/$item"
    if [ -x "$target" ]; then
      # shellcheck disable=SC2139
      alias "$item"="$target"
    else
      skipped+=("$item")
    fi
  done
  [ ${#skipped[@]} -eq 0 ] || decorate subtle "Skipped $(decorate each code "${skipped[@]}")" 1>&2
}
_iTerm2Aliases() {
  ! false || iTerm2Aliases --help
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Attract the operator
# Usage: {fn} [ true | false | ! | fireworks ]
# Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.
# Argument: --verbose | -v - Flag. Optional. Verbose mode. Show what you are doing.
iTerm2Attention() {
  local usage="_${FUNCNAME[0]}"

  local wrongTerminalFails=true verboseFlag=false didSomething=false

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
      --verbose | -v)
        verboseFlag=true
        ;;
      # IDENTICAL wrongTerminalFails 3
      --ignore | -i)
        wrongTerminalFails=false
        ;;
      *)
        local result=0
        parseBoolean "$argument" || result=$?
        case "$result" in 0 | 1)
          ! $verboseFlag || statusMessage decorate info "Requesting attention: $result"
          _iTerm2_setValue RequestAttention "$result"
          didSomething=true
          ;;
        *)
          case "$argument" in
            "!" | "fireworks")
              ! $verboseFlag || statusMessage decorate info "Requesting fireworks"
              _iTerm2_setValue RequestAttention "fireworks"
              didSomething=true
              ;;
            *)
              # _IDENTICAL_ argumentUnknown 1
              __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
              ;;
          esac
          ;;
        esac
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  $didSomething || __throwArgument "$usage" "Requires at least one argument" || return $?
}
_iTerm2Attention() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Set the badge for the iTerm2 console
# Usage: {fn} [ --ignore | -i ] message ...
# Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.
# Argument: message ... - Any message to display as the badge
# Environment: LC_TERMINAL
iTerm2Badge() {
  local usage="_${FUNCNAME[0]}"

  local message=() wrongTerminalFails=true

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
      # IDENTICAL wrongTerminalFails 3
      --ignore | -i)
        wrongTerminalFails=false
        ;;
      *)
        message+=("$argument")
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  if isiTerm2; then
    _iTerm2_setBase64Value "SetBadgeFormat" "${message[@]}"
  elif $wrongTerminalFails; then
    __throwEnvironment "$usage" "Terminal does not support badges: $(decorate code "$LC_TERMINAL")" || return $?
  fi
}
_iTerm2Badge() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Add iTerm2 support to console
# Environment: LC_TERMINAL
# Environment: TERM
iTerm2Init() {
  local usage="_${FUNCNAME[0]}"
  isiTerm2 || __throwEnvironment "$usage" "Not iTerm2" || return $?
  __catchEnvironment "$usage" buildEnvironmentLoad TERM || return $?
  # iTerm2 customizations
  __catchEnvironment "$usage" iTerm2Aliases || return $?
  __catchEnvironment "$usage" iTerm2PromptSupport || return $?
}
_iTerm2Init() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
