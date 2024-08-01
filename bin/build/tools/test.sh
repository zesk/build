#!/usr/bin/env bash
#
# test.sh
#
# Test support functions
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

#
# Load test tools and make `testSuite` function available
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: binary ... - Optional. Callable. Run this program after loading test tools.
#
testTools() {
  local usage="_${FUNCNAME[0]}"
  local home stateFile

  stateFile=$(_arguments "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" "$@") || return "$(_argumentReturn $?)"
  home=$(__usageEnvironment "$usage" buildHome) || _clean $? "$stateFile" || return $?
  # shellcheck source=/dev/null
  source "$home/bin/build/test-tools.sh" || __failEnvironment "$usage" "test-tools.sh" || return $?
  __usageEnvironment "$usage" isFunction testSuite || return $?
  [ $# -ne 0 ] || return 0
  __environment "$@" || return $?
}
_testTools() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Dump a pipe with a title and stats
# Argument: --symbol symbol - Optional. String. Symbol to place before each line. (Blank is ok).
# Argument: --tail - Optional. Flag. Show the tail of the file and not the head when not enough can be shown.
# Argument: name - Optional. String. The item name or title of this output.
dumpPipe() {
  local usage="_${FUNCNAME[0]}"
  local argument
  local name names item nLines nBytes decoration symbol
  local item width suffix
  local endBinary
  local showLines

  export BUILD_DEBUG_LINES
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_DEBUG_LINES || return $?
  showLines="${BUILD_DEBUG_LINES:-100}"

  item=$(mktemp) || __failEnvironment "$usage" mktemp || return $?

  cat >"$item"

  endBinary="head"
  names=()
  symbol="🐞"
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --tail)
        endBinary="tail"
        ;;
      --symbol)
        shift || __failArgument "$usage" "missing $argument argument" || return $?
        symbol="$1"
        ;;
      --lines)
        shift || __failArgument "$usage" "missing $argument argument" || return $?
        showLines=$(usageArgumentUnsignedInteger "$usage" "showLines" "$1") || return $?
        ;;
      *)
        names+=("$argument")
        break
        ;;
    esac
    shift || __failArgument "$usage" shift || return $?
  done

  isInteger "$showLines" || _environment "SHOW_LINES is not-integer: $showLines" || showLines=10

  name=
  [ ${#names[@]} -eq 0 ] || name=$(consoleInfo "${names[*]}: ") || :
  nLines=$(($(wc -l <"$item") + 0))
  nBytes=$(($(wc -c <"$item") + 0))
  [ ${#symbol} -eq 0 ] || symbol="$symbol "
  if [ $nBytes -eq 0 ]; then
    suffix=$(consoleOrange "(empty)")
  elif [ "$showLines" -lt "$nLines" ]; then
    suffix="$(consoleWarning "(showing $showLines $(plural "$showLines" line lines))")"
  else
    suffix="$(consoleSuccess "(shown)")"
  fi
  # shellcheck disable=SC2015
  printf "%s%s%s %s, %s %s %s\n" \
    "$(clearLine)" \
    "$name" \
    "$nLines" "$(plural "$nLines" line lines)" \
    "$nBytes" "$(plural "$nBytes" byte bytes)" \
    "$suffix"
  if [ $nBytes -eq 0 ]; then
    rm -rf "$item" || :
    return 0
  fi
  decoration="$(consoleCode "$(echoBar)")"
  width=$(consoleColumns) || __failEnvironment "$usage" consoleColumns || return $?
  printf "%s\n%s\n%s\n" "$decoration" "$("$endBinary" -n "$showLines" "$item" | wrapLines --width "$((width - 1))" --fill " " "$symbol" "$(consoleReset)")" "$decoration"
  rm -rf "$item" || :
}
_dumpPipe() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# dumpFile fileName0 [ fileName1 ... ]
#
dumpFile() {
  local usage="_${FUNCNAME[0]}"
  local argument
  local nLines nBytes tempFile item files dumpArgs showLines

  files=()
  dumpArgs=()
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --symbol)
        shift || __failArgument "$usage" "shift $argument" || return $?
        dumpArgs+=("$argument" "$1")
        ;;
      --lines)
        shift || __failArgument "$usage" "missing $argument argument" || return $?
        dumpArgs+=("--lines" "$1")
        ;;
      *)
        [ -f "$argument" ] || __failArgument "$usage" "$argument is not a item" || return $?
        files+=("$argument")
        __failArgument "$usage" "unknown argument: $argument" || return $?
        ;;
    esac
    shift || __failArgument "$usage" shift || return $?
  done

  if [ ${#files[@]} -eq 0 ]; then
    __usageEnvironment "$usage" dumpPipe "${dumpArgs[@]+${dumpArgs[@]}}" "(stdin)" || return $?
  else
    for tempFile in "${files[@]}"; do
      # shellcheck disable=SC2094
      __usageEnvironment "$usage" dumpPipe "${dumpArgs[@]+${dumpArgs[@]}}" "$tempFile" <"$tempFile" || return $?
    done
  fi
}
__dumpFile() {
  local exitCode="$1" tempFile="$2"
  shift 2 || _argument "${FUNCNAME[0]} shift 2" || :
  __environment rm -rf "$tempFile" || :
  _dumpFile "$exitCode" "$@"
}
_dumpFile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# validateShellScripts
#
# Requires shellcheck so should be later in the testing process to have a cleaner build
# This can be run on any directory tree to test scripts in any application.
#
# Usage: validateShellScripts [ --exec binary ] [ file0 ... ]
# Example:     if validateShellScripts; then git commit -m "saving things" -a; fi
# Argument: --interactive - Flag. Optional. Interactive mode on fixing errors.
# Argument: --exec binary - Run binary with files as an argument for any failed files. Only works if you pass in item names.
# Argument: --delay - Optional. Integer. Delay between checks in interactive mode.
# Argument: findArgs - Additional find arguments for .sh files (or exclude directories).
# Side-effect: shellcheck is installed
# Side-effect: Status written to stdout, errors written to stderr
# Environment: This operates in the current working directory
# Summary: Check files for the existence of a string
# Exit Code: 0 - All found files pass `shellcheck` and `bash -n`
# Exit Code: 1 - One or more files did not pass
# Output: This outputs `statusMessage`s to `stdout` and errors to `stderr`.
validateShellScripts() {
  local this usage argument failedFiles failedReason failedReasons binary interactive sleepDelay
  local verbose checkedFiles ii source

  verbose=false

  this="${FUNCNAME[0]}"
  usage="_$this"
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_INTERACTIVE_REFRESH || return $?

  clearLine || :
  statusMessage consoleInfo "Checking all shell scripts ..." || :
  failedReasons=()
  failedFiles=()
  checkedFiles=()
  binary=
  sleepDelay=7
  ii=()
  interactive=false
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --delay)
        shift || __failArgument "$usage" "$argument missing argument" || return $?
        sleepDelay="$1"
        ;;
      --verbose)
        verbose=true
        ;;
      --exec)
        shift
        binary=$(usageArgumentCallable "$usage" "$argument" "${1-}") || return $?
        ii+=("$argument" "$binary")
        ;;
      --interactive)
        interactive=true
        ii+=("$argument")
        ;;
      *)
        checkedFiles+=("$argument")
        ;;
    esac
    shift || __failArgument "$usage" "shift after $argument failed" || return $?
  done
  source=none
  if [ ${#checkedFiles[@]} -gt 0 ]; then
    source="argument"
    ! $verbose || consoleInfo "Reading item list from arguments ..."
    for argument in "${checkedFiles[@]}"; do
      [ -n "$argument" ] || continue
      if ! _validateShellScriptsHelper "$verbose" "$argument" "$source"; then
        failedFiles+=("$argument")
      fi
    done
  elif [ $# -eq 0 ]; then
    source="stdin"
    ! $verbose || consoleInfo "Reading item list from stdin ..."
    while read -r argument; do
      [ -n "$argument" ] || continue
      if ! _validateShellScriptsHelper "$verbose" "$argument" "$source"; then
        failedFiles+=("$argument")
      fi
    done
  fi
  if [ "${#failedFiles[@]}" -gt 0 ]; then
    {
      clearLine
      _list "$(consoleWarning "Files failed:")" "${failedFiles[@]}"
      consoleInfo "# ${#failedFiles[@]} $(plural ${#failedFiles[@]} error errors)"
    } 1>&2
    if $interactive; then
      validateShellScriptsInteractive "${ii[@]+"${ii[@]}"}" "${failedFiles[@]}"
    elif [ -n "$binary" ]; then
      if [ ${#failedFiles[@]} -gt 0 ]; then
        "$binary" "${failedFiles[@]}"
      fi
    fi
    __failEnvironment "$usage" "Failed:" "${failedFiles[*]}" || return $?
  fi
  statusMessage consoleSuccess "All scripts passed validation ($source)"
  printf "\n"
}
_validateShellScripts() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Handle check consistently
_validateShellScriptsHelper() {
  local verbose="$1" file="$2" source="$3" reason vv=()

  ! $verbose || vv+=(--verbose)
  statusMessage consoleInfo "👀 Checking \"$file\" ($source) ..." || :
  if reason=$(validateShellScript "${vv[@]+"${vv[@]}"}" "$file" 2>&1); then
    ! $verbose || consoleSuccess "validateShellScript $file passed"
  else
    ! $verbose || consoleInfo "validateShellScript $file failed: $reason"
    printf "%s: %s\n" "$file" "$reason" 1>&2
    return 1
  fi
}

# Usage: [ fileToCheck ... ]
# Argument: --exec binary - Optional. Callable. Run binary with files as an argument for any failed files. Only works if you pass in item names.
# Argument: --delay delaySeconds - Optional. Integer. Delay in seconds between checks in interactive mode.
# Argument: fileToCheck ... - Optional. File. Shell file to validate.
# Run checks interactively until errors are all fixed.
validateShellScriptsInteractive() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex
  local sleepDelay countdown binary

  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --exec)
        shift
        binary="$(usageArgumentCallable "$argument" "${1-}")" || return $?
        ;;
      --delay)
        shift
        sleepDelay=$(usageArgumentUnsignedInteger "$usage" "$argument" "${1-}") || return $?
        ;;
      *)
        __failArgument "$usage" "unknown argument #$argumentIndex: $argument" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || return $?
  done

  printf "%s\n%s\n%s\n" "$(consoleRed "BEFORE")" \
    "$(consoleLabel "Queue")" \
    "$(consoleSubtle "$(printf -- "- %s\n" "$@")")"

  while [ "$#" -gt 0 ]; do
    if _validateShellScriptInteractiveCheck "$usage" "$@"; then
      shift
    else
      countdown=$sleepDelay
      while [ "$countdown" -gt 0 ]; do
        statusMessage consoleWarning "Refresh in $(consoleValue " $countdown ") $(plural "$countdown" second seconds)"
        countdown=$((countdown - 1))
        sleep 1 || __failEnvironment "$usage" "Interrupt ..." || return $?
      done
      clear
    fi
  done
}
_validateShellScriptsInteractive() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_validateShellScriptInteractiveCheck() {
  local usage="${1-}" script="${2-}" scriptPassed
  if [ -z "$script" ]; then
    return 0
  fi
  if failedReason=$(validateShellScript --verbose "$1"); then
    scriptPassed=true
  else
    scriptPassed=false
  fi
  if $scriptPassed; then
    bigText "SUCCESS $(basename "$script")" | wrapLines "$(consoleGreen)" "$(consoleReset)"
    boxedHeading "$script now passes" | wrapLines "$(consoleBoldGreen)" "$(consoleReset)"
    consoleOrange "$(echoBar "*")"
    return 0
  fi

  shift 2
  bigText "FAIL $(basename "$script")" | wrapLines "$(consoleSubtle validateShellScript)  $(consoleBoldRed)" "$(consoleReset)"
  printf "%s\n%s\n%s\n" "$(consoleRed "$failedReason")" \
    "$(consoleLabel "Queue")" \
    "$(consoleSubtle "$(printf -- "- %s\n" "$@")")"
  consoleBlue "$(echoBar "+-")"
  consoleInfo "$# $(plural $# item files) remain"
  return 1
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
  local this usage argument found

  this=${FUNCNAME[0]}
  usage="_$this"
  __usageEnvironment "$usage" whichApt shellcheck shellcheck || return $?
  __usageEnvironment "$usage" whichApt pcregrep pcregrep || return $?

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
        [ -f "$argument" ] || __failArgument "$usage" "$(printf "%s: %s" "Not a item" "$(consoleCode "$argument")")" || return $?
        # shellcheck disable=SC2210
        __usageEnvironment "$usage" bash -n "$argument" 1>&3 || return $?
        # shellcheck disable=SC2210
        __usageEnvironment "$usage" shellcheck "$argument" 1>&3 || return $?
        if found=$(pcregrep -n -l -M '\n\}\n#' "$argument"); then
          __failEnvironment "$usage" "$argument: pcregrep found }\\n#: $(consoleCode "$found")" || return $?
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
# Search for item extensions and ensure that text is found in each item.
#
# This can be run on any directory tree to test files in any application.
#
# By default, any directory which begins with a dot `.` will be ignored.
#
# Usage: {fn} file0 [ file1 ... ] -- text0 [ text1 ... ]
# Example:     {fn} foo.sh my.sh -- "Copyright 2024" "Company, LLC"
# Argument: `file0` - Required - a item to look for matches in
# Argument: `--` - Required. Separates files from text
# Argument: `text0` - Required. Text which must exist in each item
# Side-effect: Errors written to stderr, status written to stdout
# Summary: Check files for the existence of a string or strings
# Exit Code: 0 - All found files contain all text string or strings
# Exit Code: 1 - One or more files does not contain all text string or strings
# Exit Code: 2 - Arguments error (missing extension or text)
#
validateFileContents() {
  local this usage argument
  local fileArgs total item

  local textMatches text binary
  local failedReasons failedFiles

  this=${FUNCNAME[0]}
  usage="_$this"

  fileArgs=()
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --)
        shift || __failArgument "$usage" "shift argument $(consoleCode "$argument")" || return $?
        break
        ;;
      --exec)
        shift || __failArgument "$usage" "shift argument $(consoleCode "$argument")" || return $?
        binary="$1"
        isCallable "$binary" || __failArgument "$usage" "--exec $binary Not callable" || return $?
        ;;
      *)
        usageArgumentFile "$usage" "file${#fileArgs[@]}" "$1" >/dev/null || return $?
        fileArgs+=("$1")
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $(consoleCode "$argument")" || return $?
  done

  textMatches=()
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "Zero size text match passed" || return $?
    case "$argument" in
      --)
        shift || __failArgument "$usage" "shift argument $(consoleCode "$argument")" || return $?
        break
        ;;
      *)
        textMatches+=("$1")
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $(consoleCode "$argument")" || return $?
  done

  [ "${#fileArgs[@]}" -gt 0 ] || __failArgument "$usage" "No extension arguments" || return $?
  [ "${#textMatches[@]}" -gt 0 ] || __failArgument "$usage" "No text match arguments" || return $?

  failedReasons=()
  failedFiles=()
  total=0
  total="${#fileArgs[@]}"
  # shellcheck disable=SC2059
  statusMessage consoleInfo "Searching $total $(plural "$total" item files) for text: $(printf " $(consoleReset)\"$(consoleCode "%s")\"" "${textMatches[@]}")"

  total=0
  for item in "${fileArgs[@]}"; do
    total=$((total + 1))
    for text in "${textMatches[@]}"; do
      if ! grep -q "$text" "$item"; then
        failedReasons+=("$item missing \"$text\"")
        statusMessage consoleError "Searching $item ... NOT FOUND"
        failedFiles+=("$item")
      else
        statusMessage consoleSuccess "Searching $item ... found"
      fi
    done
  done
  statusMessage consoleInfo "Checked $total $(plural $total item files) for ${#textMatches[@]} $(plural ${#textMatches[@]} phrase phrases)"

  if [ "${#failedReasons[@]}" -gt 0 ]; then
    clearLine
    consoleError "The following scripts failed:" 1>&2
    for item in "${failedReasons[@]}"; do
      echo "    $(consoleMagenta "$item")$(consoleInfo ", ")" 1>&2
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
# Search for item extensions and ensure that text is found in each item.
#
# This can be run on any directory tree to test files in any application.
#
# By default, any directory which begins with a dot `.` will be ignored.
#
# Usage: validateFileExtensionContents extension0 [ extension1 ... ] -- text0 [ text1 ... ] [ -- findArgs ]
# Example:     validateFileContents sh php js -- 'Widgets LLC' 'Copyright &copy; 2024'
# Argument: `extension0` - Required - the extension to search for (`*.extension`)
# Argument: `--` - Required. Separates extensions from text
# Argument: `text0` - Required. Text which must exist in each item with the extension given.
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
  local this usage total text
  local failedReasons item foundFiles
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
  statusMessage consoleInfo "Searching $total $(plural $total item files) (ext: ${extensions[*]}) for text: $(printf " $(consoleReset)\"$(consoleCode "%s")\"" "${textMatches[@]}")"

  total=0
  while IFS= read -r item; do
    total=$((total + 1))
    for text in "${textMatches[@]}"; do
      if ! grep -q "$text" "$item"; then
        failedReasons+=("$item missing \"$text\"")
        statusMessage consoleError "Searching $item ... NOT FOUND"
      else
        statusMessage consoleSuccess "Searching $item ... found"
      fi
    done
  done <"$foundFiles"
  statusMessage consoleInfo "Checked $total $(plural $total item files) for ${#textMatches[@]} $(plural ${#textMatches[@]} phrase phrases)"
  rm "$foundFiles"

  if [ "${#failedReasons[@]}" -gt 0 ]; then
    clearLine
    consoleError "The following scripts failed:" 1>&2
    for item in "${failedReasons[@]}"; do
      echo "    $(consoleMagenta "$item")$(consoleInfo ", ")" 1>&2
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
  local usage

  usage="_${FUNCNAME[0]}"

  # --list
  listFlag=false

  # --exec
  binary=
  # Argument
  directory=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
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
    shift || __failArgument "$usage" "shift argument $(consoleCode "$argument")" || return $?
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
