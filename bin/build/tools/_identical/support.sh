#!/usr/bin/env bash
#
# Identical support functions
#
# Ensuring a directory of files has sections which match identically
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Usage: {fn} file prefix identicalLine
# May return non-integer count and should be tested by calling function
# Argument: file - String. Required. File being parsed for debugging output.
# Argument: prefix - String. Required. Identical prefix being processed currently.
# Argument: identicalLine - String. Required. Identical line being parsed. Should have line number before line with a `:` after the line number.
# stdout: lineNumber token count
# stdout: lineNUmber - PositiveInteger. Line number of the parsed line.
# stdout: token - String. Token of the matched line.
# stdout: count - PositiveInteger|String. "EOF" or a positive integer.
__identicalLineParse() {
  local handler="${1-}" && shift
  local file="${1-}" && shift
  local prefix="${1-}" && shift
  local identicalLine="${1-}" && shift
  local lineNumber=${identicalLine%%:*}

  if ! isUnsignedInteger "$lineNumber"; then
    returnThrowArgument "$handler" "\"$identicalLine\" no line number: \"$lineNumber\"" || return $?
  fi
  # Trim line number from beginning of line
  identicalLine=${identicalLine#*:}

  # Remove token identifier
  identicalLine="${identicalLine/"$prefix"/}"
  # And whitespace
  identicalLine="$(trimSpace "$identicalLine")"

  local token line0 line1 _extras
  read -r token line0 line1 _extras <<<"$identicalLine" || :
  : "$_extras"
  local count
  if [ "$line0" = "EOF" ]; then
    count="EOF"
  elif isInteger "$line0"; then
    # Allow non-numeric token after numeric (markup)
    if isInteger "$line1"; then
      if [ "$line0" -ge "$line1" ]; then
        returnThrowEnvironment "$handler" "$(decorate code "$file:$lineNumber") - line numbers out of order: $(decorate each value "$line0 $line1")" || return $?
      fi
      count=$((line1 - line0))
    else
      count="$line0"
    fi
  else
    returnThrowEnvironment "$handler" "$(decorate code "$file:$lineNumber") prefix=\"$prefix\" \"$identicalLine\" Invalid token count: $line0 $line1" || return $?
  fi
  printf "%d %s %s\n" "$lineNumber" "$token" "$count"
}

# Usage: {fn} count remainingLines
# stdout: count - UnsignedInteger|String. "EOF" or a positive integer of the line count.
# stdout: remainingLines - Integer. The actual remaining lines in the file after the token.
# Handles converting EOF to `remainingLines`
# stdout: UnsignedInteger - IFF `count` is `EOF` prints `remainingLines` - returns 0
# stdout: UnsignedInteger - IFF `count` is UnsignedInteger prints `count` - returns 0
# stdout: String - IFF `count` is not EOF or UnsignedInteger prints `count` (string) - returns 1
__identicalLineCount() {
  if [ "$1" != "EOF" ]; then
    if isUnsignedInteger "$1"; then
      printf "%d\n" "$1"
    else
      printf "%s\n" "$1"
      return 1
    fi
  else
    printf "%d\n" "$2"
  fi
}

# Usage: {fn} searchFile lineNumber totalLines count
# Generate the match file given the search file
# Argument: file - String. Required. File being processed for identical.
# Argument: totalLines - UnsignedInteger. Required. Number of lines in the entire file.
# Argument: lineNumber - UnsignedInteger. Required. Line number of the found token.
# Argument: count - UnsignedInteger. Required. Number of lines this token should have.
__identicalCheckMatchFile() {
  local searchFile="$1" totalLines="$2" lineNumber="$3" count="$4"
  if fileEndsWithNewline "$searchFile"; then
    tail -n $((totalLines - lineNumber)) <"$searchFile" | head -n "$count"
  else
    tail -n $((totalLines + 1 - lineNumber)) <"$searchFile" | head -n "$count"
  fi
  return 0

  # TODO: This returns error 1 inside a container, so forced return 0. KMD 2024-09-16
  # Should not likely have return 0 but this avoids the error
  # The errors in question is
  # 1. #1: Processing /opt/atlassian/bitbucketci/agent/build/OMNI/domains.tf:9:  # IDENTICAL domainSuffix 6 ... __identicalCheckMatchFile "/opt/atlassian/bitbucketci/agent/build/OMNI/domains.tf" "320" "9" "6" (->  1 )
  # 1. /opt/atlassian/bitbucketci/agent/build/bin/build/tools.sh "identicalCheck" "--ignore-singles" "--repair" "./bin/infrastructure/identical" "--repair" "/opt/atlassian/bitbucketci/agent/build/etc/identical" "--extension" "tf" "--prefix" "# IDENTICAL" "./GLOBAL" "./infrastructure" "./modules" (->  1 )
  # 1. maiIdentical "" (->  1 )
  # File contains 320 lines, so
  # > tail -n $((320 - 9)) /opt/atlassian/bitbucketci/agent/build/OMNI/domains.tf | head -n 6
  # Works AOK anywhere else. So maybe mounted file system error in Docker?
}
