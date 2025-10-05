#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/darwin.md
# Test: o ./test/tools/darwin-tests.sh
#

# Are we on Mac OS X?
isDarwin() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  [ "$(uname -s)" = "Darwin" ]
}
_isDarwin() {
  true || isDarwin --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Directory for user sounds
darwinSoundDirectory() {
  local handler="_${FUNCNAME[0]}" home
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"

  isDarwin || throwEnvironment "$handler" "Only on Darwin" || return $?
  home=$(returnCatch "$handler" userRecordHome) || return $?
  printf "%s\n" "$home/Library/Sounds"
}
_darwinSoundDirectory() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Is a Darwin sound name valid?
darwinSoundValid() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local sound sounds=()
  while read -r sound; do sounds+=("$sound"); done < <(darwinSoundNames)
  while [ $# -gt 0 ]; do

    inArray "$1" "${sounds[@]}" || return 1
    shift
  done
}
_darwinSoundValid() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Install a sound file for notifications
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: soundFile ... - File. Required. Sound file(s) to install in user library.
# Argument: --create - Optional. Flag. Create sound directory if it does not exist.
darwinSoundInstall() {
  local handler="_${FUNCNAME[0]}"

  local soundFiles=() soundDirectory createFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --create)
      createFlag=true
      ;;
    *)
      soundFiles+=("$(usageArgumentFile "$handler" "soundFile" "${1-}")") || return $?
      ;;
    esac
    shift
  done
  [ "${#soundFiles[@]}" -gt 0 ] || throwArgument "$handler" "Need at least one sound file" || return $?

  soundDirectory=$(catchEnvironment "$handler" darwinSoundDirectory) || return $?
  if [ ! -d "$soundDirectory" ]; then
    if "$createFlag"; then
      catchEnvironment "$handler" mkdir -p "$soundDirectory" || return $?
    else
      throwEnvironment "$handler" "No $soundDirectory" || return $?
    fi
  fi
  catchEnvironment "$handler" cp "${soundFiles[@]+"${soundFiles[@]}"}" "${soundDirectory%/}/" || return $?
}
_darwinSoundInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List valid sound names usable for notifications in Darwin
darwinSoundNames() {
  local handler="_${FUNCNAME[0]}" soundDirectory
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"

  soundDirectory=$(catchEnvironment "$handler" darwinSoundDirectory) || return $?
  [ -d "$soundDirectory" ] || throwEnvironment "$handler" "No $soundDirectory" || return $?
  find "$soundDirectory" -type f ! -name '.*' -exec basename {} \; | while read -r file; do
    printf "%s\n" "${file%.*}"
  done
}
_darwinSoundNames() {
  ! false || darwinSoundNames --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__osascriptClean() {
  local text
  text="$(stripAnsi <<<"$1")"
  text="${text//$'\n'/\\n}"
  text="${text//$'\r'/}"
  text="$(escapeDoubleQuotes "$text")"
  printf "%s" "$text"
}

# Display a notification for the user
# Argument: --title - String. Optional. Title of the notification.
# Argument: --debug - Flag. Optional. Output the osascript as `darwinNotification.debug` at the application root after this call.
# Argument: --sound soundName - String. Optional. Sound to play with the notification. Represents a sound base name found in `/Library/Sounds/`.
# Argument: message ... - String. Optional. Message to display to the user in the dialog.
darwinNotification() {
  local handler="_${FUNCNAME[0]}"

  local message=() title="" soundName="" debugFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --debug)
      debugFlag=true
      ;;
    --title)
      shift
      title="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    --sound)
      shift
      soundName="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      darwinSoundValid "$soundName" || throwArgument "$handler" "Sound name $(decorate value "$soundName") not valid, ignoring: $(darwinSoundNames)" || :
      ;;
    --)
      shift
      message=("$@")
      set --
      break
      ;;
    *)
      message+=("$1")
      ;;
    esac
    shift
  done

  usageRequireBinary "$handler" osascript || return $?

  [ -n "$title" ] || title="Zesk Build Notification"
  local messageText

  messageText="$(__osascriptClean "${message[*]}")"
  title="$(__osascriptClean "$title")"

  # https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/reference/ASLR_cmds.html#//apple_ref/doc/uid/TP40000983-CH216-SW224
  script="display notification \"${messageText}\" with title \"$title\""
  [ -z "$soundName" ] || script="$script sound name \"$(escapeDoubleQuotes "$soundName")\""

  if $debugFlag; then
    printf "%s\n" "$script" >"$(buildHome)/${FUNCNAME[0]}.debug"
  fi
  catchEnvironment "$handler" /usr/bin/osascript -e "$script" || return $?
}

