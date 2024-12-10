#!/usr/bin/env bash
#
# bash functions
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: ./docs/_templates/tools/bash.md
# Test: ./test/tools/bash-tests.sh

# Output the home for a library in the parent path
# Usage: {fn} libraryRelativePath [ startDirectory ]
# Argument: libraryRelativePath - String. Required. Path of file to find from the home directory.
# Argument: startDirectory - Directory. Optional. Place to start searching. Uses `pwd` if not specified.
# stdout: Parent path where `libraryRelativePath` exists
bashLibraryHome() {
  local usage="_${FUNCNAME[0]}"
  local home run startDirectory="${2-}"
  run=$(usageArgumentString "$usage" "libraryRelativePath" "${1-}") || return $?
  [ -n "$startDirectory" ] || startDirectory=$(__usageEnvironment "$usage" pwd) || return $?
  startDirectory=$(usageArgumentDirectory "$usage" "startDirectory" "$startDirectory") || return $?
  home=$(__usageEnvironment "$usage" directoryParent --pattern "$run" --test -f --test -x "$startDirectory") || return $?
  printf "%s\n" "$home"
}
_bashLibraryHome() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run or source a library
# Usage: {fn} libraryRelativePath [ command ... ]
bashLibrary() {
  local usage="_${FUNCNAME[0]}"

  local home run="" verboseFlag=false

  local saved=("$@") nArguments=$#
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --verbose)
        verboseFlag=true
        ;;
      *)
        run="$argument"
        shift
        break
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done
  [ -n "$run" ] || __failArgument "$usage" "Missing libraryRelativePath" || return $?
  home=$(bashLibraryHome "$run") || return $?
  if [ $# -eq 0 ]; then
    export HOME
    # shellcheck source=/dev/null
    source "$home/$run" || __failEnvironment "$usage" "${run//${HOME-}/~} failed" || return $?
    ! $verboseFlag || decorate info "Reloaded $(decorate code "$run") @ $(decorate info "${home//${HOME-}/~}")"
  else
    ! $verboseFlag || decorate info "Running $(decorate file "$home/$run")" "$(decorate code "$@")"
    __echo "$home/$run" "$@"
  fi
  return 0
}
_bashLibrary() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

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
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
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

  statusMessage decorate success Making shell files executable ...
  __usageEnvironment "$usage" makeShellFilesExecutable || _undo $? "${undo[@]}" || return $?

  statusMessage decorate success Checking assertions ...
  _bashSanitizeCheckAssertions "$usage" "${checkAssertions[@]+"${checkAssertions[@]}"}" || _undo $? "${undo[@]}" || return $?

  # Operates on specific files
  statusMessage decorate success Checking syntax ...
  _bashSanitizeCheckLint "$usage" <"$fileList" || _undo $? "${undo[@]}" || _clean $? "$fileList" || return $?

  statusMessage decorate success Checking copyright ...
  _bashSanitizeCheckCopyright "$usage" <"$fileList" || _undo $? "${undo[@]}" || _clean $? "$fileList" || return $?

  statusMessage decorate success Checking debugging ...
  _bashSanitizeCheckDebugging "$usage" <"$fileList" || _undo $? "${undo[@]}" || _clean $? "$fileList" || return $?
  rm -rf "$fileList" || :
  __usageEnvironment "$usage" "${undo[@]}" || return $?
  statusMessage decorate success Completed ...
  printf "\n"
}
_bashSanitize() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_bashSanitizeCheckLint() {
  local usage="$1" && shift

  statusMessage decorate success "Running shellcheck ..." || :
  __usageEnvironment "$usage" bashLintFiles || return $?
}

