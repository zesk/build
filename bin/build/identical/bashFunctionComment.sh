#!/bin/bash
#
# Identical template
#
# Original of usageDocument
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL bashFunctionComment EOF

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
  grep -m 1 -B $maxLines "^$functionName() {" "$source" | grep -v -e '\( IDENTICAL \|_IDENTICAL_\|DOC TEMPLATE:\|Internal:\|INTERNAL:\)' | fileReverseLines | sed -n -e '1d' -e '/^#/!q; p' | fileReverseLines | cut -c 3-
  # Explained:
  # - grep -m 1 ... - Finds the `function() {` string in the file and all lines afterwards
  # - grep -v ... - Removes internal documentation and anything we want to hide from the user
  # - fileReverseLines - First reversal to get that comment, file lines are reverse ordered
  # - sed 1d - Deletes the first line (e.g. the `function() { ` which was the LAST thing in the line and is now our first line
  # - sed -n '/^#/!q; p' - `-n` - disables automatic printing. /^#/!q quits when it does not match a '#' comment and prints all `#` lines (effectively outputting just the comment lines)
  # - fileReverseLines - File is back to normal
  # - cut -c 3- - Delete the first 2 characters on each line
}
_bashFunctionComment() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
