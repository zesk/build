#!/usr/bin/env bash
#
# lint.sh
#
# Bash linting
#
# Copyright &copy; 2025 Market Acumen, Inc.

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
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --fix - Optional. Flag. Fix files when possible.
# Argument: script - File. Optional. Shell script to validate
# Argument: verbose - Flag. Optional. Be verbose.
# Argument: script - File. Optional. Shell script to validate
# Side-effect: shellcheck is installed
# Side-effect: Status written to stdout, errors written to stderr
# Exit Code: 0 - All found files pass `shellcheck` and `bash -n` and shell comment syntax
# Exit Code: 1 - One or more files did not pass
# Output: This outputs `statusMessage`s to `stdout` and errors to `stderr`.
bashLint() {
  local usage="_${FUNCNAME[0]}" fixFlag=false verboseFlag=false undo=("exec" "3>&-" "4>&1")

  __catch "$usage" packageWhich shellcheck shellcheck || return $?

  # Open 3 and 4 to aliases so we can change them
  exec 3>/dev/null 4>&1
  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --fix)
      fixFlag=true
      ;;
    --verbose)
      exec 3>&1 4>/dev/null
      verboseFlag=true
      ;;
    *)
      [ -f "$argument" ] || __throwArgument "$usage" "$(printf -- "%s: %s PWD: %s" "Not a item" "$(decorate code "$argument")" "$(pwd)")" || returnUndo $? "${undo[@]}" || return $?
      # shellcheck disable=SC2210
      __catchEnvironment "$usage" bash -n "$argument" 1>&3 2>&3 || returnUndo $? printf "%s\n" "bash -n failed" 1>&4 || returnUndo $? "${undo[@]}" || return $?
      # shellcheck disable=SC2210
      __catchEnvironment "$usage" shellcheck "$argument" 1>&3 2>&3 || returnUndo $? printf "%s\n" "shellcheck" 1>&4 || returnUndo $? "${undo[@]}" || return $?
      local found
      if found=$(__pcregrep -n -l -M '\n\}\n#' "$argument"); then
        if $fixFlag; then
          __catchEnvironment "$usage" sed -i ':a;N;$!ba;s/'$'\n'"}"$'\n'"#/"$'\n'"}$'\n'$'\n'#/g" "$argument" || returnUndo $? "${undo[@]}" || return $?
          $verboseFlag
        else
          __throwEnvironment "$usage" "found }\\n#: $(decorate code "$found")" 1>&3 2>&3 || returnUndo $? printf "%s\n" "comment following brace" 1>&4 || returnUndo $? "${undo[@]}" || return $?
        fi
      fi
      ;;
    esac
    shift
  done
  exec 3>&- 4>&1
}
_bashLint() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run `bashLint` on a set of bash files.
#
# Usage: bashLintFiles [ --exec binary ] [ file0 ... ]
# Example:     if bashLintFiles; then git commit -m "saving things" -a; fi
# Argument: --verbose - Flag. Optional. Verbose mode.
# Argument: --fix - Flag. Optional. Fix errors when possible.
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

  local verbose=false failedReasons=() failedFiles=() checkedFiles=() binary="" sleepDelay=7 ii=() interactive=false ff=()

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --verbose)
      verbose=true
      ;;
    --fix)
      ff=("$argument")
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

  __catch "$usage" buildEnvironmentLoad BUILD_INTERACTIVE_REFRESH || return $?
  statusMessage --first decorate info "Checking all shell scripts ..."

  local source=none
  if [ ${#checkedFiles[@]} -gt 0 ]; then
    source="argument"
    ! $verbose || statusMessage decorate info "Reading item list from arguments ..."
    for argument in "${checkedFiles[@]}"; do
      [ -n "$argument" ] || continue
      if ! message=$(_bashLintFilesHelper "$verbose" "$argument" "$source"); then
        statusMessage decorate warning "Failed: $(decorate file "$argument") $(decorate code "$message")"
        failedFiles+=("$argument")
      fi
    done
  elif [ $# -eq 0 ]; then
    source="stdin"
    ! $verbose || statusMessage decorate info "Reading item list from stdin ..."
    while read -r argument; do
      [ -n "$argument" ] || continue
      if ! message=$(_bashLintFilesHelper "$verbose" "$argument" "$source"); then
        statusMessage decorate warning "Failed: $(decorate file "$argument") $(decorate code "$message")"
        failedFiles+=("$argument")
      fi
    done
  fi
  if [ "${#failedFiles[@]}" -gt 0 ]; then
    {
      statusMessage --last printf -- "%s\n" "$(decorate warning "${#failedFiles[@]} $(plural ${#failedFiles[@]} file files) failed:")"
      for failedFile in "${failedFiles[@]}"; do
        bashLint "${ff[@]+"${ff[@]}"}" --verbose "$failedFile" 2>/dev/null | dumpPipe "$(decorate warning "$(lineFill "•" "••[ $(decorate file "$failedFile") ]")")"
      done
    } 1>&2
    if $interactive; then
      bashLintFilesInteractive "${ii[@]+"${ii[@]}"}" "${failedFiles[@]}"
    elif [ -n "$binary" ]; then
      if [ ${#failedFiles[@]} -gt 0 ]; then
        "$binary" "${failedFiles[@]}"
      fi
    fi
    return 1
  fi
  statusMessage decorate success "All scripts passed validation ($source)"
  printf -- "\n"
}
_bashLintFiles() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Handle check consistently
_bashLintFilesHelper() {
  local verbose="$1" file="$2" source="$3" reason vv=()

  ! $verbose || vv+=(--verbose)
  ! $verbose || statusMessage decorate info "👀 Checking \"$file\" ($source) ..." || :
  if reason=$(bashLint "${vv[@]+"${vv[@]}"}" "$file" 1>/dev/null 2>/dev/null); then
    ! $verbose || statusMessage --last decorate success "bashLint $file passed"
  else
    ! $verbose || statusMessage --last decorate info "bashLint $file failed: $reason"
    printf -- "%s\n" "$reason"
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
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
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
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
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
  # __IDENTICAL__ usageDocument 1
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
    bigText "SUCCESS $(basename "$script")" | decorate green
    boxedHeading "$script now passes" | decorate bold-green
    decorate orange "$(echoBar "*")"
    return 0
  fi

  shift 2
  bigText "FAIL $(basename "$script")" | decorate bold-red | decorate wrap "$(decorate subtle "bashLint ")"
  printf -- "%s\n%s\n%s\n" "$(decorate red "$failedReason")" \
    "$(decorate label "Queue")" \
    "$(decorate subtle "$(printf -- "- %s\n" "$@")")"
  decorate blue "$(echoBar "+-")"
  decorate info "$# $(plural $# item files) remain"
  return 1
}

# Search bash files for assertions which do not terminate a function and are likely an error
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Optional. Function. Use this error handler instead of the default error handler.
# Argument: --exec binary - Executable. Optional. For each failed file run this command.
# Argument: directory - Directory. Optional. Where to search for files to check.
# Argument: --list - Flag. Optional. List files which fail. (Default is simply to exit silently.)
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
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    # _IDENTICAL_ --handler 4
    --handler)
      shift
      usage=$(usageArgumentFunction "$usage" "$argument" "${1-}") || return $?
      ;;
    --exec)
      shift || __throwArgument "$usage" "$argument missing argument" || return $?
      [ -n "$1" ] || __throwArgument "$usage" "$argument argument blank" || return $?
      binary="$1"
      ;;
    --list)
      listFlag=true
      ;;
    *)
      if [ -n "$directory" ]; then
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      fi
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
    find "${directory%/}" -type f -name '*.sh' ! -path "*/.*/*" -print0 | xargs -0 grep -n -E 'assert[A-Z]|usageArgument' | grep -E -v "$suffixCheck" || :
    find "${directory%/}" -type f -name '*.sh' ! -path "*/.*/*" -print0 | xargs -0 grep -n -E '_(clean|undo|argument|environment|return)' | grep -E -v "$suffixCheck" || :
    find "${directory%/}" -type f -name '*.sh' ! -path "*/.*/*" -print0 | xargs -0 grep -n -E '__(execute|catch|throw)' | grep -E -v "$suffixCheck" || :
  } >"$tempFile"

  if [ -s "$tempFile" ]; then
    if [ -n "$binary" ] || $listFlag; then
      problemFile=
      lastProblemFile=
      while IFS='' read -r problemFile; do
        problemLine="${problemFile##*:}"
        problemFile="${problemFile%:*}"
        if [ "$problemFile" != "$lastProblemFile" ]; then
          # IDENTICAL findUncaughtAssertions-loop 3
          if $listFlag && [ -n "$lastProblemFile" ]; then
            printf -- "%s (Lines %s)\n" "$(decorate code "$lastProblemFile")" "$(IFS=, decorate magenta "${problemLines[*]}")"
          fi
          problemFiles+=("$problemFile")
          lastProblemFile=$problemFile
          problemLines=()
        fi
        problemLines+=("$problemLine")
      done < <(cut -d : -f 1,2 <"$tempFile" | sort -u)
      # IDENTICAL findUncaughtAssertions-loop 3
      if $listFlag && [ -n "$lastProblemFile" ]; then
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
  # __IDENTICAL__ usageDocument 1
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
  local usage="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0

  local extensionArgs=() extensions=()
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

  local textMatches=()
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

  local failedReasons=() total=0 foundFiles
  foundFiles=$(fileTemporaryName "$usage")
  # Final arguments for find
  find . "${extensionArgs[@]}" ! -path "*/.*/*" "$@" >"$foundFiles"
  total=$(__catch "$usage" fileLineCount "$foundFiles") || return $?
  # shellcheck disable=SC2059
  statusMessage decorate info "Searching $total $(plural "$total" item files) (ext: ${extensions[*]}) for text: $(printf -- " $(decorate reset --)\"$(decorate code "%s")\"" "${textMatches[@]}")"

  total=0
  local item
  while IFS= read -r item; do
    total=$((total + 1))
    local text
    for text in "${textMatches[@]}"; do
      if ! grep -q "$text" "$item"; then
        failedReasons+=("$item missing \"$text\"")
        statusMessage decorate error "Searching $item ... NOT FOUND"
      else
        statusMessage decorate success "Searching $item ... found"
      fi
    done
  done <"$foundFiles"
  statusMessage decorate info "Checked $total $(plural "$total" item files) for ${#textMatches[@]} $(plural ${#textMatches[@]} phrase phrases)"
  rm "$foundFiles"

  if [ "${#failedReasons[@]}" -gt 0 ]; then
    statusMessage --last decorate error "The following scripts failed:" 1>&2
    for item in "${failedReasons[@]}"; do
      echo "    $(decorate magenta "$item")$(decorate info ", ")" 1>&2
    done
    decorate error "done." 1>&2
    __throwEnvironment "$usage" "${FUNCNAME[0]} failed" || return $?
  else
    statusMessage decorate success "All scripts passed"
  fi
}
_validateFileExtensionContents() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

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
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
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
    shift
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
  statusMessage decorate info "Searching $total $(plural "$total" item files) for text: $(printf "%s\n" "${textMatches[@]}" | decorate code | decorate wrap "- ")"

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
    __throwEnvironment "$usage" "${FUNCNAME[0]} failed" || return $?
  else
    statusMessage decorate success "All scripts passed"
  fi
}
_validateFileContents() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