_bashSanitizeCheckAssertions() {
  local usage="$1" && shift
  local item checkAssertions directory

  checkAssertions=("$@")
  while read -r item; do
    checkAssertions+=("$(__usageEnvironment "$usage" dirname "${item}")") || return $?
  done < <(find "." -type f -name '.check-assertions' ! -path "*/.*/*")

  for directory in "${checkAssertions[@]+"${checkAssertions[@]}"}"; do
    statusMessage printf "%s" "$(decorate warning "Checking assertions in $(decorate code "${directory}") - ...")"
    echo -n findUncaughtAssertions
    if ! findUncaughtAssertions "$directory" --list; then
      # When ready - add --interactive here as well
      findUncaughtAssertions "$directory" --exec "$executor" &
      __failEnvironment "$usage" findUncaughtAssertions "$directory" --list || return $?
    else
      printf "%s\n" "... All files AOK"
    fi
  done
}

_bashSanitizeCheckCopyright() {
  local file line usage="$1" && shift
  local matches year copyrightExceptions=()

  while read -r file; do
    while read -r line; do
      copyrightExceptions+=("$line")
    done <"$file"
  done < <(find . -name ".skip-copyright" -type f ! -path "*/.*/*")
  export BUILD_COMPANY
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_COMPANY || return $?

  year="$(date +%Y)"
  statusMessage decorate warning "Checking $year and $BUILD_COMPANY ..." || :
  matches=$(__usageEnvironment "$usage" mktemp) || return $?
  if fileNotMatches "Copyright &copy; $year" "$BUILD_COMPANY" -- "${copyrightExceptions[@]+"${copyrightExceptions[@]}"}" -- - >"$matches"; then
    set +v
    while IFS=":" read -r file pattern; do
      error="$(decorate error "No pattern found")" pattern="$(decorate value "$pattern")" file="$(decorate code "$file")" mapEnvironment <<<"{error}: {pattern} missing from {file}"
    done <"$matches"
    __failEnvironment "$usage" found debugging || _clean $? "$matches" || return $?
  fi
  set +v
}

_bashSanitizeCheckDebugging() {
  local file line usage="$1" && shift
  local debugPatterns=() matches="" remain

  while read -r file; do
    while read -r line; do
      debugPatterns+=("$line")
    done <"$file"
  done < <(find "." -type f -name '.debugging' ! -path "*/.*/*")
  matches=$(__usageEnvironment "$usage" mktemp) || return $?
  if fileMatches 'set ["]\?-x' -- "${debugPatterns[@]+${debugPatterns[@]}}" -- - >"$matches"; then
    dumpPipe fileMatches "${BASH_SOURCE[0]}" <"$matches"
    while IFS=":" read -r file line remain; do
      file="$(decorate code "$file")" error="$(decorate error "debugging found")" line="$(decorate value "$line")" remain="$(decorate code "$remain")" mapEnvironment <<<"{error}: {file}:{line} @ {remain}"
    done <"$matches"
    __failEnvironment "$usage" found debugging || return $?
  fi
}

# Usage: {fn} [ directory ... ]
# Argument: directory ... - Required. Directory. Directory to `source` all `.sh` files found.
# Security: Loads bash files
# Load a directory of `.sh` files using `source` to make the code available.
# Has security implications. Use with caution and ensure your directory is protected.
bashSourcePath() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved
  local path tool

  [ $# -gt 0 ] || __failArgument "$usage" "Requires a directory" || return $?

  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        path=$(usageArgumentDirectory "$usage" "directory" "$argument") || return $?
        # shellcheck disable=SC2015
        while read -r tool; do
          tool="${tool#./}"
          [ -f "$path/$tool" ] || __failEnvironment "$usage" "$path/$tool is not a bash source file" || return $?
          [ -x "$path/$tool" ] || __failEnvironment "$usage" "$path/$tool is not executable" || return $?
          # shellcheck source=/dev/null
          source "$path/$tool" || __failEnvironment "$usage" "source $path/$tool" || return $?
        done < <(cd "$path" && find "." -type f -name '*.sh' ! -path "*/.*/*" || :)
        ;;
    esac
    shift
  done
}
_bashSourcePath() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
