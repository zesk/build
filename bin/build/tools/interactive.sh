#!/usr/bin/env bash
#
# Interactivity
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Depends: text.sh colors.sh
# bin: test echo printf
# Docs: o ./documentation/source/tools/interactive.md
# Test: o ./test/tools/interactive-tests.sh

####################################################################################################
####################################################################################################
#
# ▄▄▄                                      █
# ▀█▀       ▐▌                       ▐▌    ▀
#  █  ▐▙██▖▐███  ▟█▙  █▟█▌ ▟██▖ ▟██▖▐███  ██  ▐▙ ▟▌ ▟█▙
#  █  ▐▛ ▐▌ ▐▌  ▐▙▄▟▌ █▘   ▘▄▟▌▐▛  ▘ ▐▌    █   █ █ ▐▙▄▟▌
#  █  ▐▌ ▐▌ ▐▌  ▐▛▀▀▘ █   ▗█▀▜▌▐▌    ▐▌    █   ▜▄▛ ▐▛▀▀▘
# ▄█▄ ▐▌ ▐▌ ▐▙▄ ▝█▄▄▌ █   ▐▙▄█▌▝█▄▄▌ ▐▙▄ ▗▄█▄▖ ▐█▌ ▝█▄▄▌
# ▀▀▀ ▝▘ ▝▘  ▀▀  ▝▀▀  ▀    ▀▀▝▘ ▝▀▀   ▀▀ ▝▀▀▀▘  ▀   ▝▀▀
#
####################################################################################################
####################################################################################################
__interactiveLoader() {
  __buildFunctionLoader __fileCopy interactive "$@"
}

# Pause for user input
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: dashDashAllowsHelpParameters 1
# Argument: -- - Optional. Flag. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.
# Argument: message ... - Display this message while pausing
pause() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  [ "${1-}" != "--" ] || shift
  local prompt="${1-"PAUSE > "}"
  statusMessage printf -- "%s" "$prompt"
  bashUserInput
}
_pause() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

####################################################################################################
####################################################################################################

