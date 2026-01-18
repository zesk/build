#!/usr/bin/env bash
#
# bash linting functions
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/bash.md
# Test: ./test/tools/bash-tests.sh

__bashSanitize() {
  local handler="$1" && shift

  local home cad=() cax=() executor=contextOpen debugFlag=false

  local home
  home=$(catchReturn "$handler" buildHome) || return $?

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --exec) shift && executor=$(validate "$handler" callable "$argument" "${1-}") || return $? ;;
    --debug) debugFlag=true ;;
    --home) shift && home=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    --check) shift && cad+=("$(validate "$handler" Directory "checkDirectory" "$1")") || return $? ;;
    *) break ;;
    esac
    shift
  done

  local exceptions=()
  while read -r file; do
    local line eof=false
    while ! $eof; do
      read -r line || eof=true
      [ -n "$line" ] || continue
      exceptions+=("$line")
      cax+=(--exclude "$line")
    done <"$file"
    ! $debugFlag || statusMessage decorate info "Loaded $(pluralWord ${#exceptions} pattern) [$(decorate file "$file")]"
  done < <(find "$home" -name "bashSanitize.conf" -type f ! -path "*/.*/*")

  local fileList

  fileList=$(fileTemporaryName "$handler") || return $?
  if [ "$#" -eq 0 ]; then
    catchEnvironment "$handler" cat >"$fileList" || return $?
  else
    catchEnvironment "$handler" printf "%s\n" "$@" >"$fileList" || return $?
  fi

  local undo=()

  # CHANGE DIRECTORY HERE
  catchEnvironment "$handler" muzzle pushd "$home" || return $?
  [ "$home" = "$(pwd)" ] || throwEnvironment "$handler" "Unable to cd to $home" || return $?
  undo=(muzzle popd)

  statusMessage decorate success Making shell files executable ...

  local shellFile
  while read -r shellFile; do
    statusMessage decorate info "+x $(decorate file "$shellFile")"
  done < <(catchEnvironment "$handler" makeShellFilesExecutable) || returnUndo $? "${undo[@]}" || return $?

  if [ ${#cad[@]} -eq 0 ]; then
    cad+=("$(pwd)")
  fi

  statusMessage --last decorate success Checking assertions ...
  _bashSanitizeCheckAssertions "$handler" "$executor" "${cad[@]+"${cad[@]}"}" -- "${cax[@]+"${cax[@]}"}" || returnUndo $? "${undo[@]}" || return $?

  # Operates on specific files
  statusMessage decorate success Checking syntax ...
  _bashSanitizeCheckLint "$handler" <"$fileList" || returnUndo $? "${undo[@]}" || returnClean $? "$fileList" || return $?

  statusMessage decorate success Checking copyright ...
  _bashSanitizeCheckCopyright "$handler" "$debugFlag" "${exceptions[@]+"${exceptions[@]}"}" <"$fileList" || returnUndo $? "${undo[@]}" || returnClean $? "$fileList" || return $?

  statusMessage decorate success Checking debugging ...
  _bashSanitizeCheckDebugging "$handler" <"$fileList" || returnUndo $? "${undo[@]}" || returnClean $? "$fileList" || return $?
  rm -rf "$fileList" || :
  catchEnvironment "$handler" "${undo[@]}" || return $?
  statusMessage decorate success Completed ...
  printf "\n"
}

_bashSanitizeCheckLint() {
  local handler="$1" && shift

  statusMessage decorate success "Running bashLintFiles ..." || :
  catchEnvironment "$handler" bashLintFiles --fix || return $?
}

_bashSanitizeCheckAssertions() {
  local handler="$1" && shift
  local executor="$1" && shift
  local directories=()

  while [ $# -gt 0 ]; do
    case "$1" in
    --) shift && break ;;
    *) directories+=("$1") ;;
    esac
    shift
  done
  local directory && for directory in "${directories[@]}"; do
    statusMessage --first decorate warning "Checking assertions in $(decorate file "$directory") ... "
    if ! findUncaughtAssertions "$directory" --list "$@"; then
      # When ready - add --interactive here as well
      findUncaughtAssertions "$directory" "$@" --exec "$executor" &
      throwEnvironment "$handler" findUncaughtAssertions "$directory" --list "$@" || return $?
    else
      decorate success "all files passed"
    fi
    shift
  done
}

# Argument: handler - Function. Required.
# Argument: debugFlag - Boolean. Required.
# Argument: exceptions ... - Arguments. Optional. List of path exceptions. Simple string contains match.
_bashSanitizeCheckCopyright() {
  local handler="$1" && shift
  local debugFlag="$1" && shift

  home=$(catchReturn "$handler" buildHome) || return $?

  local file exceptions=("$@")
  set --
  company=$(catchReturn "$handler" buildEnvironmentGet BUILD_COMPANY) || return $?

  local year
  year="$(date +%Y)"
  statusMessage decorate warning "Checking $year and $company ..." || :
  local matches
  matches=$(fileTemporaryName "$handler") || return $?
  local command=(fileNotMatches "Copyright &copy; $year" "$company" -- "${exceptions[@]+"${exceptions[@]}"}" -- -)
  if "${command[@]}" >"$matches"; then
    set +v
    while IFS=":" read -r file pattern; do
      error="$(decorate error "No pattern used")" pattern="$(decorate value "$pattern")" file="$(decorate code "$file")" mapEnvironment <<<"{error}: {pattern} missing from {file}"
    done <"$matches"
    ! $debugFlag || decorate each quote "${command[@]}"
    throwEnvironment "$handler" "File pattern check failed" || returnClean $? "$matches" || return $?
  fi
}

_bashSanitizeCheckDebugging() {
  local handler="$1" && shift

  local matches
  matches=$(fileTemporaryName "$handler") || return $?

  if fileMatches 'set ["]\?-x' -- -- - >"$matches"; then
    local file line remain debugHash found=false
    while IFS=":" read -r file line remain; do
      [ -f "$file" ] || throwEnvironment "$handler" "returned line \"$file $line $remain\" - not a file" || return $?
      debugHash="$(sed -e "${line}p" -e d <"$file" | shaPipe)"
      if grep -q -e "Debugging: $debugHash" "$file"; then
        continue
      fi
      found=true
      message=$(debugHash=$debugHash file="$(decorate code "$file")" error="$(decorate error "debugging used")" line="$(decorate value "$line")" remain="$(decorate code "$remain")" mapEnvironment <<<"{error}: {file}:{line} @ {remain} # Debugging: {debugHash}")
      statusMessage --last printf "%s\n" "$message"
    done <"$matches"
    $found || return 0
    statusMessage --last dumpPipe "Debugging matches:" "${BASH_SOURCE[0]}" <"$matches"
    catchEnvironment "$handler" rm -rf "$matches" || return $?
    throwEnvironment "$handler" "Debugging found" || return $?
  fi
  catchEnvironment "$handler" rm -rf "$matches" || return $?
}
