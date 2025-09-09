#!/usr/bin/env bash
#
# Identical support functions
#
# Ensuring a directory of files has sections which match identically
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Usage: {fn} token source destination
# Repair an identical `token` in `destination` from `source`
# Argument: --prefix prefix - Required. A text prefix to search for to identify identical sections (e.g. `# {identical}}`) (may specify more than one)
# Argument: token - String. Required. The token to repair.
# Argument: source - Required. File. The token file source. First occurrence is used.
# Argument: destination - Required. File. The token file to repair. Can be same as `source`.
# Argument: --stdout - Optional. Flag. Output changed file to `stdout`
identicalRepair() {
  __identicalLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_identicalRepair() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

identicalCheck() {
  __identicalLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_identicalCheck() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Identical check for shell files
#
# Looks for up to three tokens in code:
#
# - `# ``IDENTICAL tokenName 1`
# - `# ``_IDENTICAL_ tokenName 1`, and
# - `# ``DOC TEMPLATE: tokenName 1`
#
# This allows for overlapping identical sections within templates with the intent:
#
# - `IDENTICAL` - used in most cases (not internal)
# - `_IDENTICAL_` - used in templates which must be included in IDENTICAL templates (INTERNAL)
# - `__IDENTICAL__` - used in templates which must be included in _IDENTICAL_ templates (INTERNAL)
# - `DOC TEMPLATE:` - used in documentation templates for functions - is handled by internal document generator (INTERNAL)
#
# handler: {fn} [ --repair repairSource ] [ --help ] [ --interactive ] [ --check checkDirectory ] ...
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --singles singlesFiles - Optional. File. One or more files which contain a list of allowed `IDENTICAL` singles, one per line.
# Argument: --single singleToken - Optional. String. One or more tokens which cam be singles.
# Argument: --repair directory - Optional. Directory. Any files in onr or more directories can be used to repair other files.
# Argument: --internal - Flag. Optional. Do updates for `# _IDENTICAL_` and `# DOC TEMPLATE:` prefixes first.
# Argument: --internal-only - Flag. Optional. Just do `--internal` repairs.
# Argument: --interactive - Flag. Optional. Interactive mode on fixing errors.
# Argument: ... - Optional. Additional arguments are passed directly to `identicalCheck`.
identicalCheckShell() {
  __identicalLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_identicalCheckShell() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: --prefix prefix - Required. String. A text prefix to search for to identify identical sections (e.g. `# IDENTICAL`) (may specify more than one)
# Argument: file ... - Required. File. A file to search for identical tokens.
# stdout: tokens, one per line
identicalFindTokens() {
  __identicalLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_identicalFindTokens() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
#
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Optional. Function. Use this error handler instead of the default error handler.
# Argument: ... - Arguments. Required. Arguments to `identicalCheck` for your watch.
# Watch a project for changes and propagate them immediately upon save. Can be quite dangerous so use with caution.
# Still a known bug which trims the last end bracket from files
identicalWatch() {
  __identicalLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_identicalWatch() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Loads identical code
# Argument: handler - Function. Required. Error handler.
# Argument: function - Function. Required. Function to call; first argument will be `handler`.
# Argument ... - Arguments. Optional. Additional arguments to the function.
__identicalLoader() {
  __functionLoader __identicalLineParse _identical "$@"
}