# Copy file from source to destination
#
# Supports mapping the file using the current environment, or escalated privileges.
# Usage: {fn} [ --map ] [ --escalate ] source destination
# Argument: --map - Flag. Optional. Map environment values into file before copying.
# Argument: --escalate - Flag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges.
# Argument: source - File. Required. Source path
# Argument: destination - File. Required. Destination path
# Return Code: 0 - Success
# Return Code: 1 - Failed
fileCopy() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_fileCopy() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Check whether copying a file would change it
# This function does not modify the source or destination.
# Usage: {fn} [ --map ] source destination
# Argument: --map - Flag. Optional. Map environment values into file before copying.
# Argument: source - File. Required. Source path
# Argument: destination - File. Required. Destination path
# Return Code: 0 - Something would change
# Return Code: 1 - Nothing would change
fileCopyWouldChange() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_fileCopyWouldChange() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: directoryOrFile - Required. Exists. Directory or file to `source` `.sh` files found.
# Argument: --info - Optional. Flag. Show user what they should do (press a key).
# Argument: --no-info - Optional. Flag. Hide user info (what they should do ... press a key)
# Argument: --verbose - Optional. Flag. Show what is done as status messages.
# Argument: --clear - Optional. Flag. Clear the approval status for file given.
# Argument: --prefix - Optional. String. Display this text before each status messages.
# Security: Loads bash files
# Loads files or a directory of `.sh` files using `source` to make the code available.
# Has security implications. Use with caution and ensure your directory is protected.
# DOC TEMPLATE: approvedCacheNote 4
# Approved sources are stored in a cache structure at `$XDG_STATE_HOME/.interactiveApproved`.
# Stale files are ones which no longer are associated with a file's current fingerprint.
# Environment: XDG_STATE_HOME
# See: XDG_STATE_HOME.sh
approveBashSource() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_approveBashSource() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List approved Bash script sources which can be loaded automatically by project hooks.
#
# Argument: --debug - Flag. Optional. Show a lot of information about the approved cache.
# Argument: --no-delete - Flag. Optional. Do not delete stale approval files.
# Argument: --delete - Flag. Optional. Delete stale approval files.
# DOC TEMPLATE: approvedCacheNote 4
# Approved sources are stored in a cache structure at `$XDG_STATE_HOME/.interactiveApproved`.
# Stale files are ones which no longer are associated with a file's current fingerprint.
# Environment: XDG_STATE_HOME
# See: XDG_STATE_HOME.sh
approvedSources() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_approvedSources() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Notify after running a binary. Uses the `notify` hook with some handy parameters which are inherited
# between "success" and "failure":
#
# - Upon success uses: `--message` `--title` `--sound`
# - Upon failure uses: `--fail-message` `--fail-title` `--fail-sound`
#
# If a value is not specified for failure, it will use the `success` value.
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Optional. Function. Use this error handler instead of the default error handler.
# Argument: --verbose - Flag. Optional. Be verbose.
# Argument: --title title - String. Optional. Sets the title for the notification.
# Argument: --message message - String. Optional. Display this message (alias is `-m`)
# Argument: --fail failMessage - String. Optional. Display this message in console and dialog upon failure.
# Argument: --sound soundName - String. Optional. Sets the sound played for the notification.
# Argument: --fail-title title - String. Optional. Sets the title for the notification if the binary fails.
# Argument: --fail-sound soundName - String. Optional. Sets the sound played for the notification if the binary fails.
notify() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_notify() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Read user input and return 0 if the user says yes, or non-zero if they say no
# Return Code: 0 - Yes
# Return Code: 1 - No
# Summary: Read user input and return success on yes
# Argument: --default defaultValue - Boolean. Optional. Value to return if no value given by user
# Argument: --attempts attempts - PositiveInteger. Optional. User can give us a bad response this many times before we return the default.
# Argument: --timeout seconds - PositiveInteger. Optional. Wait this long before choosing the default. If no default, default is --no.
# Argument: --info - Flag. Optional. Add `Type Y or N` as instructions to the user.
# Argument: --yes - Flag. Optional. Short for `--default yes`
# Argument: --no - Flag. Optional. Short for `--default no`
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Optional. Function. Use this error handler instead of the default error handler.
# Argument: message ... - String. Any additional arguments are considered part of the message.
# Example: Will time out after 10 seconds, regardless (user must make valid input in that time):
# Example:
# Example:     confirmYesNo --timeout 10 "Stop the timer!"
# Example:
confirmYesNo() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_confirmYesNo() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Ask the user for a menu of options
#
# Return Code: interrupt - Attempts exceeded
# Return Code: timeout - Timeout
# Argument: --choice choiceCharacter - Required. String. Character to accept.
# Argument: --default default - Optional. String. Character to choose when there is a timeout or other failure.
# Argument: --result resultFile - Required. File. File to write the result to.
# Argument: --attempts attemptCount - Optional. PositiveInteger. Number of attempts to try and get valid unput from the user.
# Argument: --timeout timeoutSeconds - Optional. PositiveInteger. Number of seconds to wait for user input before stopping.
# Argument: --prompt promptString - Optional. String. String to suffix the prompt with (usually tells the user what to do)
# Argument: message - Optional. String. Display this message as the confirmation menu.
confirmMenu() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_confirmMenu() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} loopCallable arguments ...
# Argument: loopCallable - Required. Callable. Call this on each file and a zero result code means passed and non-zero means fails.
# Argument: --delay delaySeconds - Optional. Integer. Delay in seconds between checks in interactive mode.
# Argument: --until exitCode - Optional. Integer. Check until exit code matches this.
# Argument: --title title - Optional. String. Display this title instead of the command.
# Argument: arguments ... - Optional. Arguments to loopCallable
# Run checks interactively until errors are all fixed.
loopExecute() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_loopExecute() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: loopCallable - Required. Callable. Call this on each file and a zero result code means passed and non-zero means fails.
# Argument: --exec binary - Optional. Callable. Run binary with files as an argument for any failed files. Only works if you pass in item names.
# Argument: --delay delaySeconds - Optional. Integer. Delay in seconds between checks in interactive mode.
# Argument: fileToCheck ... - Optional. File. Shell file to validate. May also supply file names via stdin.
# Run checks interactively until errors are all fixed.
# Not ready for prime time yet - written not tested.
interactiveManager() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_interactiveManager() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Display a message and count down display
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --badge text - String. Display this text as bigTextAt
# Argument: --prefix prefix - String.
# Argument: counter - Integer. Required. Count down from.
# Argument: binary - Callable. Required. Run this with any additional arguments when the countdown is completed.
# Argument: ... - Arguments. Optional. Passed to binary.
interactiveCountdown() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_interactiveCountdown() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Do something the first time and then only occasionally thereafter.
# This manages a state file compared to the current time and triggers after `delta` seconds.
# Think of it like something that only returns 0 like once every `delta` seconds but it's going to happen at minimum `delta` seconds, or the next time after that. And the first time as well.
# Argument: --delta deltaMilliseconds - PositiveInteger. Optional. Default is 60000.
# Argument: --mark - Flag. Optional. Write the marker which says the
# Argument: --verbose - Flag. Optional. Be chatty.
# Argument: name - EnvironmentVariable. Required. The global codename for this interaction.
# Return Code: 0 - Do the thing
# Return Code: 1 - Do not do the thing
# Return Code: 2 - Argument error
interactiveOccasionally() {
  local name="" delta="" verboseFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --delta) shift && delta="$(usageArgumentPositiveInteger "$handler" "$argument" "${1-}")" || return $? ;;
    --verbose) verboseFlag=true ;;
    *)
      if [ -z "$name" ]; then
        name="$(usageArgumentEnvironmentVariable "$handler" "$argument" "${1-}")" || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  [ -n "$name" ] || throwArgument "$handler" "name is required" || return $?
  [ -n "$delta" ] || delta=60000

  local cacheShown
  cacheShown="$(catchReturn "$handler" buildCacheDirectory "${FUNCNAME[0]}")/$name" || return $?

  ! $verboseFlag || printf "cacheFile: %s\n" "$(decorate file "$cacheShown")"

  local now lastShown
  now=$(timingStart)
  if [ -f "$cacheShown" ] && lastShown=$(head -n 1 "$cacheShown") && isInteger "$lastShown" && [ "$delta" -gt $((now - lastShown)) ]; then
    ! $verboseFlag || printf "NO: %s %s %s\n" "$(decorate code "$lastShown")" "Now: $(decorate info "$now")" "Delta: $(decorate value "$((now - lastShown)) ($delta)")"
    # Show
    return 1
  else
    # Show occasional stuff, mark as shown
    ! $verboseFlag || printf "YES: %s %s %s\n" "$(decorate code "$lastShown")" "Now: $(decorate info "$now")" "Delta: $(decorate value "$((now - lastShown)) ($delta)")"
    catchEnvironment "$handler" printf "%s\n" "$now" >"$cacheShown" || return $?
    return 0
  fi
}
_interactiveOccasionally() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