_darwinNotification() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} [ --help ] [ --choice choiceText ] [ --ok ] [ --cancel ] [ --default buttonIndex ] message ...
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --choice choiceText - Optional. String. Title of the thing.
# Argument: --ok - Optional. Flag. Adds "OK" as an option.
# Argument: --cancel - Optional. Flag. Adds "Cancel" as an option.
# Argument: --default buttonIndex - Required. Integer. The button (0-based index) to make the default button choice.
# Argument: message ... - Required. String. The message to display in the dialog.
# Display a dialog using `osascript` with the choices provided. Typically this is found on Mac OS X.
# Outputs the selected button text upon exit.
# Platform: Darwin
darwinDialog() {
  local handler="_${FUNCNAME[0]}"

  local message=() defaultButton=0 choices=() title="" icon="-" timeout="" debugFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --choice)
      shift
      choices+=("$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    --title)
      shift
      title="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    --icon)
      shift
      icon=$(usageArgumentFile "$handler" "$argument" "${1-}") || return $?
      ;;
    --ok)
      choices+=("Ok")
      ;;
    --cancel)
      choices+=("Cancel")
      ;;
    --timeout)
      shift
      timeout=$(usageArgumentPositiveInteger "$handler" "$argument" $"${1-}") || return $?
      ;;
    --debug)
      debugFlag=true
      ;;
    --default)
      shift
      defaultButton="$(usageArgumentUnsignedInteger "$handler" "$argument" "${1-}")" || return $?
      ;;
    --)
      shift
      message=("$@")
      set --
      break
      ;;
    *)
      message+=("$1")
      ;;
    esac
    shift
  done

  usageRequireBinary "$handler" osascript || return $?

  [ "$icon" != "-" ] || icon="$(buildHome)/etc/zesk-build-icon.png"

  local choice choiceText=() messageText maxChoice quietErrors
  choiceText=()
  if [ ${#choices[@]} -eq 0 ]; then
    choices+=(Ok)
  fi
  for choice in "${choices[@]}"; do
    choiceText+=("$(printf '"%s"' "$(escapeDoubleQuotes "$choice")")")
  done
  maxChoice=$((${#choices[@]} - 1))
  if [ "$defaultButton" -gt $maxChoice ]; then
    throwArgument "$handler" "defaultButton $defaultButton is out of range 0 ... $maxChoice" || return $?
  fi
  messageText="$(escapeDoubleQuotes "$(printf "%s\\\n" "${message[@]}")")"
  quietErrors=$(fileTemporaryName "$handler") || return $?
  # Index is 1-based
  defaultButton=$((defaultButton + 1))
  (
    # Documentation
    # https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/reference/ASLR_cmds.html#//apple_ref/doc/uid/TP40000983-CH216-SW12
    local script="display dialog \"$messageText\" buttons { ${choiceText[*]} } default button $defaultButton"
    [ -z "$timeout" ] || script="$script giving up after $timeout"
    [ -z "$title" ] || script="$script with title \"$(escapeDoubleQuotes "$title")\""
    # [ -z "$icon" ] || script="$script with icon \"$(escapeDoubleQuotes "$icon")\""
    IFS=','
    ! $debugFlag || printf "\n\n    %s\n\n" "$(decorate code "$script")"
    result="$(catchEnvironment "$handler" osascript -e "$script" 2>"$quietErrors")" || returnUndo $? cat "$quietErrors" || return $?
    rm -rf "$quietErrors" || :
    local name value button="none" done=false IFS
    while ! $done; do
      if ! IFS=":" read -d ',' -r name value; then
        done=true
      fi
      name="${name# }"
      value="$(trimSpace "$value")"
      ! $debugFlag || decorate pair "$name" "$value"
      case "$name" in
      "button returned")
        button="$value"
        ;;
      "gave up")
        isBoolean "$value" || throwEnvironment "$handler" "gave up should be a boolean: $value" || return $?
        ! "$value" || returnMessage "$(returnCode timeout)" "Dialog timed out" || return $?
        ;;
      *)
        throwEnvironment "$handler" "Unknown return value from dialog: $(decorate label "$name"): $(decorate value "$value")" || return $?
        ;;
      esac
    done <<<"$result"
    printf "%s\n" "$button"
  ) || returnClean $? "$quietErrors" || return $?
}
_darwinDialog() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
