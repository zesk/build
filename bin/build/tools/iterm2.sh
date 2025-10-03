#!/usr/bin/env bash
#      _ _____                   ____
#     (_)_   _|__ _ __ _ __ ___ |___ \
#     | | | |/ _ \ '__| '_ ` _ \  __) |
#     | | | |  __/ |  | | | | | |/ __/
#     |_| |_|\___|_|  |_| |_| |_|_____|
#
# Terminal program written by George Nachman and Contributors
#
# URL: https://iterm2.com/
#
# Code to integrate with this terminal specifically.
#
# Features:
# - Change colors in the current terminal
# - Display graphics
# - Attract attention
# - Prompt support with highlighting of commands and output
#
# These were originally just reverse engineered from the sample code; but they are actually documented here so
# maybe check that and add missing features:
# - https://iterm2.com/documentation-escape-codes.html
# TODO: Review iTerm2 documentation and implement the missing codes
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/iterm2.md
# Test: ./test/tools/iterm2-tests.sh

# Is the current console iTerm2?
# Succeeds when LC_TERMINAL is `iTerm2` AND TERM is NOT `screen`
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Environment: LC_TERMINAL
# Environment: TERM
isiTerm2() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  export LC_TERMINAL TERM
  [ "${LC_TERMINAL-}" = "iTerm2" ] && [ "${TERM-}" != "screen" ]
}
_isiTerm2() {
  true || isiTerm2 --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Internal
# iTerm "os command" perhaps?
_iTerm2_osc() {
  printf "\033]%s\007" "$1"
}

# Set an iTerm name to value
# Usage: name value
_iTerm2_setValue() {
  _iTerm2_osc "$(printf "1337;%s=%s" "$@")"
}

# e.g. SetBadgeFormat
_iTerm2_setBase64Value() {
  local name="${1-}"
  [ -n "$name" ] || returnArgument "${FUNCNAME[0]} name is blank" || return $?
  shift && _iTerm2_setValue "$name" "$(printf "%s\n" "$@" | base64 | tr -d '\n')"
}

# Run before pre-exec functions (in other implementation)
# I *THINK* this hides output from the terminal or something as the interactive prompt does not work
# Playing with moving the order around
__iTerm2HideOutput() {
  _iTerm2_osc "133;C;"
}

# Usage: __iTerm2SetUserVariable key value
__iTerm2SetUserVariable() {
  local name="${1-}" value="${2-}"

  name=$(usageArgumentEnrivonmentVariable "$handler" "name" "$name") || return $?
  _iTerm2_setValue "SetUserVar" "$(printf "%s" "$value" | base64 | tr -d '\n')"
}

__iTerm2_version() {
  _iTerm2_osc "1337;ShellIntegrationVersion=8;shell=bash"
}

# prefix -> mark
# output is allowed now? (?), I believe, or something
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

  __iTerm2HideOutput
  host=${__ITERM2_HOST-}
  if [ -n "$host" ] || [ "$(date +%s)" -gt $((${__ITERM2_HOST_TIME-0} + 60)) ]; then
    __ITERM2_HOST=$(hostname)
    __ITERM2_HOST_TIME=$(date +%s)
  fi
  _iTerm2_setValue "RemoteHost" "$USER@$__ITERM2_HOST"
  _iTerm2_setValue "CurrentDir" "$PWD"
  __iTerm2_prefix
}

