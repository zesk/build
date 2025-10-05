#!/usr/bin/env bash
#
# Bash Prompt Module API calls
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/prompt.md
# Test: ./test/tools/prompt-tests.sh

# Summary: Background process manager for shell
# Run a single process in the background continuously until a condition is met.
#
# `condition` and `command` required when an action flag is not specified.
#
# Action flags:
#
#     --go --report --monitor --verbose-toggle --stop-all --summary
#
# This can be used to run processes on your code in the background.
#
# The `condition` should output *any* form of output which, when it changes (or exits non-zero), will require the `command` to be run.
# As long as the `condition` remains the same between calls, `command` is not run.
#
# Once `command` is run the process is monitored; and every `stopSeconds` seconds `condition` is run again - if `condition` changes
# between the starting value and the new value then the command is terminated. The manager waits `waitSeconds` and then runs `command`
# again. (Capturing `condition` at the start.)
#
# If `condition` exits zero – then it is simply run every `checkSeconds` seconds to see if `command` needs to be run again.
#
# This allows you to have background processes which, while you edit your code, for example, will pause momentarily while you edit and not use up
# all of your available CPU.
#
# To see status, try:
#
#     {fn} --summary
#     {fn} --report
#     {fn} --monitor
#     {fn} --watch
#
# Argument: --verbose - Flag. Optional. Be verbose.
# Argument: --report - Flag. Optional. Show a long report of all processes.
# Argument: --summary - Flag. Optional. Show a summary of all processes.
# Argument: --monitor - Flag. Optional. Interactively show report and refresh.
# Argument: --watch - Flag. Optional. Repeat showing summary.
# Argument: --verbose-toggle - Flag. Optional. Toggle the global verbose reporting.
# Argument: --terminate - Flag. Optional. Terminate all processes and delete all background process records.
# Argument: --go - Flag. Optional. Check all process states and update them.
# Argument: --stop stopSeconds - PositiveInteger. Optional. Check every stop seconds after starting to see if should be stopped.
# Argument: --wait waitSeconds - PositiveInteger. Optional. After stopping, wait this many seconds before trying again.
# Argument: --frequency checkSeconds - PositiveInteger. Optional. Check condition at this frequency.
# Argument: condition ... - Callable. Required. Condition to test. Output of this is compared to see if we should stop process and restart it.
# Argument: -- - Delimiter. Required. Separates command.
# Argument: command ... - Callable. Required. Function to run in the background.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
backgroundProcess() {
  __promptLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_backgroundProcess() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Watch or more directories for changes in a file extension and reload a source file if any changes occur.
# Argument: --source source - Required. File. Source file to source upon change.
# Argument: --name name - Optional. String. The name to call this when changes occur.
# Argument: --path path - Required. Directory. OneOrMore. A directory to scan for changes in `.sh` files
# Argument: --file file - Required. File. OneOrMore. A file to watch.å
# Argument: --stop - Flag. Optional. Stop watching changes and remove all watches.
# Argument: --show - Flag. Optional. Show watched settings and exit.
# Argument: source - File. Optional. If supplied directly on the command line, sets the source.
# Argument: path|file ... - DirectoryOrFile. Optional. If `source` supplied, then any other command line argument is treated as a path to scan for changes.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
reloadChanges() {
  __promptLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_reloadChanges() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Watches your HOME directory for `.` files which are added and unknown to you.
#
# Example:     bashPrompt bashPromptModule_dotFilesWatcher
# Requires: sort buildEnvironmentGetDirectory touch returnEnvironment read basename inArray decorate printf confirmYesNo statusMessage grep rm
bashPromptModule_dotFilesWatcher() {
  __promptLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_bashPromptModule_dotFilesWatcher() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# The dot files approved file. Add files to this to approve.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
dotFilesApprovedFile() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf "%s\n" "$(buildEnvironmentGetDirectory "XDG_DATA_HOME")/dotFilesWatcher"
}
_dotFilesApprovedFile() {
  true || dotFilesApprovedFile --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Lists of dot files which can be added to the dotFilesApprovedFile
# Argument: listType - String. Optional. One of `all`, `bash`, `git`, `darwin`, or `mysql`
# If none specified, returns `bash` list.
# Special value `all` returns all values
dotFilesApproved() {
  __promptLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_dotFilesApproved() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
