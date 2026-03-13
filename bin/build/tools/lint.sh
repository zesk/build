#!/usr/bin/env bash
#
# lint.sh
#
# Bash linting
#
# Copyright &copy; 2026 Market Acumen, Inc.

# Summary: Check bash files for common errors
# See: shellcheck
# See: bashSanitize
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
# Argument: --help - Flag. Optional. Display this help.
# Argument: --fix - Flag. Optional. Fix files when possible.
# Argument: --verbose - Flag. Optional. Be verbose.
# Argument: script - File. Optional. Shell script to validate
# Side-effect: shellcheck is installed
# Side-effect: Status written to stdout, errors written to stderr
# Return Code: 0 - All found files pass `shellcheck` and `bash -n` and shell comment syntax
# Return Code: 1 - One or more files did not pass
# Output: This outputs `statusMessage`s to `stdout` and errors to `stderr`.
bashLint() {
  local handler="_${FUNCNAME[0]}" fixFlag=false verboseFlag=false
  local installed=false

  # Open 3 and 4 to aliases so we can change them
  exec 3>/dev/null 4>&1
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --fix)
      fixFlag=true
      ;;
    --verbose)
      exec 3>&1 4>/dev/null
      verboseFlag=true
      ;;
    *)
      if ! $installed; then
        catchReturn "$handler" packageWhich shellcheck shellcheck || return $?
        catchReturn "$handler" pcregrepInstall || return $?
        installed=true
      fi
      if ! [ -f "$argument" ]; then
        throwArgument "$handler" "$(printf -- "%s: %s PWD: %s" "Not a item" "$(decorate code "$argument")" "$(pwd)")" || return $?
      fi

      # shellcheck disable=SC2210
      catchEnvironment "$handler" bash -n "$argument" 1>&3 2>&4 || returnUndo $? printf "%s\n" "bash -n" 1>&4 || ! exec 3>&- 4>&- || return $?
      # shellcheck disable=SC2210
      catchEnvironment "$handler" shellcheck "$argument" 1>&3 2>&4 || returnUndo $? printf "%s\n" "shellcheck" 1>&4 || ! exec 3>&- 4>&- || return $?
      local found
      if found=$(__pcregrep -n -l -M '\n\}\n#' "$argument"); then
        if $fixFlag; then
          catchEnvironment "$handler" sed -i 's/}\n#/}\n\n#/' "$argument" || returnUndo $? printf "%s\n" "comment following brace" 1>&4 || ! exec 3>&- 4>&- || return $?
          $verboseFlag
        else
          throwEnvironment "$handler" "found }\\n#: $(decorate code "$found")" 1>&3 2>&3 || returnUndo $? printf "%s\n" "comment following brace" 1>&4 || ! exec 3>&- 4>&- || return $?
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
# Example:     if bashLintFiles; then git commit -m "saving things" -a; fi
# Argument: --verbose - Flag. Optional. Verbose mode.
# Argument: --fix - Flag. Optional. Fix errors when possible.
# Argument: --interactive - Flag. Optional. Interactive mode on fixing errors.
# Argument: --exec binary - Run binary with files as an argument for any failed files. Only works if you pass in item names.
# Argument: --delay - Integer. Optional. Delay between checks in interactive mode.
# Argument: findArgs - Additional find arguments for .sh files (or exclude directories).
# Side-effect: shellcheck is installed
# Side-effect: Status written to stdout, errors written to stderr
# Environment: This operates in the current working directory
# Summary: Check files for the existence of a string
# Return Code: 0 - All found files pass `shellcheck` and `bash -n`
# Return Code: 1 - One or more files did not pass
# Output: This outputs `statusMessage`s to `stdout` and errors to `stderr`.
bashLintFiles() {
  local handler="_${FUNCNAME[0]}"

  local verbose=false failedFiles=() checkedFiles=() binary="" sleepDelay=7 ii=() interactive=false ff=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose)
      verbose=true
      ;;
    --fix)
      ff=("$argument")
      ;;
    --exec)
      shift
      binary="$(validate "$handler" Callable "$argument" "${1-}")" || return $?
      ii+=("$argument" "$binary")
      ;;
    --interactive)
      interactive=true
      ;;
    *)
      checkedFiles+=("$(validate "$handler" File "checkFile" "$argument")") || return $?
      ;;
    esac
    shift || throwArgument "$handler" "shift after $argument failed" || return $?
  done

  catchReturn "$handler" buildEnvironmentLoad BUILD_INTERACTIVE_REFRESH || return $?
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
        statusMessage decorate warning "Failed: $(decorate file "$argument") $message)"
        failedFiles+=("$argument")
      fi
    done
  fi
  if [ "${#failedFiles[@]}" -gt 0 ]; then
    {
      statusMessage --last printf -- "%s\n" "$(decorate warning "$(pluralWord ${#failedFiles[@]} file) failed:")"
      for failedFile in "${failedFiles[@]}"; do
        bashLint "${ff[@]+"${ff[@]}"}" --verbose "$failedFile" 2>/dev/null | dumpPipe "$(decorate warning "$(consoleHeadingLine "•" "••[ $(decorate file "$failedFile") ]")")"
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
  if reason=$(bashLint "${vv[@]+"${vv[@]}"}" "$file"); then
    ! $verbose || statusMessage --last decorate success "bashLint $file passed"
  else
    ! $verbose || statusMessage --last decorate info "bashLint $file failed: $reason"
    printf -- "%s\n" "$reason"
    return 1
  fi
}

# Argument: --exec binary - Callable. Optional. Run binary with files as an argument for any failed files. Only works if you pass in item names.
# Argument: --delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode.
# Argument: fileToCheck ... - File. Optional. Shell file to validate.
# Run checks interactively until errors are all fixed.
bashLintFilesInteractive() {
  local handler="_${FUNCNAME[0]}"

  local sleepDelay="" binary=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --exec) shift && binary="$(validate "$handler" Callable "$argument" "${1-}")" || return $? ;;
    --delay) shift && sleepDelay=$(validate "$handler" UnsignedInteger "$argument" "${1-}") || return $? ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  printf -- "%s\n%s\n%s\n" "$(decorate red "BEFORE")" \
    "$(decorate label "Queue")" \
    "$(decorate subtle "$(printf -- "- %s\n" "$@")")"

  while [ "$#" -gt 0 ]; do
    if _bashLintInteractiveCheck "$handler" "$@"; then
      shift
    else
      local countdown=$sleepDelay
      while [ "$countdown" -gt 0 ]; do
        statusMessage decorate warning "Refresh in $(decorate value " $countdown ") $(plural "$countdown" second seconds)"
        countdown=$((countdown - 1))
        sleep 1 || throwEnvironment "$handler" "Interrupt ..." || return $?
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
  local handler="${1-}" script="${2-}" scriptPassed
  if [ -z "$script" ]; then
    return 0
  fi
  if failedReason=$(bashLint --verbose "$1"); then
    scriptPassed=true
  else
    scriptPassed=false
  fi
  if $scriptPassed; then
    decorate big "SUCCESS $(basename "$script")" | decorate green
    consoleHeadingBoxed "$script now passes" | decorate BOLD green
    decorate orange "$(consoleLine "*")"
    return 0
  fi

  shift 2
  decorate big "FAIL $(basename "$script")" | decorate BOLD red | decorate wrap "$(decorate subtle "bashLint ")"
  printf -- "%s\n%s\n%s\n" "$(decorate red "$failedReason")" \
    "$(decorate label "Queue")" \
    "$(decorate subtle "$(printf -- "- %s\n" "$@")")"
  decorate blue "$(consoleLine "+-")"
  decorate info "$# $(plural $# item files) remain"
  return 1
}

