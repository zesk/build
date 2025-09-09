#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__reloadChangesLoader() {
  __functionLoader __bashPromptModule_reloadChanges prompt/modules/reload-changes "$@"
}

# Watch or more directories for changes in a file extension and reload a source file if any changes occur.
# Argument: --source source - Required. File. Source file to source upon change.
# Argument: --name name - Optional. String. The name to call this when changes occur.
# Argument: --path path - Required. Directory. OneOrMore. A directory to scan for changes in `.sh` files
# Argument: --stop - Flag. Optional. Stop watching changes and remove all watches.
# Argument: --show - Flag. Optional. Show watched settings and exit.
# Argument: source - File. Optional. If supplied directly on the command line, sets the source.
# Argument: path ... - Directory. Optional. If `source` supplied, then any other command line argument is treated as a path to scan for changes.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
reloadChanges() {
  __reloadChangesLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_reloadChanges() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