# Add support for iTerm2 to bashPrompt
# If you are wondering what this does - it delimits the prompt, your command, and the output in the console so iTerm2 can be nice and let you
# select it.
# It also reports the host, user and current directory back to iTerm2 on every prompt command.
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# See: bashPrompt
# Requires: __catchEnvironment muzzle bashPrompt bashPromptMarkers iTerm2UpdateState
# Requires: __iTerm2_mark __iTerm2_suffix __iTerm2UpdateState
# Environment: __ITERM2_HOST
# Environment: __ITERM2_HOST_TIME
iTerm2PromptSupport() {
  local handler="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  __catchEnvironment "$handler" muzzle bashPromptMarkers "$(__iTerm2_mark)" "$(__iTerm2_suffix)" || return $?
  __catchEnvironment "$handler" bashPrompt --skip-prompt --last __iTerm2UpdateState || return $?
}
_iTerm2PromptSupport() {
  # __IDENTICAL__ usageDocument 1
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
#
# Internally supported:
#
# - `imgcat` = `iTerm2Image`
# - `it2attention` - `iTerm2Attention`
# - `it2dl` - `iTerm2Download`
# - `it2setcolor` - `iTerm2SetColors`
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
iTerm2Aliases() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"

  local home skipped=()

  home=$(__catch "$handler" userHome) || return $?

  [ -d "$home/.iterm2" ] || __throwEnvironment "$handler" "Missing ~/.iterm2" || return $?

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
  true || iTerm2Aliases --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Solely the color names (e.g blue), not anything else
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
iTerm2ColorNames() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf "%s\n" black red green yellow blue magenta cyan white
}
_iTerm2ColorNames() {
  true || iTerm2ColorNames --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Is it a color name?
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
iTerm2IsColorName() {
  local handler="_${FUNCNAME[0]}"
  case "${1-}" in
  # _IDENTICAL_ helpHandler 1
  --help) "$handler" 0 && return $? || return $? ;;
  black | red | green | yellow | blue | magenta | cyan | white) return 0 ;; *) return 1 ;;
  esac
}
_iTerm2IsColorName() {
  true || iTerm2ColorNames --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# This is faster than inArray etc.
iTerm2IsColorType() {
  local handler="_${FUNCNAME[0]}"
  case "${1-}" in
  # _IDENTICAL_ helpHandler 1
  --help) "$handler" 0 && return $? || return $? ;;
  fg | bg | selbg | selfg | curbg | curfg) return 0 ;;
  bold | link | underline) return 0 ;;
  tab) return 0 ;;
  black | red | green | yellow | blue | magenta | cyan | white) return 0 ;;
  br_black | br_red | br_green | br_yellow | br_blue | br_magenta | br_cyan | br_white) return 0 ;;
  *) return 1 ;;
  esac
}
_iTerm2IsColorType() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Colors for various UI elements
iTerm2ColorTypes() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local colors
  printf "%s\n" fg bg selbg selfg curbg curfg # Selection and maybe current line?
  printf "%s\n" bold link underline           # Formatting
  printf "%s\n" tab                           # Tab color! - awesome
  read -r -d "" -a colors < <(iTerm2ColorNames)
  printf -- "%s\n" "${colors[@]}"
  printf -- "%s\n" "${colors[@]}" | decorate wrap "br_" ""
}
_iTerm2ColorTypes() {
  true || iTerm2ColorTypes --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} handler verboseFlag colorSetting
__iTerm2SetColors() {
  local handler="$1" verboseFlag="$2" colorType="$3" colorValue="$4"

  local colorSpace colorCode=""
  IFS=":" read -r colorSpace colorCode <<<"$colorValue" || :
  if [ -z "$colorCode" ]; then
    colorCode=$colorValue
    colorSpace=""
  else
    case "$colorSpace" in
    srgb | rgb | p3) ;; *) __throwArgument "$handler" "Invalid color space $(decorate error "$colorSpace") in $(decorate code "$colorValue")" || return $? ;;
    esac
  fi
  colorCode=$(uppercase "$colorCode")
  case "$colorCode" in
  [[:xdigit:]]*) ;;
  *) __throwArgument "$handler" "Invalid hexadecimal color: $(decorate error "$colorCode") in $(decorate code "$colorValue")" || return $? ;;
  esac
  ! $verboseFlag || statusMessage decorate info "Setting color $(decorate label "$colorType") to $(decorate value "$colorCode")"
  _iTerm2_setValue SetColors "$colorType=$colorCode"
}

# Output an image to the console
iTerm2Image() {
  local handler="_${FUNCNAME[0]}"

  local ignoreErrors=false images=() width="" height="" aspectRatio=true

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --width)
      shift
      width=$(usageArgumentPositiveInteger "$handler" "$argument" "${1-}") || return $?
      ;;
    --height)
      shift
      height=$(usageArgumentPositiveInteger "$handler" "$argument" "${1-}") || return $?
      ;;
    --scale)
      aspectRatio=false
      ;;
    --preserve-aspect-ratio)
      aspectRatio=true
      ;;
    # IDENTICAL case-iTerm2ignore 3
    --ignore | -i)
      ignoreErrors=true
      ;;
    -*)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    *)
      images+=("$(usageArgumentFile "$handler" "imageFile" "$1")" "$(__iTerm2ImageExtras "$width" "$height" "$aspectRatio")") || return $?
      ;;
    esac
    shift
  done

  # IDENTICAL handle-iTerm2ignore 4
  if ! isiTerm2; then
    ! $ignoreErrors || return 0
    __throwEnvironment "$handler" "Not iTerm2" || return $?
  fi

  if [ "${#images[@]}" -gt 0 ]; then
    set -- "${images[@]}"
    while [ $# -gt 1 ]; do
      __catch "$handler" __iTerm2Image "$1" "$1" "$2" || return $?
      shift 2
    done
  else
    local image

    image=$(fileTemporaryName "$handler") || return $?
    __catchEnvironment "$handler" cat >"$image" || return $?
    __catch "$handler" __iTerm2Image "$image" "$(__iTerm2ImageExtras "$width" "$height" "$aspectRatio")" || return $?
    __catchEnvironment "$handler" rm -rf "$image" || return $?
  fi
}
_iTerm2Image() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__iTerm2ImageExtras() {
  local extras=() width="${1-}" height="${2-}" aspectRatio="${3-}"
  [ -z "$width" ] || extras+=("width=$width")
  [ -z "$height" ] || extras+=("height=$height")
  [ 0 -eq "${#extras[@]}" ] || extras+=("preserveAspectRatio=$aspectRatio")
  listJoin ";" "${extras[@]+"${extras[@]}"}"
}

