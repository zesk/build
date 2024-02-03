#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
#
# Docs: o ./docs/_templates/tools/security.md
# Test: o ./test/tools/security-tests.sh

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# I DENTICAL errorArgument 1
#errorArgument=2

_doEvalCheck() {
  local firstLine checkLine checkLineFailed tempResults exitCode

  if ! tempResults=$(mktemp); then
    consoleError "mktemp Failed" 1>&2
    return "$errorEnvironment"
  fi
  exitCode=0
  if ! grep -n -B 1 -e '^[^#]*\seval "' <"$1" >"$tempResults"; then
    rm -f "$tempResults" || :
    return "$exitCode"
  fi
  firstLine=1
  if ! while read -r line; do
    lineNo="${line%%:*}"
    if [ "$lineNo" = "$line" ]; then
      # grep uses - for non-matching lines and : for matching ones
      lineNo="${line%%-*}"
      if [ -z "$lineNo" ]; then
        firstLine=1
        continue
      fi
      if [ "$lineNo" = "$line" ]; then
        consoleError "Unable to parse line: $line" 1>&2
        return $errorEnvironment
      fi
      line="${line#-*}"
    else
      line="${line#:*}"
    fi
    if test $firstLine; then
      checkLineFailed=
      checkLine="${line##*evalCheck:}"
      if [ "$checkLine" = "$line" ]; then
        checkLineFailed=1
      else
        checkLine="$(trimSpace "$checkLine")" || :
      fi
      firstLine=
    else
      if test "$checkLineFailed"; then
        printf "%s in %s line %s: %s\n" "$(consoleError "Unchecked eval")" "$(consoleInfo "$1")" "$(consoleBlue "$lineNo")" "$(consoleCode "$line")"
      else
        printf "%s in %s line %s: %s\n" "$(consoleSuccess "evalCheck FOUND")" "$(consoleInfo "$1")" "$(consoleBlue "$lineNo")" "$(consoleCode "$checkLine")"
        return 1
      fi
    fi
  done <"$tempResults"; then
    exitCode=1
  fi
  # wrapLines "    $(consoleCode)" "$(consoleReset)" <"$tempResults"
  rm "$tempResults" || :
  return "$exitCode"
}

evalCheck() {
  local fileName
  if [ $# -gt 0 ]; then
    while [ $# -gt 0 ]; do
      consoleInfo "Checking $1"
      if ! _doEvalCheck "$1"; then
        consoleError "Failed"
        return 1
      fi
      shift
    done
  else
    while IFS= read -r fileName; do
      consoleInfo "Checking $fileName"
      if ! _doEvalCheck "$fileName"; then
        consoleError "Failed"
        return 1
      fi
    done
  fi
}
