#!/usr/bin/env bash
#
# bash functions
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: ./docs/_templates/tools/bash.md
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
# Argument: ... - Additional arguments are passed to `validateShellScripts` `validateFileContents`
# Placing a `.debugging` file in your project with a list of permitted files which contain debugging (`set` with `-x`)
# Configuration File: .debugging (list of file paths which are ok to allow debugging)
# Configuration File: .check-assertions (location determines check root)
# See: buildHome
bashSanitize() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved fileList
  local executor home directory checkAssertions item debugPatterns undo=()

  home=$(__usageEnvironment "$usage" buildHome) || return $?
  checkAssertions=()
  saved=("$@")
  nArguments=$#
  executor=contextOpen
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --exec)
        shift
        executor=$(usageArgumentCallable "$usage" "$argument" "${1-}") || return $?
        ;;
      --home)
        shift
        home=$(usageArgumentDirectory "$usage" "$argument" "${1-}") || return $?
        ;;
      --check)
        shift || __failArgument "$usage" "shift $argument" || return $?
        checkAssertions+=("$(usageArgumentDirectory "$usage" "checkDirectory" "$1")") || return $?
        ;;
      *)
        break
        ;;
    esac
    shift || :
  done

  fileList=$(__usageEnvironment "$usage" mktemp) || return $?
  if [ "$#" -eq 0 ]; then
    __usageEnvironment "$usage" cat >"$fileList" || return $?
  else
    __usageEnvironment "$usage" printf "%s\n" "$@" >"$fileList" || return $?
  fi

  # CHANGE DIRECTORY HERE
  __usageEnvironment "$usage" muzzle pushd "$home" || return $?
  assertEquals "$home" "$(pwd)" || return $?
  undo=(muzzle popd)

  statusMessage consoleSuccess Making shell files executable ...
  __usageEnvironment "$usage" makeShellFilesExecutable || _undo $? "${undo[@]}" || return $?

  statusMessage consoleSuccess Checking assertions ...
  _bashSanitizeCheckAssertions "$usage" "${checkAssertions[@]+"${checkAssertions[@]}"}" || _undo $? "${undo[@]}" || return $?

  # Operates on specific files
  statusMessage consoleSuccess Checking syntax ...
  _bashSanitizeCheckSyntax "$usage" <"$fileList" || _undo $? "${undo[@]}" || _clean $? "$fileList" || return $?

  statusMessage consoleSuccess Checking copyright ...
  _bashSanitizeCheckCopyright "$usage" <"$fileList" || _undo $? "${undo[@]}" || _clean $? "$fileList" || return $?

  statusMessage consoleSuccess Checking debugging ...
  _bashSanitizeCheckDebugging "$usage" <"$fileList" || _undo $? "${undo[@]}" || _clean $? "$fileList" || return $?
  rm -rf "$fileList" || :
  __usageEnvironment "$usage" "${undo[@]}" || return $?
  statusMessage consoleSuccess Completed ...
  printf "\n"
}
_bashSanitize() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_bashSanitizeCheckSyntax() {
  local usage="$1" && shift

  statusMessage consoleSuccess "Running shellcheck ..." || :
  __usageEnvironment "$usage" validateShellScripts || return $?
}

_bashSanitizeCheckAssertions() {
  local usage="$1" && shift
  local item checkAssertions directory

  checkAssertions=("$@")
  while read -r item; do
    checkAssertions+=("$(__usageEnvironment "$usage" dirname "${item}")") || return $?
  done < <(find "." -type f -name '.check-assertions' ! -path '*/.*')

  for directory in "${checkAssertions[@]+"${checkAssertions[@]}"}"; do
    statusMessage consoleWarning "Checking assertions in $(consoleCode "${directory}") - " || :
    if ! findUncaughtAssertions "$directory" --list; then
      # When ready - add --interactive here as well
      findUncaughtAssertions "$directory" --exec "$executor" &
      __failEnvironment "$usage" findUncaughtAssertions || return $?
    fi
  done
}

_bashSanitizeCheckCopyright() {
  local file line usage="$1" && shift
  local year copyrightExceptions=()

  while read -r file; do
    while read -r line; do
      copyrightExceptions+=("$line")
    done <"$file"
  done < <(find . -name ".skip-copyright" -type f ! -path '*/.*')
  export BUILD_COMPANY
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_COMPANY || return $?

  year="$(date +%Y)"
  statusMessage consoleWarning "Checking $year and $BUILD_COMPANY ..." || :
  if fileNotMatches "Copyright &copy; $year" "$BUILD_COMPANY" -- "${copyrightExceptions[@]+"${copyrightExceptions[@]}"}" -- - >"$matches"; then
    while IFS=":" read -r file pattern; do
      error="$(consoleError "No pattern found")" pattern="$(consoleValue "$pattern")" file="$(consoleCode "$file")" mapEnvironment <<<"{error}: {pattern} missing from {file}"
    done <"$matches"
    __failEnvironment "$usage" found debugging || _clean $? "$matches" || return $?
  fi
}

_bashSanitizeCheckDebugging() {
  local file line usage="$1" && shift
  local debugPatterns=() matches="" remain

  while read -r file; do
    while read -r line; do
      debugPatterns+=("$line")
    done <"$file"
  done < <(find "." -type f -name '.debugging' ! -path '*/.*')
  matches=$(__usageEnvironment "$usage" mktemp) || return $?
  if fileMatches 'set ["]\?-x' -- "${debugPatterns[@]+${debugPatterns[@]}}" -- - >"$matches"; then
    dumpPipe fileMatches "${BASH_SOURCE[0]}" <"$matches"
    while IFS=":" read -r file line remain; do
      file="$(consoleCode "$file")" error="$(consoleError "debugging found")" line="$(consoleValue "$line")" remain="$(consoleCode "$remain")" mapEnvironment <<<"{error}: {file}:{line} @ {remain}"
    done <"$matches"
    __failEnvironment "$usage" found debugging || return $?
  fi
}
