#!/usr/bin/env bash
#
# test.sh
#
# Test support functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

#
# Load test tools and make `testSuite` function available
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: binary - Optional. Callable. Run this program after loading test tools.
# Argument: ... - Optional. Arguments for binary.
#
testTools() {
  local usage="_${FUNCNAME[0]}"
  local home stateFile binary

  home=$(__catchEnvironment "$usage" buildHome) || return $?
  # shellcheck source=/dev/null
  source "$home/bin/build/test-tools.sh" || __throwEnvironment "$usage" "test-tools.sh" || return $?
  __catchEnvironment "$usage" isFunction testSuite || return $?

  stateFile=$(_arguments "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" "$@") || return "$(_argumentReturn $?)"
  rm -f "$stateFile" || :

  [ $# -ne 0 ] || return 0
  __environment "$@" || return $?
}
_testTools() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Fake a value for testing
# Usage: {fn} globalName [ saveGlobalName ] [ --end | value ]
# Argument: globalName - EnvironmentVariable. Required. Global to change temporarily to a value.
# Argument: saveGlobalName - EnvironmentVariable. Optional. Resets the `globalName` to the value in `saveGlobalName` if set.
# Argument: --end - Flag. Optional. Resets the `globalName` to the value in `saveGlobalName` if set.
# Argument: value - EmptyString. Required. Force the value of `globalName` to this value temporarily. Saves the original value in global `saveGlobalName`.
__mockValue() {
  local usage="_${FUNCNAME[0]}"
  local me="$usage ${1-} ${2-}" global="${1-}"
  local saveGlobal="${2:-"__MOCK_${global}"}" value="${3-}"
  [ $# -le 3 ] || IFS=';' __throwArgument "$usage" "$me requires no more than 3 arguments: [$#]: $*" || return $?
  if [ "$value" = "--end" ]; then
    # shellcheck disable=SC2163
    export "$saveGlobal"
    if [ "${!saveGlobal-"$me"}" = "$me" ]; then
      unset "$global"
    else
      export "$global"="${!saveGlobal-}"
    fi
    unset "$saveGlobal"
    return 0
  fi
  # shellcheck disable=SC2163
  export "$saveGlobal"="${!global-"$me"}"
  export "$global"="$value"
}
___mockValue() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Dumps output as hex
# Depends: xxd
# apt-get: xxd
# stdin: binary
# stdout: formatted output set to ideal `consoleColumns`
dumpBinary() {
  local usage="_${FUNCNAME[0]}"

  local symbol="🔅" vanishFiles=() showBytes="" endBinary=tail names=()

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --vanish)
        shift
        vanishFiles+=("$(usageArgumentFile "$usage" "$argument" "${1-}")") || return $?
        ;;
      --head)
        endBinary="head"
        ;;
      --tail)
        endBinary="tail"
        ;;
      --symbol)
        shift
        symbol="$1"
        ;;
      --bytes)
        shift
        # Allow BLANK
        if [ -n "$1" ]; then
          showBytes=$(usageArgumentUnsignedInteger "$usage" "bytes" "$1") || return $?
        fi
        ;;
      *)
        names+=("$argument")
        break
        ;;
    esac
    shift || __throwArgument "$usage" shift || return $?
  done

  local columns
  # Is this installed by default?
  __catchEnvironment "$usage" muzzle packageWhich xxd xxd || return $?
  columns=$(__catchEnvironment "$usage" consoleColumns) || return $?

  local item
  if [ "${#vanishFiles[@]}" -gt 0 ]; then
    for item in "${vanishFiles[@]}"; do
      local name
      name=$(decorate file "$(basename "$item")" "$item")
      # Recursion - only when --vanish is a parameter
      __catchEnvironment "$usage" dumpBinary --size "$showBytes" "${names[@]}" "$name" <"$item" || return $?
      __catchEnvironment "$usage" rm -rf "$item" || return $?
    done
    return 0
  fi
  item=$(fileTemporaryName "$usage") || return $?
  __catchEnvironment "$usage" cat >"$item" || return $?

  local name="" nLines nBytes
  [ ${#names[@]} -eq 0 ] || name=$(decorate info "${names[*]}: ")
  nLines=$(($(wc -l <"$item") + 0))
  nBytes=$(($(wc -c <"$item") + 0))
  [ ${#symbol} -eq 0 ] || symbol="$symbol "
  if [ $nBytes -eq 0 ]; then
    suffix=$(decorate orange "(empty)")
  elif [ -n "$showBytes" ] && [ "$showBytes" -lt "$nBytes" ]; then
    suffix="$(decorate warning "(showing $showBytes $(plural "$showBytes" byte bytes))")"
  else
    suffix="$(decorate success "(shown)")"
  fi
  # shellcheck disable=SC2015
  statusMessage --last printf -- "%s%s %s, %s %s %s" \
    "$name" \
    "$nLines" "$(plural "$nLines" line lines)" \
    "$nBytes" "$(plural "$nBytes" byte bytes)" \
    "$suffix"
  if [ $nBytes -eq 0 ]; then
    __catchEnvironment "$usage" rm -rf "$item" || return $?
    return 0
  fi

  local endPreprocess=(cat)
  if [ -n "$showBytes" ]; then
    endPreprocess=("$endBinary" --bytes="$showBytes")
  fi
  __catchEnvironment "$usage" "${endPreprocess[@]}" <"$item" | __catchEnvironment "$usage" xxd -c "$((columns / 4))" | wrapLines "$symbol $(decorate code)" "$(decorate reset)" || _clean $? "$item" || return $?
  __catchEnvironment "$usage" rm -rf "$item" || return $?
  return 0
}
_dumpBinary() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Dump a pipe with a title and stats
# Argument: --symbol symbol - Optional. String. Symbol to place before each line. (Blank is ok).
# Argument: --tail - Optional. Flag. Show the tail of the file and not the head when not enough can be shown.
# Argument: --head - Optional. Flag. Show the head of the file when not enough can be shown. (default)
# Argument: --lines - Optional. UnsignedInteger. Number of lines to show.
# Argument: --vanish file - Optional. UnsignedInteger. Number of lines to show.
# Argument: name - Optional. String. The item name or title of this output.
# stdin: text
# stdout: formatted text for debugging
dumpPipe() {
  local usage="_${FUNCNAME[0]}"

  local showLines="" endBinary="head" names=() symbol="🐞" vanishFiles=()

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --head)
        endBinary="head"
        ;;
      --vanish)
        shift
        vanishFiles+=("$(usageArgumentFile "$usage" "$argument" "${1-}")") || return $?
        ;;
      --tail)
        endBinary="tail"
        ;;
      --symbol)
        shift || __throwArgument "$usage" "missing $argument argument" || return $?
        symbol="$1"
        ;;
      --lines)
        shift || __throwArgument "$usage" "missing $argument argument" || return $?
        showLines=$(usageArgumentUnsignedInteger "$usage" "showLines" "$1") || return $?
        ;;
      *)
        names+=("$argument")
        break
        ;;
    esac
    shift || __throwArgument "$usage" shift || return $?
  done

  if [ -z "$showLines" ]; then
    export BUILD_DEBUG_LINES
    __catchEnvironment "$usage" buildEnvironmentLoad BUILD_DEBUG_LINES || return $?
    showLines="${BUILD_DEBUG_LINES:-100}"
    isUnsignedInteger "$showLines" || _environment "BUILD_DEBUG_LINES is not an unsigned integer: $showLines" || showLines=10
  fi

  local item
  if [ "${#vanishFiles[@]}" -gt 0 ]; then
    for item in "${vanishFiles[@]}"; do
      local name
      name=$(decorate file "$(basename "$item")" "$item")
      # Recursion - only when --vanish is a parameter
      __catchEnvironment "$usage" dumpPipe "--${endBinary}" --lines "$showLines" "${names[@]}" "$name" <"$item" || return $?
      __catchEnvironment "$usage" rm -rf "$item" || return $?
    done
    return 0
  fi
  item=$(fileTemporaryName "$usage") || return $?
  __catchEnvironment "$usage" cat >"$item" || return $?

  local name="" nLines nBytes
  [ ${#names[@]} -eq 0 ] || name=$(decorate info "${names[*]}: ") || :
  nLines=$(($(wc -l <"$item") + 0))
  nBytes=$(($(wc -c <"$item") + 0))
  [ ${#symbol} -eq 0 ] || symbol="$symbol "
  if [ $nBytes -eq 0 ]; then
    suffix=$(decorate orange "(empty)")
  elif [ "$showLines" -lt "$nLines" ]; then
    suffix="$(decorate warning "(showing $showLines $(plural "$showLines" line lines))")"
  else
    suffix="$(decorate success "(shown)")"
  fi
  # shellcheck disable=SC2015
  statusMessage --last printf -- "%s%s %s, %s %s %s" \
    "$name" \
    "$nLines" "$(plural "$nLines" line lines)" \
    "$nBytes" "$(plural "$nBytes" byte bytes)" \
    "$suffix"
  if [ $nBytes -eq 0 ]; then
    rm -rf "$item" || :
    return 0
  fi

  local decoration width
  decoration="$(decorate code "$(echoBar)")"
  width=$(consoleColumns) || __throwEnvironment "$usage" consoleColumns || return $?
  printf -- "%s\n%s\n%s\n" "$decoration" "$("$endBinary" -n "$showLines" "$item" | wrapLines --width "$((width - 1))" --fill " " "$symbol" "$(decorate reset)")" "$decoration"
  rm -rf "$item" || :
}
_dumpPipe() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output a file for debugging
#
# Usage: {fn} fileName0 [ fileName1 ... ]
# stdin: text (optional)
# stdout: formatted text (optional)
dumpFile() {
  local usage="_${FUNCNAME[0]}"
  local files=() dumpArgs=()

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --symbol)
        shift || __throwArgument "$usage" "shift $argument" || return $?
        dumpArgs+=("$argument" "$1")
        ;;
      --lines)
        shift || __throwArgument "$usage" "missing $argument argument" || return $?
        dumpArgs+=("--lines" "$1")
        ;;
      *)
        [ -f "$argument" ] || __throwArgument "$usage" "$argument is not a item" || return $?
        files+=("$argument")
        __throwArgument "$usage" "unknown argument: $argument" || return $?
        ;;
    esac
    shift || __throwArgument "$usage" shift || return $?
  done

  if [ ${#files[@]} -eq 0 ]; then
    __catchEnvironment "$usage" dumpPipe "${dumpArgs[@]+${dumpArgs[@]}}" "(stdin)" || return $?
  else
    for tempFile in "${files[@]}"; do
      # shellcheck disable=SC2094
      __catchEnvironment "$usage" dumpPipe "${dumpArgs[@]+${dumpArgs[@]}}" "$tempFile" <"$tempFile" || return $?
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
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run `bashLint` on a set of bash files.
#
# Usage: bashLintFiles [ --exec binary ] [ file0 ... ]
# Example:     if bashLintFiles; then git commit -m "saving things" -a; fi
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
bashLintFiles() {
  local usage="_${FUNCNAME[0]}"

  local verbose=false failedReasons=() failedFiles=() checkedFiles=() binary="" sleepDelay=7 ii=() interactive=false

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --verbose)
        verbose=true
        ;;
      --exec)
        shift
        binary="$(usageArgumentCallable "$usage" "$argument" "${1-}")" || return $?
        ii+=("$argument" "$binary")
        ;;
      --interactive)
        interactive=true
        ;;
      *)
        checkedFiles+=("$(usageArgumentFile "$usage" "checkFile" "$argument")") || return $?
        ;;
    esac
    shift || __throwArgument "$usage" "shift after $argument failed" || return $?
  done

  __catchEnvironment "$usage" buildEnvironmentLoad BUILD_INTERACTIVE_REFRESH || return $?
  statusMessage --first decorate info "Checking all shell scripts ..."

  local source=none
  if [ ${#checkedFiles[@]} -gt 0 ]; then
    source="argument"
    ! $verbose || decorate info "Reading item list from arguments ..."
    for argument in "${checkedFiles[@]}"; do
      [ -n "$argument" ] || continue
      if ! _bashLintFilesHelper "$verbose" "$argument" "$source"; then
        failedFiles+=("$argument")
      fi
    done
  elif [ $# -eq 0 ]; then
    source="stdin"
    ! $verbose || decorate info "Reading item list from stdin ..."
    while read -r argument; do
      [ -n "$argument" ] || continue
      if ! _bashLintFilesHelper "$verbose" "$argument" "$source"; then
        failedFiles+=("$argument")
      fi
    done
  fi
  if [ "${#failedFiles[@]}" -gt 0 ]; then
    {
      statusMessage --last _list "$(decorate warning "Files failed:")" "${failedFiles[@]}"
      decorate info "# ${#failedFiles[@]} $(plural ${#failedFiles[@]} error errors)"
    } 1>&2
    if $interactive; then
      bashLintFilesInteractive "${ii[@]+"${ii[@]}"}" "${failedFiles[@]}"
    elif [ -n "$binary" ]; then
      if [ ${#failedFiles[@]} -gt 0 ]; then
        "$binary" "${failedFiles[@]}"
      fi
    fi
    __throwEnvironment "$usage" "Failed:" "${failedFiles[*]}" || return $?
  fi
  statusMessage decorate success "All scripts passed validation ($source)"
  printf -- "\n"
}
_bashLintFiles() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Handle check consistently
_bashLintFilesHelper() {
  local verbose="$1" file="$2" source="$3" reason vv=()

  ! $verbose || vv+=(--verbose)
  ! $verbose || statusMessage decorate info "👀 Checking \"$file\" ($source) ..." || :
  if reason=$(bashLint "${vv[@]+"${vv[@]}"}" "$file" 2>&1); then
    ! $verbose || statusMessage --last decorate success "bashLint $file passed"
  else
    ! $verbose || statusMessage --last decorate info "bashLint $file failed: $reason"
    printf -- "%s: %s\n" "$file" "$reason" 1>&2
    return 1
  fi
}

# Usage: [ fileToCheck ... ]
# Argument: --exec binary - Optional. Callable. Run binary with files as an argument for any failed files. Only works if you pass in item names.
# Argument: --delay delaySeconds - Optional. Integer. Delay in seconds between checks in interactive mode.
# Argument: fileToCheck ... - Optional. File. Shell file to validate.
# Run checks interactively until errors are all fixed.
bashLintFilesInteractive() {
  local usage="_${FUNCNAME[0]}"

  local sleepDelay countdown binary

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
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
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift || __throwArgument "$usage" "missing #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
  done

  printf -- "%s\n%s\n%s\n" "$(decorate red "BEFORE")" \
    "$(decorate label "Queue")" \
    "$(decorate subtle "$(printf -- "- %s\n" "$@")")"

  while [ "$#" -gt 0 ]; do
    if _bashLintInteractiveCheck "$usage" "$@"; then
      shift
    else
      countdown=$sleepDelay
      while [ "$countdown" -gt 0 ]; do
        statusMessage decorate warning "Refresh in $(decorate value " $countdown ") $(plural "$countdown" second seconds)"
        countdown=$((countdown - 1))
        sleep 1 || __throwEnvironment "$usage" "Interrupt ..." || return $?
      done
      clear
    fi
  done
}
_bashLintFilesInteractive() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_bashLintInteractiveCheck() {
  local usage="${1-}" script="${2-}" scriptPassed
  if [ -z "$script" ]; then
    return 0
  fi
  if failedReason=$(bashLint --verbose "$1"); then
    scriptPassed=true
  else
    scriptPassed=false
  fi
  if $scriptPassed; then
    bigText "SUCCESS $(basename "$script")" | wrapLines "$(decorate green)" "$(decorate reset)"
    boxedHeading "$script now passes" | wrapLines "$(decorate bold-green)" "$(decorate reset)"
    decorate orange "$(echoBar "*")"
    return 0
  fi

  shift 2
  bigText "FAIL $(basename "$script")" | wrapLines "$(decorate subtle bashLint)  $(decorate bold-red)" "$(decorate reset)"
  printf -- "%s\n%s\n%s\n" "$(decorate red "$failedReason")" \
    "$(decorate label "Queue")" \
    "$(decorate subtle "$(printf -- "- %s\n" "$@")")"
  decorate blue "$(echoBar "+-")"
  decorate info "$# $(plural $# item files) remain"
  return 1
}

# Usage: {fn} [ script ... ]
#
# Run `shellcheck` and `bash -n` on a set of bash files.
#
# This can be run on any directory tree to test scripts in any application.
#
# Shell comments must not be immediately after a function end, e.g. this is invalid:
#
#     myFunc() {
#     }
#     # Hey
#
# Example:     bashLint goo.sh
# Argument: script - Shell script to validate
# Side-effect: shellcheck is installed
# Side-effect: Status written to stdout, errors written to stderr
# Exit Code: 0 - All found files pass `shellcheck` and `bash -n` and shell comment syntax
# Exit Code: 1 - One or more files did not pass
# Output: This outputs `statusMessage`s to `stdout` and errors to `stderr`.
bashLint() {
  local usage="_${FUNCNAME[0]}"

  __catchEnvironment "$usage" packageWhich shellcheck shellcheck || return $?
  __catchEnvironment "$usage" packageWhich pcregrep pcregrep || return $?

  # Open 3 to pipe to nowhere
  exec 3>/dev/null
  local argument
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --verbose)
        decorate warning "Verbose on"
        exec 3>&1
        ;;
      *)
        [ -f "$argument" ] || __throwArgument "$usage" "$(printf -- "%s: %s PWD: %s" "Not a item" "$(decorate code "$argument")" "$(pwd)")" || return $?
        # shellcheck disable=SC2210
        __catchEnvironment "$usage" bash -n "$argument" 1>&3 || return $?
        # shellcheck disable=SC2210
        __catchEnvironment "$usage" shellcheck "$argument" 1>&3 || return $?
        local found
        if found=$(pcregrep -n -l -M '\n\}\n#' "$argument"); then
          __throwEnvironment "$usage" "$argument: pcregrep found }\\n#: $(decorate code "$found")" || return $?
        fi
        ;;
    esac
    shift || __throwArgument "$usage" "shifting $argument failed" || return $?
  done
}
_bashLint() {
  # _IDENTICAL_ usageDocument 1
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
# Argument: `file0` - Required - a item to look for matches in. Use `-` to read file list from `stdin`.
# Argument: `--` - Required. Separates files from text
# Argument: `text0` - Required. Text which must exist in each item
# Side-effect: Errors written to stderr, status written to stdout
# Summary: Check files for the existence of a string or strings
# Exit Code: 0 - All found files contain all text string or strings
# Exit Code: 1 - One or more files does not contain all text string or strings
# Exit Code: 2 - Arguments error (missing extension or text)
#
validateFileContents() {
  local usage="_${FUNCNAME[0]}"

  local fileArgs=() verboseMode=false binary=""

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --)
        shift || __throwArgument "$usage" "shift argument $(decorate code "$argument")" || return $?
        break
        ;;
      --verbose)
        verboseMode=true
        ;;
      --exec)
        shift || __throwArgument "$usage" "shift argument $(decorate code "$argument")" || return $?
        binary="$1"
        isCallable "$binary" || __throwArgument "$usage" "--exec $binary Not callable" || return $?
        ;;
      -)
        fileArgs=()
        ;;
      *)
        usageArgumentFile "$usage" "file${#fileArgs[@]}" "$1" >/dev/null || return $?
        fileArgs+=("$1")
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift || __throwArgument "$usage" "missing #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
  done

  local textMatches=()
  while [ $# -gt 0 ]; do
    local argument="$1"
    [ -n "$argument" ] || __throwArgument "$usage" "Zero size text match passed" || return $?
    case "$argument" in
      --)
        shift || __throwArgument "$usage" "shift argument $(decorate code "$argument")" || return $?
        break
        ;;
      *)
        textMatches+=("$1")
        ;;
    esac
    shift || __throwArgument "$usage" "shift argument $(decorate code "$argument")" || return $?
  done

  [ "${#textMatches[@]}" -gt 0 ] || __throwArgument "$usage" "No text match arguments" || return $?

  local failedReasons=() failedFiles=() total="${#fileArgs[@]}"

  # shellcheck disable=SC2059
  statusMessage decorate info "Searching $total $(plural "$total" item files) for text: $(printf -- " $(decorate reset)\"$(decorate code "%s")\"" "${textMatches[@]}")"

  local fileGenerator
  if [ "${#fileArgs[@]}" -gt 0 ]; then
    fileGenerator=("printf" "%s\n" "${fileArgs[@]}")
  else
    fileGenerator=("cat")
  fi
  total=0
  while read -r item; do
    total=$((total + 1))
    for text in "${textMatches[@]}"; do
      if ! grep -q "$text" "$item"; then
        failedReasons+=("$item missing \"$text\"")
        statusMessage decorate error "Searching $item ... $(decorate code "$text") NOT FOUND"
        failedFiles+=("$item")
      else
        ! $verboseMode || statusMessage decorate success "Searching $item ... $(decorate code "$text") found"
      fi
    done
  done < <("${fileGenerator[@]}")
  statusMessage decorate info "Checked $total $(plural $total item files) for ${#textMatches[@]} $(plural ${#textMatches[@]} phrase phrases)"

  if [ "${#failedReasons[@]}" -gt 0 ]; then
    statusMessage --last decorate error "The following scripts failed:" 1>&2
    local item
    for item in "${failedReasons[@]}"; do
      echo "    $(decorate magenta "$item")$(decorate info ", ")" 1>&2
    done
    decorate error "done." 1>&2
    if [ -n "$binary" ]; then
      "$binary" "${failedFiles[@]}"
    fi
    __throwEnvironment "$usage" "$this failed" || return $?
  else
    statusMessage decorate success "All scripts passed"
  fi
}
_validateFileContents() {
  # _IDENTICAL_ usageDocument 1
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
# Example:     validateFileContents sh php js -- 'Widgets LLC' 'Copyright &copy; 2025'
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
  [ "${#extensions[@]}" -gt 0 ] || __throwArgument "$usage" "No extension arguments" || return $?
  [ "${#textMatches[@]}" -gt 0 ] || __throwArgument "$usage" "No text match arguments" || return $?

  failedReasons=()
  total=0
  foundFiles=$(mktemp)
  # Final arguments for find
  find . "${extensionArgs[@]}" ! -path "*/.*/*" "$@" >"$foundFiles"
  total=$(($(wc -l <"$foundFiles") + 0))
  # shellcheck disable=SC2059
  statusMessage decorate info "Searching $total $(plural $total item files) (ext: ${extensions[*]}) for text: $(printf -- " $(decorate reset)\"$(decorate code "%s")\"" "${textMatches[@]}")"

  total=0
  while IFS= read -r item; do
    total=$((total + 1))
    for text in "${textMatches[@]}"; do
      if ! grep -q "$text" "$item"; then
        failedReasons+=("$item missing \"$text\"")
        statusMessage decorate error "Searching $item ... NOT FOUND"
      else
        statusMessage decorate success "Searching $item ... found"
      fi
    done
  done <"$foundFiles"
  statusMessage decorate info "Checked $total $(plural $total item files) for ${#textMatches[@]} $(plural ${#textMatches[@]} phrase phrases)"
  rm "$foundFiles"

  if [ "${#failedReasons[@]}" -gt 0 ]; then
    statusMessage --last decorate error "The following scripts failed:" 1>&2
    for item in "${failedReasons[@]}"; do
      echo "    $(decorate magenta "$item")$(decorate info ", ")" 1>&2
    done
    decorate error "done." 1>&2
    __throwEnvironment "$usage" "$this failed" || return $?
  else
    statusMessage decorate success "All scripts passed"
  fi
}

