#!/bin/bash
#
# Original of bashFinalComment bashFunctionComment
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL bashFunctionComment EOF

# Extracts the final comment from a stream
# Requires: fileReverseLines sed cut grep convertValue
bashFinalComment() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  grep -v -e '\( IDENTICAL \|_IDENTICAL_\|DOC TEMPLATE:\|Internal:\|INTERNAL:\)' | fileReverseLines | sed -n -e 1d -e '/^[[:space:]]*#/ { p'$'\n''b'$'\n''}; q' | sed 's/^[[:space:]]*//' | fileReverseLines | cut -c 3- || :
  # Explained:
  # - grep -v ... - Removes internal documentation and anything we want to hide from the user
  # - fileReverseLines - First reversal to get that comment, file lines are reverse ordered
  # - sed 1d - Deletes the first line (e.g. the `function() { ` which was the LAST thing in the line and is now our first line
  # - `-n` - disables automatic printing. /^#/!q quits when it does not match a '#' comment and prints all `#` lines (effectively outputting just the comment lines)
  # - `'/^[[:space:]]*#/ { p'$'\n''b'$'\n''}; q'` - while matching `[space]#` print lines then quit when does not match
  # - fileReverseLines - File is back to normal
  # - cut -c 3- - Delete the first 2 characters on each line
}
_bashFinalComment() {
  ! false || bashFinalComment --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Extract a bash comment from a file. Excludes lines containing the following tokens:
#
# - `" IDENTICAL "` or `"_IDENTICAL_"`
# - `"Internal:"` or `"INTERNAL:"`
# - `"DOC TEMPLATE:"`
#
# Argument: source - File. Required. File where the function is defined.
# Argument: functionName - String. Required. The name of the bash function to extract the documentation for.
# Requires: grep cut fileReverseLines __help
# Requires: usageDocument
bashFunctionComment() {
  local source="${1-}" functionName="${2-}"
  local maxLines=1000
  __help "_${FUNCNAME[0]}" "$@" || return 0
  grep -m 1 -B $maxLines -e "^\s*$functionName() {" "$source" | bashFinalComment
  # Explained:
  # - grep -m 1 ... - Finds the `function() {` string in the file and all lines beforehand (up to 1000 lines)
}
_bashFunctionComment() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
