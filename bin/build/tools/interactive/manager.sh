#!/usr/bin/env bash
#
# interactiveManager
#
# Copyright &copy; 2025 Market Acumen, Inc.

# Usage: {fn} loopCallable fileToCheck ...
# Argument: loopCallable - Required. Callable. Call this on each file and a zero result code means passed and non-zero means fails.
# Argument: --exec binary - Optional. Callable. Run binary with files as an argument for any failed files. Only works if you pass in item names.
# Argument: --delay delaySeconds - Optional. Integer. Delay in seconds between checks in interactive mode.
# Argument: fileToCheck ... - Optional. File. Shell file to validate. May also supply file names via stdin.
# Run checks interactively until errors are all fixed.
# Not ready for prime time yet - written not tested.
__interactiveManager() {
  local handler="$1" && shift

  local binary="" repairFunction"" loopCallable="" files=() sleepDelay=15

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --exec)
      shift
      binary="$(usageArgumentCallable "$argument" "${1-}")" || return $?
      ;;
    --delay)
      shift
      sleepDelay=$(usageArgumentUnsignedInteger "$handler" "$argument" "${1-}") || return $?
      ;;
    --repair)
      shift
      repairFunction=$(usageArgumentCallable "$handler" "$argument" "${1-}") || return $?
      ;;
    *)
      if [ -z "$loopCallable" ]; then
        loopCallable=$(usageArgumentCallable "$handler" "loopCallable" "$1") || return $?
      else
        files+=("$(usageArgumentFile "$handler" "fileToCheck" "$1")") || return $?
      fi
      ;;
    esac
    shift
  done

  [ -n "$loopCallable" ] || throwArgument "$handler" "No loopCallable" || return $?

  if [ "${#files[@]}" -eq 0 ]; then
    while read -r file; do files+=("$(usageArgumentFile "$handler" "fileToCheck (stdin)" "$1")") || return $?; done
    [ "${#files[@]}" -gt 0 ] || return 0
  fi

  [ "${#files[@]}" -gt 0 ] || throwArgument "$handler" "No files supplied" || return $?

  # Validation complete

  local rowsAllowed output index=1 didClear=false triedRepair

  rowsAllowed=$(catchReturn "$handler" consoleRows) || return $?
  rowsAllowed=$((rowsAllowed - 4))
  output=$(fileTemporaryName "$handler") || return $?
  index=1

  local file nextMessage=""
  for file in "${files[@]}"; do
    triedRepair=false
    while ! "$loopCallable" "$file" >"$output" 2>&1; do
      didClear=true
      clear
      message="$(decorate code "$file") failed $(decorate error "$loopCallable")"
      if ! $triedRepair && [ -n "$repairFunction" ]; then
        triedRepair=true
        if ! "$repairFunction" "$file" >"$output"; then
          message="$message ($repairFunction failed)"
        fi
        if ! "$loopCallable" "$file" >"$output"; then
          message="$message (not repaired)"
        fi
      fi
      boxedHeading --size 1 "$message"
      dumpPipe --head --lines "$rowsAllowed" "OUTPUT" <"$output"
      if [ $index -eq "${#files[@]}" ]; then
        nextMessage=$(decorate green "(last one)")
      else
        nextMessage="$(printf -- "(%s %s)" "$(decorate subtle "next file is")" "$(decorate code "${files["$index"]}")")"
      fi
      printf "%s %s %s files %s" "$(decorate bold-green "$index")" "$(decorate subtle "of")" "$(decorate bold-blue "${#files[@]}")" "$nextMessage"
      if [ -n "$binary" ]; then
        "$binary" "$file"
      fi
      sleep "$sleepDelay" || throwEnvironment "$handler" "Interrupt ..." || returnClean $? "$output" || return $?
    done
    index=$((index + 1))
  done
  if $didClear; then
    clear
    decorate success "All files now pass:"
    printf -- "- %s\n" "${files[@]}"
  fi
}