# Search bash files for assertions which do not terminate a function and are likely an error
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# Argument: --exclude path - String. Optional. Exclude paths which contain this string
# Argument: --exec binary - Executable. Optional. For each failed file run this command.
# Argument: directory - Directory. Optional. Where to search for files to check.
# Argument: --list - Flag. Optional. List files which fail. (Default is simply to exit silently.)
bashFindUncaughtAssertions() {
  local handler="_${FUNCNAME[0]}"

  local listFlag=false binary="" directory="" ff=()

  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || throwArgument "$handler" "blank argument" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --exec) shift && binary="$(validate "$handler" Callable "$argument" "${1-}")" || return $? ;;
    --exclude) shift && ff+=(! -path "*$(validate "$handler" String "$argument" "${1-}")*") || return $? ;;
    --list) listFlag=true ;;
    *)
      if [ -n "$directory" ]; then
        # _IDENTICAL_ argumentUnknownHandler 1
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      directory=$(validate "$handler" Directory "directory" "$1") || return $?
      ;;
    esac
    shift
  done

  [ -n "$directory" ] || directory=$(catchReturn "$handler" pwd) || return $?

  #
  # All OK with "assert"
  #
  # local assertThing
  # assertEquals "a" "a" || return $?
  # if ! assertEquals "a" "a" || \
  # test/tools/assert-tests.sh:3:# assert-tests.sh
  # test/tools/os-tests.sh:110:_assertBetterType() {

  local tempFile
  tempFile=$(fileTemporaryName "$handler") || return $?
  local clean=("$tempFile")
  local suffixCheck='(local|return|; then|\ \|\||:[0-9]+:\s*#|\(\)\ \{)'
  {
    find "${directory%/}" -type f -name '*.sh' ! -path "*/.*/*" "${ff[@]+"${ff[@]}"}" -print0 | xargs -0 grep -n -E 'assert[A-Z]|usageArgument' | grep -E -v "$suffixCheck" || :
    find "${directory%/}" -type f -name '*.sh' ! -path "*/.*/*" "${ff[@]+"${ff[@]}"}" -print0 | xargs -0 grep -n -E 'return(Clean|Undo|Argument|Environment|Code)' | grep -E -v "$suffixCheck" || :
    find "${directory%/}" -type f -name '*.sh' ! -path "*/.*/*" "${ff[@]+"${ff[@]}"}" -print0 | xargs -0 grep -n -E '(execute|catch|throw)[A-Z ]' | grep -E -v "$suffixCheck" || :
  } >"$tempFile" || returnClean $? "${clean[@]}" || return $?

  local problemFiles=()
  if [ -s "$tempFile" ]; then
    if [ -n "$binary" ] || $listFlag; then
      local lastProblemFile="" problemLines=() problemFile=""
      while IFS='' read -r problemFile; do
        local problemLine="${problemFile##*:}"
        problemFile="${problemFile%:*}"
        if [ "$problemFile" != "$lastProblemFile" ]; then
          # IDENTICAL bashFindUncaughtAssertions-loop 3
          if $listFlag && [ -n "$lastProblemFile" ]; then
            printf -- "%s (Lines %s)\n" "$(decorate code "$lastProblemFile")" "$(IFS=, decorate magenta "${problemLines[*]}")"
          fi
          problemFiles+=("$problemFile")
          lastProblemFile=$problemFile
          problemLines=()
        fi
        problemLines+=("$problemLine")
      done < <(cut -d : -f 1,2 <"$tempFile" | sort -u)
      # IDENTICAL bashFindUncaughtAssertions-loop 3
      if $listFlag && [ -n "$lastProblemFile" ]; then
        printf -- "%s (Lines %s)\n" "$(decorate code "$lastProblemFile")" "$(IFS=, decorate magenta "${problemLines[*]}")"
      fi
      [ ${#problemFiles[@]} -eq 0 ] || [ -z "$binary" ] || catchReturn "$binary" "${problemFiles[@]}" || returnClean $? "${clean[@]}" || return $?
    else
      catchEnvironment "$handler" cat "$tempFile" || returnClean $? "${clean[@]}" || return $?
    fi
  fi
  catchEnvironment "$handler" rm "$tempFile" || return $?
  [ ${#problemFiles[@]} -eq 0 ]
}
_bashFindUncaughtAssertions() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