#
# Usage: {fn} [ --exec binary ] [ directory ]
# Search bash files for assertions which do not terminate a function and are likely an error
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
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --exec)
        shift || __throwArgument "$usage" "$argument missing argument" || return $?
        [ -n "$1" ] || __throwArgument "$usage" "$argument argument blank" || return $?
        binary="$1"
        ;;
      --list)
        listFlag=true
        ;;
      *)
        [ -z "$directory" ] || __throwArgument "$usage" "$this: Unknown argument" || return $?
        directory=$(usageArgumentDirectory "$usage" "directory" "$1") || return $?
        ;;
    esac
    shift || __throwArgument "$usage" "shift argument $(decorate code "$argument")" || return $?
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
  tempFile=$(fileTemporaryName "$usage") || return $?
  suffixCheck='(local|return|; then|\ \|\||:[0-9]+:\s*#|\(\)\ \{)'
  {
    find "${directory%/}" -type f -name '*.sh' ! -path "*/.*/*" -print0 | xargs -0 grep -n -E 'assert[A-Z]' | grep -E -v "$suffixCheck" || :
    find "${directory%/}" -type f -name '*.sh' ! -path "*/.*/*" -print0 | xargs -0 grep -n -E '_(clean|undo|argument|environment|return)' | grep -E -v "$suffixCheck" || :
    find "${directory%/}" -type f -name '*.sh' ! -path "*/.*/*" -print0 | xargs -0 grep -n -E '__(execute|try)' | grep -E -v "$suffixCheck" || :
  } >"$tempFile"

  if [ -s "$tempFile" ]; then
    if [ -n "$binary" ] || test $listFlag; then
      problemFile=
      lastProblemFile=
      while IFS='' read -r problemFile; do
        problemLine="${problemFile##*:}"
        problemFile="${problemFile%:*}"
        if [ "$problemFile" != "$lastProblemFile" ]; then
          # IDENTICAL findUncaughtAssertions-loop 3
          if test $listFlag && [ -n "$lastProblemFile" ]; then
            printf -- "%s (Lines %s)\n" "$(decorate code "$lastProblemFile")" "$(IFS=, decorate magenta "${problemLines[*]}")"
          fi
          problemFiles+=("$problemFile")
          lastProblemFile=$problemFile
          problemLines=()
        fi
        problemLines+=("$problemLine")
      done < <(cut -d : -f 1,2 <"$tempFile" | sort -u)
      # IDENTICAL findUncaughtAssertions-loop 3
      if test $listFlag && [ -n "$lastProblemFile" ]; then
        printf -- "%s (Lines %s)\n" "$(decorate code "$lastProblemFile")" "$(IFS=, decorate magenta "${problemLines[*]}")"
      fi
      if [ ${#problemFiles[@]} -gt 0 ] && [ -n "$binary" ]; then
        "$binary" "${problemFiles[@]}"
      fi
    else
      cat "$tempFile"
    fi
  fi
  __catchEnvironment "$usage" rm "$tempFile" || return $?
  [ ${#problemFiles[@]} -eq 0 ]
}
_findUncaughtAssertions() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
