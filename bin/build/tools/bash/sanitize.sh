#!/usr/bin/env bash
#
# bash linting functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/bash.md
# Test: ./test/tools/bash-tests.sh

# Sanitize bash files for code quality.
#
# Usage: {fn} [ --help ] [ --interactive ] [ --check checkDirectory ] ...
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: -- - Flag. Optional. Interactive mode on fixing errors.
# Argument: --home home - Optional. Directory. Sanitize files starting here. (Defaults to `buildHome`)
# Argument: --interactive - Flag. Optional. Interactive mode on fixing errors.
# Argument: --check checkDirectory - Optional. Directory. Check shell scripts in this directory for common errors.
# Argument: ... - Additional arguments are passed to `bashLintFiles` `validateFileContents`
# Placing a `.debugging` file in your project with a list of permitted files which contain debugging (`set` with `-x`)
# Configuration File: .debugging (list of file paths which are ok to allow debugging)
# Configuration File: .check-assertions (location determines check root)
# Configuration File: .skip-lint (file patterns to skip lint check, one per line)
# Configuration File: .skip-copyright (file patterns to skip copyright check, one per line)
# See: buildHome
bashSanitize() {
  local handler="_${FUNCNAME[0]}"

  local home checkAssertions=() executor=contextOpen

  home=$(__catch "$handler" buildHome) || return $?

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --exec)
      shift
      executor=$(usageArgumentCallable "$handler" "$argument" "${1-}") || return $?
      ;;
    --home)
      shift
      home=$(usageArgumentDirectory "$handler" "$argument" "${1-}") || return $?
      ;;
    --check)
      shift || __throwArgument "$handler" "shift $argument" || return $?
      checkAssertions+=("$(usageArgumentDirectory "$handler" "checkDirectory" "$1")") || return $?
      ;;
    *)
      break
      ;;
    esac
    shift || :
  done

  local fileList

  fileList=$(fileTemporaryName "$handler") || return $?
  if [ "$#" -eq 0 ]; then
    __catchEnvironment "$handler" cat >"$fileList" || return $?
  else
    __catchEnvironment "$handler" printf "%s\n" "$@" >"$fileList" || return $?
  fi

  local undo=()

  # CHANGE DIRECTORY HERE
  __catchEnvironment "$handler" muzzle pushd "$home" || return $?
  [ "$home" = "$(pwd)" ] || __throwEnvironment "$handler" "Unable to cd to $home" || return $?
  undo=(muzzle popd)

  statusMessage decorate success Making shell files executable ...

  local shellFile
  while read -r shellFile; do
    statusMessage decorate info "+x $(decorate file "$shellFile")"
  done < <(__catchEnvironment "$handler" makeShellFilesExecutable) || returnUndo $? "${undo[@]}" || return $?

  if [ ${#checkAssertions[@]} -eq 0 ]; then
    checkAssertions+=("$(pwd)")
  fi

  statusMessage --last decorate success Checking assertions ...
  _bashSanitizeCheckAssertions "$handler" "${checkAssertions[@]+"${checkAssertions[@]}"}" || returnUndo $? "${undo[@]}" || return $?

  # Operates on specific files
  statusMessage decorate success Checking syntax ...
  _bashSanitizeCheckLint "$handler" <"$fileList" || returnUndo $? "${undo[@]}" || returnClean $? "$fileList" || return $?

  statusMessage decorate success Checking copyright ...
  _bashSanitizeCheckCopyright "$handler" <"$fileList" || returnUndo $? "${undo[@]}" || returnClean $? "$fileList" || return $?

  statusMessage decorate success Checking debugging ...
  _bashSanitizeCheckDebugging "$handler" <"$fileList" || returnUndo $? "${undo[@]}" || returnClean $? "$fileList" || return $?
  rm -rf "$fileList" || :
  __catchEnvironment "$handler" "${undo[@]}" || return $?
  statusMessage decorate success Completed ...
  printf "\n"
}
_bashSanitize() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_bashSanitizeCheckLint() {
  local handler="$1" && shift

  statusMessage decorate success "Running bashLintFiles ..." || :
  __catchEnvironment "$handler" bashLintFiles --fix || return $?
}

_bashSanitizeCheckAssertions() {
  local handler="$1" && shift
  while [ $# -gt 0 ]; do
    statusMessage --first decorate warning "Checking assertions in $(decorate file "$1") ... "
    if ! findUncaughtAssertions "$1" --list; then
      # When ready - add --interactive here as well
      findUncaughtAssertions "$1" --exec "$executor" &
      __throwEnvironment "$handler" findUncaughtAssertions "$1" --list || return $?
    else
      decorate success "all files passed"
    fi
    shift
  done
}

_bashSanitizeCheckCopyright() {
  local file line handler="$1" && shift
  local matches year copyrightExceptions=()

  while read -r file; do
    while read -r line; do
      copyrightExceptions+=("$line")
    done <"$file"
  done < <(find . -name ".skip-copyright" -type f ! -path "*/.*/*")
  export BUILD_COMPANY
  __catch "$handler" buildEnvironmentLoad BUILD_COMPANY || return $?

  year="$(date +%Y)"
  statusMessage decorate warning "Checking $year and $BUILD_COMPANY ..." || :
  matches=$(fileTemporaryName "$handler") || return $?
  if fileNotMatches "Copyright &copy; $year" "$BUILD_COMPANY" -- "${copyrightExceptions[@]+"${copyrightExceptions[@]}"}" -- - >"$matches"; then
    set +v
    while IFS=":" read -r file pattern; do
      error="$(decorate error "No pattern used")" pattern="$(decorate value "$pattern")" file="$(decorate code "$file")" mapEnvironment <<<"{error}: {pattern} missing from {file}"
    done <"$matches"
    __throwEnvironment "$handler" "File pattern check failed" || returnClean $? "$matches" || return $?
  fi
  set +v
}

_bashSanitizeCheckDebugging() {
  local handler="$1" && shift

  local matches
  matches=$(fileTemporaryName "$handler") || return $?

  if fileMatches 'set ["]\?-x' -- -- - >"$matches"; then
    local file line remain debugHash found=false
    while IFS=":" read -r file line remain; do
      [ -f "$file" ] || __throwEnvironment "$handler" "returned line \"$file $line $remain\" - not a file" || return $?
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
    __catchEnvironment "$handler" rm -rf "$matches" || return $?
    __throwEnvironment "$handler" "Debugging found" || return $?
  fi
  __catchEnvironment "$handler" rm -rf "$matches" || return $?
}
