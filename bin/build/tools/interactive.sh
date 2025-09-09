#!/usr/bin/env bash
#
# Interactivity
#
# Copyright &copy; 2025 Market Acumen, Inc.
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
  __functionLoader __fileCopy interactive "$@"
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
# Exit Code: 0 - Success
# Exit Code: 1 - Failed
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
# Exit Code: 0 - Something would change
# Exit Code: 1 - Nothing would change
fileCopyWouldChange() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_fileCopyWouldChange() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} [ directoryOrFile ... ]
# Argument: directoryOrFile - Required. Exists. Directory or file to `source` `.sh` files found.
# Argument: --info - Optional. Flag. Show user what they should do (press a key).
# Argument: --no-info - Optional. Flag. Hide user info (what they should do ... press a key)
# Argument: --verbose - Optional. Flag. Show what is done as status messages.
# Argument: --clear - Optional. Flag. Clear the approval status for file given.
# Argument: --prefix - Optional. String. Display this text before each status messages.
# Security: Loads bash files
# Loads files or a directory of `.sh` files using `source` to make the code available.
# Has security implications. Use with caution and ensure your directory is protected.
approveBashSource() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_approveBashSource() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Notify after running a binary. Uses the `notify` hook with some handy paramters which are inherited
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
# Exit Code: 0 - Yes
# Exit Code: 1 - No
# Usage: {fn} [ --default defaultValue ] [ --yes ] [ --no ]
# Argument: --default defaultValue - Boolean. Optional. Value to return if no value given by user
# Argument: --attempts attempts - PositiveInteger. Optional. User can give us a bad response this many times before we return the default.
# Argument: --timeout seconds - PositiveInteger. Optional. Wait this long before choosing the default. If no default, default is --no.
# Argument: --yes - Boolean. Optional. Short for `--default yes`
# Argument: --no - Boolean. Optional. Short for `--default no`
# Example: Will time out after 10 seconds, regardless (user must make valid input in that time):
# Example:
# Example:     confirmYesNo --timeout 10 "Stop the timer!"
# Example:
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
# Exit code: interrupt - Attempts exceeded
# Exit code: timeout - Timeout
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