__iTerm2Download() {
  local binary="$1" name="${2-}" suffix="${3-}" fileValue=""

  [ -z "$suffix" ] || suffix=";${suffix#;}"
  [ -z "$name" ] || fileValue="${fileValue}name=$(printf -- "%s" "$name" | base64);"
  fileValue="${fileValue}size=$(fileSize "$binary")}${suffix}:$(base64 <"$binary")"

  statusMessage --last _iTerm2_setValue File "$fileValue"
}

# Dump image
__iTerm2Image() {
  local suffix="${3-}"
  [ -z "$suffix" ] || suffix=";${suffix#;}"
  __iTerm2Download "${1-}" "${2-}" ";inline=1${suffix}"
}

# Download an file from remote to terminal host
# Argument: file - Optional. File. File to download.
# stdin: file
iTerm2Download() {
  local handler="_${FUNCNAME[0]}"

  local ignoreErrors=true files=() name=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --name)
      shift
      name="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    # IDENTICAL case-iTerm2ignore 3
    --ignore | -i)
      ignoreErrors=true
      ;;
    -*)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    *)
      files+=("$(usageArgumentFile "$handler" "imageFile" "$1")") || return $?
      ;;
    esac
    shift
  done

  # IDENTICAL handle-iTerm2ignore 4
  if ! isiTerm2; then
    ! $ignoreErrors || return 0
    __throwEnvironment "$handler" "Not iTerm2" || return $?
  fi

  if [ "${#files[@]}" -gt 0 ]; then
    set -- "${files[@]}"
    while [ $# -gt 0 ]; do
      __catch "$handler" __iTerm2Download "$1" "$1" || return $?
      shift
    done
  else
    local file

    file=$(fileTemporaryName "$handler") || return $?
    __catchEnvironment "$handler" cat >"$file" || return $?
    __catch "$handler" __iTerm2Download "$file" "$name" || return $?
    __catchEnvironment "$handler" rm -rf "$file" || return $?
  fi
}
_iTerm2Download() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Set terminal colors
# Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.
# Argument: --verbose | -v - Flag. Optional. Verbose mode. Show what you are doing.
# Argument: --skip-errors - Flag. Optional. Skip errors in color settings and continue - if loading a file containing a color scheme will load most of the file and skip any color settings with errors.
# Argument: colorSetting ... - String. Required. colorName=colorFormat string
#
# Color names permitted are:
# - fg bg bold link selbg selfg curbg curfg underline tab
# - black red green yellow blue magenta cyan white
# - br_black br_red br_green br_yellow br_blue br_magenta br_cyan br_white
#
# colorFormat is one of:
# - `RGB` - Three hex [0-9A-F] values (hex3)
# - `RRGGBB` - Six hex values (like CSS colors) (hex6)
# - `cs:hex3` or `cs:hex6` - Where cs is one of `srgb`, `rgb`, or `p3`
#
# Color spaces:
# - `srgb` - The default color space
# - 1rgb - Apple's device-independent colorspace
# - `p3` - Apple's large-gamut colorspace
#
# If no arguments are supplied which match a valid color setting values are read one-per-line from stdin
iTerm2SetColors() {
  local handler="_${FUNCNAME[0]}"

  local verboseFlag=false skipColorErrors=false ignoreErrors=false fillMissing=false
  local colorSettings=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --skip-errors)
      skipColorErrors=true
      ;;
    --fill)
      fillMissing=true
      ;;
    --verbose | -v)
      verboseFlag=true
      ;;
    # IDENTICAL case-iTerm2ignore 3
    --ignore | -i)
      ignoreErrors=true
      ;;
    -*)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    *)
      colorSettings+=("$(usageArgumentString "$handler" "colorSetting" "$1")") || return $?
      ;;
    esac
    shift
  done

  # IDENTICAL handle-iTerm2ignore 4
  if ! isiTerm2; then
    ! $ignoreErrors || return 0
    __throwEnvironment "$handler" "Not iTerm2" || return $?
  fi

  local colorSetting
  if [ 0 -eq "${#colorSettings[@]}" ]; then
    ! $verboseFlag || statusMessage decorate info "Reading colors from stdin"
    while read -r colorSetting; do
      colorSetting=$(trimSpace "$colorSetting")
      [ -n "$colorSetting" ] || continue
      [ "$colorSetting" = "${colorSetting#\#}" ] || continue
      colorSettings+=("$colorSetting")
    done
  fi

  local didColors=() needColors=() exitCode=0
  for colorSetting in "${colorSettings[@]+"${colorSettings[@]}"}"; do
    local colorType="${colorSetting%%=*}" colorValue="${colorSetting#*=}"
    if ! iTerm2IsColorType "$colorType"; then
      $skipColorErrors || __throwArgument "$handler" "Invalid color $(decorate value "$colorType")" || return $?
    else
      __iTerm2SetColors "$handler" "$verboseFlag" "$colorType" "$colorValue" || return $?
      if $fillMissing; then
        local nonBrightColorName="${colorType#br_}"
        if iTerm2IsColorName "$colorType"; then
          needColors+=("br_$colorType" "$colorValue")
        elif iTerm2IsColorName "$nonBrightColorName"; then
          needColors+=("$nonBrightColorName" "$colorValue")
        fi
        didColors+=("$colorType")
      fi
    fi
  done

  ! $verboseFlag || statusMessage decorate info "Need colors: $(decorate each --count --index code "${needColors[@]+"${needColors[@]}"}")"
  if ! "$fillMissing" || [ ${#needColors[@]} -eq 0 ]; then
    return $exitCode
  fi

  ! $verboseFlag || statusMessage decorate info "Filling in missing colors: $(decorate each --count --index code "${needColors[@]}")"
  set -- "${needColors[@]}"
  while [ $# -gt 0 ]; do
    local colorName="$1" colorValue colorMod
    if inArray "$colorName" "${didColors[@]}"; then
      ! $verboseFlag || statusMessage decorate notice "No need to fill $(decorate value "$colorName")"
      shift 2
      continue
    fi
    if [ "${colorName#br_}" != "$colorName" ]; then
      colorMod=0.7
    else
      colorMod=1.3
    fi
    colorValue="$(colorParse <<<"$colorValue" | colorMultiply "$colorMod" | colorFormat)"
    __iTerm2SetColors "$handler" "$verboseFlag" "$colorName" "$colorValue" || exitCode=$?
    ! $verboseFlag || statusMessage decorate notice "Filled $(decorate code "$colorName") with $(decorate value "$colorMod") $(decorate blue "$2") -> $(decorate bold-blue "$colorValue")"
    shift 2 || __throwEnvironment "$handler" "${FUNCNAME[0]}:$LINENO" || return $?
  done

  return $exitCode
}
_iTerm2SetColors() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Attract the operator
# Usage: {fn} [ true | false | ! | fireworks ]
# Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.
# Argument: --verbose | -v - Flag. Optional. Verbose mode. Show what you are doing.
iTerm2Attention() {
  local handler="_${FUNCNAME[0]}"

  local ignoreErrors=true verboseFlag=false didSomething=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose | -v)
      verboseFlag=true
      ;;
    # IDENTICAL case-iTerm2ignore 3
    --ignore | -i)
      ignoreErrors=true
      ;;
    *)
      # IDENTICAL handle-iTerm2ignore 4
      if ! isiTerm2; then
        ! $ignoreErrors || return 0
        __throwEnvironment "$handler" "Not iTerm2" || return $?
      fi

      local result=0

      parseBoolean "$argument" || result=$?
      case "$result" in 0 | 1)
        ! $verboseFlag || statusMessage decorate info "Requesting attention: $result"
        # Success (exit code 0) sends 1 to start attraction
        # 0 -> 1, 1 -> 0
        _iTerm2_setValue RequestAttention "$((result - 1))"
        didSomething=true
        ;;
      *)
        case "$argument" in
        "start")
          _iTerm2_setValue RequestAttention 1
          didSomething=true
          ;;
        "stop")
          _iTerm2_setValue RequestAttention 1
          didSomething=true
          ;;
        "!" | "fireworks")
          ! $verboseFlag || statusMessage decorate info "Requesting fireworks"
          _iTerm2_setValue RequestAttention "fireworks"
          didSomething=true
          ;;
        *)
          # _IDENTICAL_ argumentUnknownHandler 1
          __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
          ;;
        esac
        ;;
      esac
      ;;
    esac
    shift
  done

  $didSomething || __throwArgument "$handler" "Requires at least one argument" || return $?
}
_iTerm2Attention() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Set the badge for the iTerm2 console
# Usage: {fn} [ --ignore | -i ] message ...
# Argument: --ignore | -i - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.
# Argument: message ... - Any message to display as the badge
# Environment: LC_TERMINAL
iTerm2Badge() {
  local handler="_${FUNCNAME[0]}"

  local message=() ignoreErrors=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # IDENTICAL case-iTerm2ignore 3
    --ignore | -i)
      ignoreErrors=true
      ;;
    *)
      message+=("$argument")
      ;;
    esac
    shift
  done

  # IDENTICAL handle-iTerm2ignore 4
  if ! isiTerm2; then
    ! $ignoreErrors || return 0
    __throwEnvironment "$handler" "Not iTerm2" || return $?
  fi

  _iTerm2_setBase64Value "SetBadgeFormat" "${message[@]}"
}
_iTerm2Badge() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_readBytes() {
  dd bs=1 count="$1" 2>/dev/null
}

