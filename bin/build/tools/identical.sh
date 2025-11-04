#!/usr/bin/env bash
#
# Identical support functions
#
# Ensuring a directory of files has sections which match identically
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

#   _     _            _   _           _
#  (_) __| | ___ _ __ | |_(_) ___ __ _| |
#  | |/ _` |/ _ \ '_ \| __| |/ __/ _` | |
#  | | (_| |  __/ | | | |_| | (_| (_| | |
#  |_|\__,_|\___|_| |_|\__|_|\___\__,_|_|
#

# Loads identical code
# Argument: handler - Function. Required. Error handler.
# Argument: function - Function. Required. Function to call; first argument will be `handler`.
# Argument ... - Arguments. Optional. Additional arguments to the function.
__identicalLoader() {
  __buildFunctionLoader __identicalLineParse _identical "$@"
}

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

# Usage: {fn} --extension extension0 --prefix prefix0  [ --cd directory ] [ --extension extension1 ... ] [ --prefix prefix1 ... ]
# Argument: --extension extension - Required. String. One or more extensions to search for in the current directory.
# Argument: --prefix prefix - Required. String. A text prefix to search for to identify identical sections (e.g. `# IDENTICAL`) (may specify more than one)
# Argument: --exclude pattern - Optional. String. One or more patterns of paths to exclude. Similar to pattern used in `find`.
# Argument: --cd directory - Optional. Directory. Change to this directory before running. Defaults to current directory.
# Argument: --repair directory - Optional. Directory. Any files in onr or more directories can be used to repair other files.
# Argument: --token token - Optional. String. ONLY do this token. May be specified more than once.
# Argument: --skip file - Optional. Directory. Ignore this file for repairs.
# Argument: --ignore-singles - Optional. Flag. Skip the check to see if single entries exist.
# Argument: --no-map - Optional. Flag. Do not map __BASE__, __FILE__, __DIR__ tokens.
# Argument: --debug - Optional. Additional debugging information is output.
# Argument: --help - Optional. Flag. This help.
# Argument: --singles singlesFiles - Optional. File. One or more files which contain a list of allowed `{identical}` singles, one per line.
# Argument: --single singleToken - Optional. String. One or more tokens which cam be singles.
#
# Return Code: 2 - Argument error
# Return Code: 0 - Success, everything matches
# Return Code: 100 - Failures
#
# When, for whatever reason, you need code to match between files, add a comment in the form:
#
#     # {identical} tokenName n
#
# Where `tokenName` is unique to your project, `n` is the number of lines to match. All found sets of lines in this form
# must match each other set of lines with the same prefix, otherwise errors and details about failures are printed to stdout.
#
# The command to then check would be:
#
#     {fn} --extension sh --prefix '# {identical}'
#
# This is largely useful for projects in which specific functions are replicated between scripts for code independence, yet
# should remain identical.
#
# Mapping also automatically handles file names and paths, so using the token `__FILE__` within your identical source
# will convert to the target file's application path.
#
# Failures are considered:
#
# - Partial success, but warnings occurred with an invalid number in a file
# - Two code instances with the same token were found which were not identical
# - Two code instances with the same token were found which have different line counts
#
# This is best used as a pre-commit check, for example.
# See: identicalWatch
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
# - `# ``{identical} tokenName 1`
# - `# ``_{identical}_ tokenName 1`, and
# - `# ``DOC`` TEMPLATE: tokenName 1`
#
# This allows for overlapping identical sections within templates with the intent:
#
# - `{identical}` - used in most cases (not internal)
# - `_{identical}_` - used in templates which must be included in {identical} templates
# - `__{identical}__` - used in templates which must be included in _{identical}_ templates
# - `DOC`` TEMPLATE:` - used in documentation templates for functions - is handled by internal document generator
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --singles singlesFiles - Optional. File. One or more files which contain a list of allowed `{identical}` singles, one per line.
# Argument: --single singleToken - Optional. String. One or more tokens which cam be singles.
# Argument: --repair directory - Optional. Directory. Any files in onr or more directories can be used to repair other files.
# Argument: --internal - Flag. Optional. Do updates for `# _{identical}_` and `# DOC TEMPLATE:` prefixes first.
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
