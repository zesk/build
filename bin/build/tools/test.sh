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
  local this usage arg failedFiles failedReason failedReasons binary interactive sleepDelay
  local verbose checkedFiles

  verbose=false

  this="${FUNCNAME[0]}"
  usage="_$this"
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_INTERACTIVE_REFRESH || return $?

  clearLine || :
  sleepDelay="$BUILD_INTERACTIVE_REFRESH"
  statusMessage consoleInfo "Checking all shell scripts ..." || :
  failedReasons=()
  failedFiles=()
  checkedFiles=()
  binary=
  while [ $# -gt 0 ]; do
    arg="$1"
    [ -n "$arg" ] || __failArgument "$usage" "blank argument" || return $?
    case "$arg" in
      --delay)
        shift || __failArgument "$usage" "$arg missing argument" || return $?
        sleepDelay="$1"
        ;;
      --exec)
        shift || __failArgument "$usage" "$arg missing argument" || return $?
        binary="${1}"
        __usageEnvironment "$usage" isCallable "$binary" || return $?
        ;;
      --interactive)
        interactive=true
        ;;
      *)
        statusMessage consoleInfo "👀 Checking \"$arg\" ..." || :
        if ! failedReason=$(validateShellScript "$arg"); then
          ! $verbose || consoleSuccess "validateShellScript $arg failed: $failedReason"
          failedFiles+=("$arg")
          failedReasons+=("$failedReason")
        else
          ! $verbose || consoleSuccess "validateShellScript $arg passed"
          checkedFiles+=("$arg")
        fi
        ;;
    esac
    shift || __failArgument "$usage" "shift after $arg failed" || return $?
  done

  sleepDelay=$(usageArgumentUnsignedInteger "$usage" "sleepDelay" "$sleepDelay") || return $?

  if [ $# -eq 0 ] && [ ${#checkedFiles[@]} -eq 0 ]; then
    ! $verbose || consoleInfo "Reading file list from stdin ..."
    while read -r arg; do
      statusMessage consoleInfo "👀 Checking \"$arg\" (stdin) ..." || :
      if ! failedReason=$(validateShellScript "$arg"); then
        ! $verbose || consoleSuccess "validateShellScript $arg failed: $failedReason"
        failedReasons+=("$failedReason")
        failedFiles+=("$arg")
      else
        ! $verbose || consoleSuccess "validateShellScript $arg passed"
        checkedFiles+=("$arg")pat
      fi
    done
  fi

  if [ "${#failedReasons[@]}" -gt 0 ]; then
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
    __failEnvironment "$usage" "$this failed" || return $?
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
    "$(consoleSubtle "$(printf -- "- %s\n" "$@")")"

  while [ "$#" -gt 0 ]; do
    printf "%s\n%s\n%s\n" "$(consoleRed "LOOP")" \
      "$(consoleLabel "Queue")" \
      "$(consoleSubtle "$(printf -- "- %s\n" "$@")")"

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
        "$(consoleSubtle "$(printf -- "- %s\n" "${failedFiles[@]+${failedFiles[@]}}")")"

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
  local this usage argument
  local f

  this=${FUNCNAME[0]}
  usage="_$this"
  whichApt shellcheck shellcheck || __failEnvironment "$usage" "Can not install shellcheck" || return $?
  whichApt pcregrep pcregrep || __failEnvironment "$usage" "Can not install pcregrep" || return $?

  # Open 3 to pipe to nowhere
  exec 3>/dev/null
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --verbose)
        consoleWarning "Verbose on"
        exec 3>&1
        ;;
      *)
        [ -f "$argument" ] || __usageEnvironment "$usage" "$(printf "%s: %s" "Not a file" "$(consoleCode "$argument")")" || return $?
        # shellcheck disable=SC2210
        __usageEnvironment "$usage" bash -n "$argument" 1>&3 || return $?
        # shellcheck disable=SC2210
        __usageEnvironment "$usage" shellcheck "$argument" 1>&3 || return $?
        if pcregrep -l -M '\n\}\n#' "$argument"; then
          __failEnvironment "$usage" "pcregrep found }\\n#" || return $?
        fi
        ;;
    esac
    shift || __failArgument "$usage" "shifting $argument failed" || return $?
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
  local this usage argument
  local fileArgs f total

  local textMatches t binary
  local failedReasons failedFiles

  this=${FUNCNAME[0]}
  usage="_$this"

  fileArgs=()
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "Blank argument" || return $?
    case "$argument" in
      --)
        shift || __failArgument "$usage" "shift $argument failed" || return $?
        break
        ;;
      --exec)
        shift || __failArgument "$usage" "shift $argument failed" || return $?
        binary="$1"
        isCallable "$binary" || __failArgument "$usage" "--exec $binary Not callable" || return $?
        ;;
      *)
        usageArgumentFile "$usage" "file${#fileArgs[@]}" "$1" >/dev/null || return $?
        fileArgs+=("$1")
        ;;
    esac
    shift || __failArgument "$usage" "shift $argument failed" || return $?
  done

  textMatches=()
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "Zero size text match passed" || return $?
    case "$argument" in
      --)
        shift || __failArgument "$usage" "shift $argument failed" || return $?
        break
        ;;
      *)
        textMatches+=("$1")
        ;;
    esac
    shift || __failArgument "$usage" "shift $argument failed" || return $?
  done

  [ "${#fileArgs[@]}" -gt 0 ] || __failArgument "$usage" "No extension arguments" || return $?
  [ "${#textMatches[@]}" -gt 0 ] || __failArgument "$usage" "No text match arguments" || return $?

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
    __failEnvironment "$usage" "$this failed" || return $?
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
  local this usage
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
  [ "${#extensions[@]}" -gt 0 ] || __failArgument "$usage" "No extension arguments" || return $?
  [ "${#textMatches[@]}" -gt 0 ] || __failArgument "$usage" "No text match arguments" || return $?

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
    __failEnvironment "$usage" "$this failed" || return $?
  else
    statusMessage consoleSuccess "All scripts passed"
  fi
}

#
# Usage: {fn} [ --exec binary ] [ directory ]
#
findUncaughtAssertions() {
  local argument listFlag binary directory problemFiles lastProblemFile problemLine problemLines
  # IDENTICAL this_usage 4
  local this usage

  this="${FUNCNAME[0]}"
  usage="_$this"


  # --list
  listFlag=false

  # --exec
  binary=
  # Argument
  directory=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "Blank argument" || return $?
    case "$argument" in
      --exec)
        shift || __failArgument "$usage" "$argument missing argument" || return $?
        [ -n "$1" ] || __failArgument "$usage" "$argument argument blank" || return $?
        binary="$1"
        ;;
      --list)
        listFlag=true
        ;;
      *)
        [ -z "$directory" ] || __failArgument "$usage" "$this: Unknown argument" || return $?
        directory=$(usageArgumentDirectory "$usage" "directory" "$1") || return $?
        ;;
    esac
    shift || __failArgument "$usage" "shift $argument failed" || return $?
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
  tempFile=$(mktemp) || __failEnvironment "$usage" "mktemp failed" || return $?
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
  __usageEnvironment "$usage" rm "$tempFile" || return $?
  [ ${#problemFiles[@]} -eq 0 ]
}
_findUncaughtAssertions() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