__iTerm2Version() {
  local version="" byte=""

  _readBytes 2 >/dev/null || return $?
  while [ "$byte" != "n" ]; do
    version="${version}${byte}"
    byte="$(_readBytes 1)" || return $?
  done
  printf "%s\n" "$version"
}

# Output the iTerm2 version
# Requires: stty
iTerm2Version() {
  local handler="_${FUNCNAME[0]}"

  local ignoreErrors=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # IDENTICAL case-iTerm2ignore 3
    --ignore | -i)
      ignoreErrors=true
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  # IDENTICAL handle-iTerm2ignore 4
  if ! isiTerm2; then
    ! $ignoreErrors || return 0
    __throwEnvironment "$handler" "Not iTerm2" || return $?
  fi

  local savedTTY undo=()

  savedTTY=$(__catchEnvironment "$handler" stty -g) || return $?
  undo=(stty "$savedTTY")

  stty -echo -icanon raw || returnUndo $? "${undo[@]}" || return $?

  # [1337n - iTerm version
  # [5n - Device status - (Responds with esc [ 0 n.) All terminals support this.
  # Send two to support non-iTerm terminals
  printf "\e[1337n""\e[5n"

  local version
  version=$(__iTerm2Version)
  case "$version" in
  "0" | "3")
    stty "$savedTTY" || :
    __throwEnvironment "$handler" "iTerm2 did not respond to DSR 1337: $version" || return $?
    ;;
  *)
    # Read device status
    muzzle __iTerm2Version || :
    ;;
  esac
  stty "$savedTTY" || :
  printf "%s\n" "$version"
}
_iTerm2Version() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Sends a notification message via Mac OS X from iTerm2
# Argument: message - String. Required. Text to display.
iTerm2Notify() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  [ -t 0 ] || __throwEnvironment "$handler" "stdin is not a terminal" || return $?
  printf "\e]9;%s\007" "$*"
}
_iTerm2Notify() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Add iTerm2 support to console
# Environment: LC_TERMINAL
# Environment: TERM
# See: iTerm2Aliases iTerm2PromptSupport
iTerm2Init() {
  local handler="_${FUNCNAME[0]}"

  local ignoreErrors=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # IDENTICAL case-iTerm2ignore 3
    --ignore | -i)
      ignoreErrors=true
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  # IDENTICAL handle-iTerm2ignore 4
  if ! isiTerm2; then
    ! $ignoreErrors || return 0
    __throwEnvironment "$handler" "Not iTerm2" || return $?
  fi

  local home
  __catch "$handler" buildEnvironmentLoad TERM || return $?
  home=$(__catch "$handler" userHome) || return $?

  # iTerm2 customizations
  local ii=()
  ! $ignoreErrors || ii=(--ignore)
  __catchEnvironment "$handler" iTerm2PromptSupport "${ii[@]+"${ii[@]}"}" || return $?
  export BUILD_HOOK_DIRS
  buildEnvironmentLoad BUILD_HOOK_DIRS || return $?
  # Intercept notify
  BUILD_HOOK_DIRS=$(listAppend "${BUILD_HOOK_DIRS[@]}" ":" --first "bin/build/tools/iterm2/hooks")
  [ ! -d "$home/.iterm2" ] || __catchEnvironment "$handler" iTerm2Aliases || return $?
}
_iTerm2Init() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
