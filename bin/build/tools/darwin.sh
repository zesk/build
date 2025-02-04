#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/darwin.md
# Test: o ./test/tools/darwin-tests.sh
#

# Are we on Mac OS X?
isDarwin() {
  [ "$(uname -s)" = "Darwin" ]
}

# Directory for user sounds
darwinSoundDirectory() {
  local usage="_${FUNCNAME[0]}" home

  isDarwin || __throwEnvironment "$usage" "Only on Darwin" || return $?
  home=$(__catchEnvironment "$usage" userHome) || return $?
  printf "%s\n" "$home/Library/Sounds"
}
_darwinSoundDirectory() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Is a Darwin sound name valid?
darwinSoundValid() {
  local sound sounds=()
  while read -r sound; do sounds+=("$sound"); done < <(darwinSoundNames)
  while [ $# -gt 0 ]; do
    inArray "$1" "${sounds[@]}" || return 1
    shift
  done
}

# Install a sound file for notifications
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: soundFile ... - File. Required. Sound file(s) to install in user library.
# Argument: --create - Optional. Flag. Create sound directory if it does not exist.
darwinSoundInstall() {
  local usage="_${FUNCNAME[0]}"

  local soundFiles=() soundDirectory createFlag=false

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
      --create)
        createFlag=true
        ;;
      *)
        soundFiles+=("$(usageArgumentFile "$usage" "soundFile" "${1-}")") || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  [ "${#soundFiles[@]}" -gt 0 ] || __throwArgument "$usage" "Need at least one sound file" || return $?

  soundDirectory=$(__catchEnvironment "$usage" darwinSoundDirectory) || return $?
  if [ ! -d "$soundDirectory" ]; then
    if "$createFlag"; then
      __catchEnvironment "$usage" mkdir -p "$soundDirectory" || return $?
    else
      __throwEnvironment "$usage" "No $soundDirectory" || return $?
    fi
  fi
  __catchEnvironment "$usage" cp "${soundFiles[@]+"${soundFiles[@]}"}" "${soundDirectory%/}/" || return $?
}
_darwinSoundInstall() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List valid sound names usable for notifications in Darwin
darwinSoundNames() {
  local usage="_${FUNCNAME[0]}" soundDirectory

  soundDirectory=$(__catchEnvironment "$usage" darwinSoundDirectory) || return $?
  [ -d "$soundDirectory" ] || __throwEnvironment "$usage" "No $soundDirectory" || return $?
  find "$soundDirectory" -type f ! -name '.*' -exec basename {} \; | while read -r file; do
    printf "%s\n" "${file%.*}"
  done
}
_darwinSoundNames() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Display a notification for the user
# Argument: --title - String. Optional. Title of the notification.
# Argument: --sound - String. Optional. Sound to play with the notification. Represents a sound base name found in `/Library/Sounds/`.
darwinNotification() {
  local usage="_${FUNCNAME[0]}"

  export OSTYPE
  usageRequireBinary "$usage" osascript || return $?

  local message=() title="" soundName=""

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
      --title)
        shift
        title="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      --sound)
        shift
        soundName="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        darwinSoundValid "$soundName" || __throwArgument "$usage" "Sound name $(decorate value "$soundName") not valid, ignoring: $(darwinSoundNames)" || :
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

  [ -n "$title" ] || title="Zesk Build Notification"
  local messageText="${message[*]}"
  messageText="$(escapeDoubleQuotes "$messageText")"
  title="$(escapeDoubleQuotes "$title")"

  # https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/reference/ASLR_cmds.html#//apple_ref/doc/uid/TP40000983-CH216-SW224
  script="display notification \"${messageText}\" with title \"$title\""
  [ -z "$soundName" ] || script="$script sound name \"$(escapeDoubleQuotes "$soundName")\""

  __catchEnvironment "$usage" /usr/bin/osascript -e "$script" || return $?
}

_darwinNotification() {
  # _IDENTICAL_ usageDocument 1
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
darwinDialog() {
  local usage="_${FUNCNAME[0]}"

  export OSTYPE
  usageRequireBinary "$usage" osascript || return $?

  local message=() defaultButton=0 choices=() title="" icon="-" timeout="" debugFlag=false

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
      --choice)
        shift
        choices+=("$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
        ;;
      --title)
        shift
        title="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      --icon)
        shift
        icon=$(usageArgumentFile "$usage" "$argument" "${1-}") || return $?
        ;;
      --ok)
        choices+=("Ok")
        ;;
      --cancel)
        choices+=("Cancel")
        ;;
      --timeout)
        shift
        timeout=$(usageArgumentPositiveInteger "$usage" "$argument" $"${1-}") || return $?
        ;;
      --debug)
        debugFlag=true
        ;;
      --default)
        shift
        defaultButton="$(usageArgumentUnsignedInteger "$usage" "$argument" "${1-}")" || return $?
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
    __throwArgument "$usage" "defaultButton $defaultButton is out of range 0 ... $maxChoice" || return $?
  fi
  messageText="$(escapeDoubleQuotes "$(printf "%s\\\n" "${message[@]}")")"
  quietErrors=$(fileTemporaryName "$usage") || return $?
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
    result="$(__catchEnvironment "$usage" osascript -e "$script" 2>"$quietErrors")" || _undo $? cat "$quietErrors" || return $?
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
          isBoolean "$value" || __throwEnvironment "$usage" "gave up should be a boolean: $value" || return $?
          ! "$value" || _return "$(_code timeout)" "Dialog timed out" || return $?
          ;;
        *)
          __throwEnvironment "$usage" "Unknown return value from dialog: $(decorate label "$name"): $(decorate value "$value")" || return $?
          ;;
      esac
    done <<<"$result"
    printf "%s\n" "$button"
  ) || _clean $? "$quietErrors" || return $?
}
_darwinDialog() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
