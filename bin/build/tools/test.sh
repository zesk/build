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
      } | wrapLines "$(consoleCode)    " "$(consoleReset)"
    else
      consoleError "dumpFile: $1 is not a file"
    fi
    shift
  done
}

#
# validateShellScripts
#
# Requires shellcheck so should be later in the testing process to have a cleaner build
# This can be run on any directory tree to test scripts in any application.
#
# Usage: validateShellScripts [ --exec binary ] [ file0 ... ]
# Example:     if validateShellScripts; then git commit -m "saving things" -a; fi
# Argument: --exec binary - Run binary with files as an argument for any failed files. Only works if you pass in file names.
# Argument: findArgs - Additional find arguments for .sh files (or exclude directories).
# Side-effect: shellcheck is installed
# Side-effect: Status written to stdout, errors written to stderr
# Environment: This operates in the current working directory
# Summary: Check files for the existence of a string
# Exit Code: 0 - All found files pass `shellcheck` and `bash -n`
# Exit Code: 1 - One or more files did not pass
# Output: This outputs `statusMessage`s to `stdout` and errors to `stderr`.
validateShellScripts() {
  local arg failedFiles failedReason failedReasons binary interactive sleepDelay prefix

  if ! buildEnvironmentLoad BUILD_INTERACTIVE_REFRESH; then
    return $errorEnvironment
  fi
  clearLine
  sleepDelay="$BUILD_INTERACTIVE_REFRESH"
  statusMessage consoleInfo "Checking all shell scripts ..."
  failedReasons=()
  failedFiles=()
  binary=
  if [ $# -eq 0 ]; then
    while read -r f; do
      statusMessage consoleInfo "Checking $f ..."
      if ! failedReason=$(validateShellScript "$f"); then
        failedReasons+=("$failedReason")
      fi
    done
  else
    while [ $# -gt 0 ]; do
      arg="$1"
      if [ -z "$arg" ]; then
        "_${FUNCNAME[0]}" "$errorArgument" "blank argument" || return $?
      fi
      case "$arg" in
        --delay)
          shift || "_${FUNCNAME[0]}" "$errorArgument" "$arg missing" || return $?
          sleepDelay="$1"
          ;;
        --exec)
          shift || "_${FUNCNAME[0]}" "$errorArgument" "$arg missing" || return $?
          binary="${1}"
          if ! isCallable "$binary"; then
            "_${FUNCNAME[0]}" "$errorArgument" "--exec $binary is not callable" || return $?
          fi
          ;;
        --interactive)
          interactive=true
          ;;
        *)
          statusMessage consoleInfo "Checking $arg ..."
          if ! failedReason=$(validateShellScript "$arg"); then
            failedFiles+=("$arg")
            failedReasons+=("$failedReason")
          fi
          ;;
      esac
      shift || "_${FUNCNAME[0]}" "$errorArgument" "shift failed" || return $?
    done
  fi
  if ! sleepDelay=$(usageArgumentUnsignedInteger "_${FUNCNAME[0]}" "sleepDelay" "$sleepDelay"); then
    return $errorArgument
  fi

  if [ "${#failedReasons[@]}" -gt 0 ]; then
    prefix="$(consoleBoldRed "- ")"

    clearLine
    consoleError "# The following scripts failed:" 1>&2
    for arg in "${failedReasons[@]}"; do
      echo "    $(consoleMagenta -n "$arg")" 1>&2
    done
    consoleError "# ${#failedReasons[@]} $(plural ${#failedReasons[@]} error errors)" 1>&2
    if ! "$interactive" [ -n "$binary" ]; then
      if [ ${#failedFiles[@]} -gt 0 ]; then
        "$binary" "${failedFiles[@]}"
      fi
    fi
    if $interactive; then
      validateShellScriptsInteractive "$sleepDelay" "${failedFiles[@]}"
    fi
    return $errorEnvironment
  fi
  statusMessage consoleSuccess "All scripts passed validation"
}
_validateShellScripts() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

validateShellScriptsInteractive() {
  local sleepDelay

  sleepDelay=$1
  shift || :

  printf "%s\n%s\n%s\n" "$(consoleRed "BEFORE")" \
    "$(consoleLabel "Queue")" \
    "$(consoleSubtle "$(printf "$prefix%s\n" "$@")")"

  while [ "$#" -gt 0 ]; do
    printf "%s\n%s\n%s\n" "$(consoleRed "LOOP")" \
      "$(consoleLabel "Queue")" \
      "$(consoleSubtle "$(printf "$prefix%s\n" "$@")")"

    arg="$1"
    if [ -z "$arg" ]; then
      shift
      contiuhe
    fi
    consoleBlue "$(echoBar "+-")"
    consoleInfo "$# $(plural $# file files) remain"
    if failedReason=$(validateShellScript --verbose "$1"); then
      bigText "SUCCESS $(basename "$arg")" | wrapLines "$(consoleGreen)" "$(consoleReset)"
      boxedHeading "$arg now passes" | wrapLines "$(consoleBoldGreen)" "$(consoleReset)"
      shift
      consoleOrange "$(echoBar "*")"
    else
      bigText "FAIL $(basename "$arg")" | wrapLines "$(consoleSubtle shellcheck)  $(consoleBoldRed)" "$(consoleReset)"
      printf "%s\n%s\n%s\n" "$(consoleRed "$failedReason")" \
        "$(consoleLabel "Queue")" \
        "$(consoleSubtle "$(printf "$prefix%s\n" "${failedFiles[@]+${failedFiles[@]}}")")"

      sleep "$sleepDelay"
      clear
    fi
  done
}

#
# Usage: {fn} [ script ... ]
#
# Requires shellcheck so should be later in the testing process to have a cleaner build
# This can be run on any directory tree to test scripts in any application.
# Shell comments must not be immediately after a function end, e.g. this is invalid:
#
#     myFunc() {
#     }
#     # Hey
#
# Example:     validateShellScript goo.sh
# Argument: script - Shell script to validate
# Side-effect: shellcheck is installed
# Side-effect: Status written to stdout, errors written to stderr
# Exit Code: 0 - All found files pass `shellcheck` and `bash -n` and shell comment syntax
# Exit Code: 1 - One or more files did not pass
# Output: This outputs `statusMessage`s to `stdout` and errors to `stderr`.
validateShellScript() {
  local f

  if ! whichApt shellcheck shellcheck; then
    _validateShellScript "$errorEnvironment" "Can not install shellcheck" || return $?
  fi
  if ! whichApt pcregrep pcregrep; then
    _validateShellScript "$errorEnvironment" "Can not install pcregrep" || return $?
  fi

  exec 3>/dev/null
  while [ $# -gt 0 ]; do
    arg="$1"
    if [ -z "$arg" ]; then
      _validateShellScript "$errorArgument" "blank argument" || return $?
    fi
    case "$arg" in
      --verbose)
        consoleWarning "Verbose on"
        exec 3>&1
        ;;
      *)
        f="$1"
        if [ ! -f "$f" ]; then
          printf "%s: %s" "$(consoleError "Not a file")" "$(consoleCode "$f")"
          return "$errorEnvironment"
        fi
        # shellcheck disable=SC2210
        if ! bash -n "$f" 1>&3; then
          printf "%s %s\n" "$(consoleError "bash -n")" "$(consoleCode "$f")"
          return "$errorEnvironment"
        fi

        # shellcheck disable=SC2210
        if ! shellcheck "$f" 1>&3; then
          printf "%s %s" "$(consoleError "shellcheck")" "$(consoleCode "$f")"
          return "$errorEnvironment"
        fi
        if pcregrep -l -M '\n\}\n#' "$f"; then
          printf "contextOpen %s # newline before comment start required" "$f"
          return "$errorEnvironment"
        fi
        ;;
    esac
    shift
  done
}
_validateShellScript() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Search for file extensions and ensure that text is found in each file.
#
# This can be run on any directory tree to test files in any application.
#
# By default, any directory which begins with a dot `.` will be ignored.
#
# Usage: {fn} file0 [ file1 ... ] -- text0 [ text1 ... ]
# Example:     {fn} foo.sh my.sh -- "Copyright 2024" "Company, LLC"
# Argument: `file0` - Required - a file to look for matches in
# Argument: `--` - Required. Separates files from text
# Argument: `text0` - Required. Text which must exist in each file
# Side-effect: Errors written to stderr, status written to stdout
# Summary: Check files for the existence of a string or strings
# Exit Code: 0 - All found files contain all text string or strings
# Exit Code: 1 - One or more files does not contain all text string or strings
# Exit Code: 2 - Arguments error (missing extension or text)
#
validateFileContents() {
  local fileArgs f total

  local textMatches t binary
  local failedReasons failedFiles

  fileArgs=()
  while [ $# -gt 0 ]; do
    if [ "$1" == "--" ]; then
      shift || :
      break
    fi
    if [ -z "$1" ]; then
      _validateFileContents "$errorArgument" "Blank argument" || return $?
    fi
    case "$1" in
      --)
        shift
        break
        ;;
      --exec)
        shift || :
        binary="$1"
        if ! isCallable "$binary"; then
          _validateFileContents "$errorArgument" "--exec $binary Not callable" || return $?
        fi
        ;;
      *)
        if ! usageArgumentFile _validateFileContents "file${#fileArgs[@]}" "$1" >/dev/null; then
          return $?
        fi
        fileArgs+=("$1")
        ;;
    esac
    shift || :
  done

  textMatches=()
  while [ $# -gt 0 ]; do
    if [ "$1" == "--" ]; then
      shift
      break
    fi
    if [ -z "$1" ]; then
      _validateFileContents "$errorArgument" "Zero size text match passed"
      return $?
    fi
    textMatches+=("$1")
    shift
  done
  if [ "${#fileArgs[@]}" -eq 0 ]; then
    _validateFileContents "$errorArgument" "No extension arguments" 1>&2
    return $?
  fi
  if [ "${#textMatches[@]}" -eq 0 ]; then
    _validateFileContents "$errorArgument" "No text match arguments" 1>&2
    return $?
  fi

  failedReasons=()
  failedFiles=()
  total=0
  total="${#fileArgs[@]}"
  # shellcheck disable=SC2059
  statusMessage consoleInfo "Searching $total $(plural "$total" file files) for text: $(printf " $(consoleReset)\"$(consoleCode "%s")\"" "${textMatches[@]}")"

  total=0
  for f in "${fileArgs[@]}"; do
    total=$((total + 1))
    for t in "${textMatches[@]}"; do
      if ! grep -q "$t" "$f"; then
        failedReasons+=("$f missing \"$t\"")
        statusMessage consoleError "Searching $f ... NOT FOUND"
        failedFiles+=("$f")
      else
        statusMessage consoleSuccess "Searching $f ... found"
      fi
    done
  done
  statusMessage consoleInfo "Checked $total $(plural $total file files) for ${#textMatches[@]} $(plural ${#textMatches[@]} phrase phrases)"

  if [ "${#failedReasons[@]}" -gt 0 ]; then
    clearLine
    consoleError "The following scripts failed:" 1>&2
    for f in "${failedReasons[@]}"; do
      echo "    $(consoleMagenta -n "$f")$(consoleInfo -n ", ")" 1>&2
    done
    consoleError "done." 1>&2
    if [ -n "$binary" ]; then
      "$binary" "${failedFiles[@]}"
    fi
    return $errorEnvironment
  else
    statusMessage consoleSuccess "All scripts passed"
  fi
}
_validateFileContents() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Search for file extensions and ensure that text is found in each file.
#
# This can be run on any directory tree to test files in any application.
#
# By default, any directory which begins with a dot `.` will be ignored.
#
# Usage: validateFileExtensionContents extension0 [ extension1 ... ] -- text0 [ text1 ... ] [ -- findArgs ]
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
validateFileExtensionContents() {
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

#
# Usage: {fn} [ --exec binary ] [ directory ]
#
findUncaughtAssertions() {
  local listFlag binary directory problemFiles lastProblemFile problemLine problemLines

  # --list
  listFlag=

  # --exec
  binary=
  # Argument
  directory=
  while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
      "_${FUNCNAME[0]}" "$errorArgument" "Blank argument"
    fi
    case "$1" in
      --exec)
        shift || "_${FUNCNAME[0]}" "$errorArgument" "--exec missing argument"
        binary="$1"
        ;;
      --list)
        listFlag=1
        ;;
      *)
        if [ -n "$directory" ]; then
          "_${FUNCNAME[0]}" "$errorArgument" "Unknown argument"
        fi
        if ! directory=$(usageArgumentDirectory "_${FUNCNAME[0]}" "directory" "$1"); then
          return $errorArgument
        fi
        ;;
    esac
    shift || "_${FUNCNAME[0]}" "$errorArgument" "Shift failed"
  done

  if [ -z "$directory" ]; then
    directory=.
  fi

  #
  # All OK with "assert"
  #
  # local assertThing
  # assertEquals "a" "a" || return $?
  # if ! assertEquals "a" "a" || \
  # test/tools/assert-tests.sh:3:# assert-tests.sh
  # test/tools/os-tests.sh:110:_assertBetterType() {

  problemFiles=()
  if ! tempFile=$(mktemp); then
    "_${FUNCNAME[0]}" "$errorEnvironment" "mktemp failed" || return $?
  fi
  suffixCheck='(local|return|; then|\ \|\||:[0-9]+:\s*#|\(\)\ \{)'
  {
    find "${directory%/}" -type f -name '*.sh' ! -path '*/.*' -print0 | xargs -0 grep -n -E 'assert[A-Z]' | grep -E -v "$suffixCheck" || :
    find "${directory%/}" -type f -name '*.sh' ! -path '*/.*' -print0 | xargs -0 grep -n -E '_(argument|environment|return)' | grep -E -v "$suffixCheck" || :
    find "${directory%/}" -type f -name '*.sh' ! -path '*/.*' -print0 | xargs -0 grep -n -E '__(execute|try)' | grep -E -v "$suffixCheck" || :
  } >"$tempFile"

  if [ ! -s "$tempFile" ]; then
    consoleSuccess "All files AOK."
  else
    if [ -n "$binary" ] || test $listFlag; then
      problemFile=
      lastProblemFile=
      while IFS='' read -r problemFile; do
        problemLine="${problemFile##*:}"
        problemFile="${problemFile%:*}"
        if [ "$problemFile" != "$lastProblemFile" ]; then
          # IDENTICAL findUncaughtAssertions-loop 3
          if test $listFlag && [ -n "$lastProblemFile" ]; then
            printf "%s (Lines %s)\n" "$(consoleCode "$lastProblemFile")" "$(IFS=, consoleMagenta "${problemLines[*]}")"
          fi
          problemFiles+=("$problemFile")
          lastProblemFile=$problemFile
          problemLines=()
        fi
        problemLines+=("$problemLine")
      done < <(cut -d : -f 1,2 <"$tempFile" | sort -u)
      # IDENTICAL findUncaughtAssertions-loop 3
      if test $listFlag && [ -n "$lastProblemFile" ]; then
        printf "%s (Lines %s)\n" "$(consoleCode "$lastProblemFile")" "$(IFS=, consoleMagenta "${problemLines[*]}")"
      fi
      if [ ${#problemFiles[@]} -gt 0 ] && [ -n "$binary" ]; then
        "$binary" "${problemFiles[@]}"
      fi
    else
      cat "$tempFile"
    fi
  fi
  rm "$tempFile" || "_${FUNCNAME[0]}" "$errorEnvironment" "Unable to delete $tempFile" || return $?
  [ ${#problemFiles[@]} -eq 0 ]
}
_findUncaughtAssertions() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
