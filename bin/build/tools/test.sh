#!/usr/bin/env bash
#
# test.sh
#
# Test support functions
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh text.sh prefixLines
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

#
# dumpFile fileName0 [ fileName1 ... ]
#
dumpFile() {
  local nLines showLines=10 nBytes

  while [ $# -gt 0 ]; do
    if [ -f "$1" ]; then
      nLines=$(($(wc -l <"$1" | cut -f 1 -d' ') + 0))
      nBytes=$(($(wc -c <"$1") + 0))
      consoleInfo -n "$1"
      consoleSuccess -n ": $nLines $(plural "$nLines" line lines), $nBytes $(plural "$nBytes" byte bytes)"
      if [ $showLines -lt $nLines ]; then
        consoleWarning "(Showing $showLines)"
      else
        echo
      fi
      {
        echoBar " "
        head -$showLines "$1"
        echoBar " "
      } | prefixLines "$(consoleCode)    "
    else
      consoleError "dumpFile: $1 is not a file"
    fi
    shift
  done
}

#
# testShellScripts [ findArgs ]
#
# Requires shellcheck so should be later in the testing process to have a cleaner build
# This can be run on any directory tree to test scripts in any application.
#
# Side-effect: shellcheck is installed
#
testShellScripts() {
  local thisYear
  thisYear=$(date +%Y)
  if ! validateShellScripts "$@"; then
    return $errorEnvironment
  fi
  if ! validateFileContents sh -- "Copyright &copy; $thisYear" -- "$@"; then
    return $errorEnvironment
  fi
  printf "\n"
}

#
# validateShellScripts
#
# Requires shellcheck so should be later in the testing process to have a cleaner build
# This can be run on any directory tree to test scripts in any application.
#
# Usage: validateShellScripts [ findArgs ]
# Example:     if validateShellScripts; then git commit -m "saving things" -a; fi
# Argument: findArgs - Additional find arguments for .sh files (or exclude directories).
# Side-effect: shellcheck is installed
# Side-effect: Status written to stdout, errors written to stderr
# Environment: This operates in the current working directory
# Summary: Check files for the existence of a string
# Exit Code: 0 - All found files pass `shellcheck` and `bash -n`
# Exit Code: 1 - One or more files did not pass
# Output: This outputs `statusMessage`s to `stdout` and errors to `stderr`.
validateShellScripts() {
  local failedReasons thisYear f foundFiles
  whichApt shellcheck shellcheck
  whichApt pcre2grep pcre2-utils
  clearLine
  statusMessage consoleInfo "Checking all shellcheck and bash -n"

  thisYear=$(date +%Y)
  failedReasons=()
  foundFiles=$(mktemp)
  find . -name '*.sh' ! -path '*/.*' "$@" -print0 >"$foundFiles"
  while IFS= read -r -d '' f; do
    statusMessage consoleInfo "Checking $f"
    if ! bash -n "$f" >/dev/null; then
      failedReasons+=("bash -n $f")
    fi
    if ! shellcheck "$f" >/dev/null; then
      failedReasons+=("shellcheck $f")
    fi
    if pcre2grep -l -M '\n\}\n#' "$f"; then
      failedReasons+=("o $f # newline before comment start required")
    fi
  done <"$foundFiles"
  rm "$foundFiles"

  if [ "${#failedReasons[@]}" -gt 0 ]; then
    clearLine
    consoleError "# The following scripts failed:" 1>&2
    for f in "${failedReasons[@]}"; do
      echo "    $(consoleMagenta -n "$f")" 1>&2
    done
    consoleError "# ${#failedReasons[@]} $(plural ${#failedReasons[@]} error errors)" 1>&2
    return $errorEnvironment
  else
    statusMessage consoleSuccess "All scripts passed validation"
  fi
}

#
# Search for file extensions and ensure that text is found in each file.
#
# This can be run on any directory tree to test files in any application.
#
# By default, any directory which begins with a dot `.` will be ignored.
#
# Usage: validateFileContents extension0 [ extension1 ... ] -- text0 [ text1 ... ] [ -- findArgs ]
# Example:     validateFileContents sh php js -- 'Widgets LLC' 'Copyright &copy; 2024'
# Argument: `extension0` - Required - the extension to search for (`*.extension`)
# Argument: `--` - Required. Separates extensions from text
# Argument: `text0` - Required. Text which must exist in each file with the extension given.
# Argument: `--` - Optional. Final delimiter to specify find arguments.
# Argument: findArgs - Optional. Limit find to additional conditions.
# Side-effect: Errors written to stderr, status written to stdout
# Environment: This operates in the current working directory
# Summary: Check files for the existence of a string
# Exit Code: 0 - All found files contain all text strings
# Exit Code: 1 - One or more files does not contain all text strings
# Exit Code: 2 - Arguments error (missing extension or text)
#
validateFileContents() {
  local failedReasons f foundFiles
  local extensionArgs textMatches extensions

  extensionArgs=()
  extensions=()
  while [ $# -gt 0 ]; do
    if [ "$1" == "--" ]; then
      shift
      break
    fi
    extensions+=("$1")
    extensionArgs+=("-name" "*.$1" "-o")
    shift
  done
  unset 'extensionArgs['$((${#extensionArgs[@]} - 1))']'

  textMatches=()
  while [ $# -gt 0 ]; do
    if [ "$1" == "--" ]; then
      shift
      break
    fi
    textMatches+=("$1")
    shift
  done
  if [ "${#extensions[@]}" -eq 0 ]; then
    consoleError "No extension arguments" 1>&2
    return $errorArgument
  fi
  if [ "${#textMatches[@]}" -eq 0 ]; then
    consoleError "No text match arguments" 1>&2
    return $errorArgument
  fi

  failedReasons=()
  total=0
  foundFiles=$(mktemp)
  # Final arguments for find
  find . "${extensionArgs[@]}" ! -path '*/.*' "$@" >"$foundFiles"
  total=$(($(wc -l <"$foundFiles") + 0))
  # shellcheck disable=SC2059
  statusMessage consoleInfo "Searching $total $(plural $total file files) (ext: ${extensions[*]}) for text: $(printf " $(consoleReset)\"$(consoleCode "%s")\"" "${textMatches[@]}")"

  total=0
  while IFS= read -r f; do
    total=$((total + 1))
    for t in "${textMatches[@]}"; do
      if ! grep -q "$t" "$f"; then
        failedReasons+=("$f missing \"$t\"")
        statusMessage consoleError "Searching $f ... NOT FOUND"
      else
        statusMessage consoleSuccess "Searching $f ... found"
      fi
    done
  done <"$foundFiles"
  statusMessage consoleInfo "Checked $total $(plural $total file files) for ${#textMatches[@]} $(plural ${#textMatches[@]} phrase phrases)"
  rm "$foundFiles"

  if [ "${#failedReasons[@]}" -gt 0 ]; then
    clearLine
    consoleError "The following scripts failed:" 1>&2
    for f in "${failedReasons[@]}"; do
      echo "    $(consoleMagenta -n "$f")$(consoleInfo -n ", ")" 1>&2
    done
    consoleError "done." 1>&2
    return $errorEnvironment
  else
    statusMessage consoleSuccess "All scripts passed"
  fi
}
