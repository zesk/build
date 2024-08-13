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
# Placing a `.debugging` file in your project with a list of permitted files which contain debugging (`set -x`)
# Configuration File: .debugging (list of file paths which are ok to allow debugging)
# Configuration File: .check-assertions (location determines check root)
# See: buildHome
bashSanitize() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved files
  local executor ii home directory checkAssertions item debugPatterns debugPatternFile undo=()

  set -eou pipefail

  export BUILD_COMPANY
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_COMPANY || return $?

  home=$(__usageEnvironment "$usage" buildHome) || return $?
  checkAssertions=()
  saved=("$@")
  nArguments=$#
  executor=contextOpen
  ii=()
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --interactive)
        ii=("$argument")
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

  if [ "$#" -eq 0 ]; then
    files=()
    while read -r file; do files+=("$file"); done
  else
    files=("$@")
  fi
  while read -r item; do
    checkAssertions+=("$(__usageEnvironment "$usage" dirname "${item}")") || return $?
  done < <(find "$home" -type f -name '.check-assertions' ! -path '*/.*')

  # CHANGE DIRECTORY HERE
  __usageEnvironment "$usage" muzzle pushd "$home" || return $?
  undo=(muzzle popd)

  statusMessage consoleSuccess Making shell files executable ...
  __usageEnvironment "$usage" makeShellFilesExecutable || _undo $? "${undo[@]}" || return $?

  statusMessage consoleSuccess "Running shellcheck ..." || :
  __usageEnvironment "$usage" validateShellScripts "${ii[@]+"${ii[@]}"}" --exec "$executor" "${files[@]}" || _undo $? "${undo[@]}" || return $?

  year="$(date +%Y)"
  statusMessage consoleWarning "Checking $year and $BUILD_COMPANY ..." || :
  # When ready - add --interactive here as well
  __usageEnvironment "$usage" validateFileContents --exec "$executor" "${files[@]}" -- "Copyright &copy; $year" "$BUILD_COMPANY" || return $?

  for directory in "${checkAssertions[@]+${checkAssertions[@]}}"; do
    statusMessage consoleWarning "Checking assertions in $(consoleCode "${directory}") - " || :
    if ! findUncaughtAssertions "$directory" --list; then
      # When ready - add --interactive here as well
      findUncaughtAssertions "$directory" --exec "$executor" &
      __failEnvironment "$usage" findUncaughtAssertions || _undo $? "${undo[@]}" || return $?
    fi
  done
  set -x
  debugPatterns=()
  while read -r debugPatternFile; do
    while read -r debugPattern; do
      debugPatterns+=("$debugPattern")
    done <"$debugPatternFile"
  done < <(find "$home" -type f -name '.debugging')
  matches=$(__usageEnvironment "$usage" mktemp) || return $?
  if fileMatches 'set ["]\?-x' -- "${debugPatterns[@]}" -- "${files[@]}" >"$matches"; then
    while IFS=":" read -r file line remain; do
      error="$(consoleError "debugging found")" line="$(consoleValue "$line")" remain="$(consoleCode "$remain")" mapEnvironment <<<"{error}: {file}:{line} > {remain}"
    done <"$matches"
    __failEnvironment "$usage" found debugging || _clean $? "$matches" || _undo $? "${undo[@]}" || return $?
  fi

  _undo 0 "${undo[@]}" || return $?
}
_bashSanitize() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
