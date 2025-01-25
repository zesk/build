#!/usr/bin/env bash
#
# bash functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
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
  [ -n "$startDirectory" ] || startDirectory=$(__catchEnvironment "$usage" pwd) || return $?
  startDirectory=$(usageArgumentDirectory "$usage" "startDirectory" "$startDirectory") || return $?
  home=$(__catchEnvironment "$usage" directoryParent --pattern "$run" --test -f --test -x "$startDirectory") || return $?
  printf "%s\n" "$home"
}
_bashLibraryHome() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run or source a library
# Usage: {fn} libraryRelativePath [ command ... ]
bashLibrary() {
  local usage="_${FUNCNAME[0]}"

  local home run="" verboseFlag=false

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
        verboseFlag=true
        ;;
      *)
        run="$argument"
        shift
        break
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift || __throwArgument "$usage" "missing #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
  done
  [ -n "$run" ] || __throwArgument "$usage" "Missing libraryRelativePath" || return $?
  home=$(bashLibraryHome "$run") || return $?
  if [ $# -eq 0 ]; then
    export HOME
    # shellcheck source=/dev/null
    source "$home/$run" || __throwEnvironment "$usage" "${run//${HOME-}/~} failed" || return $?
    ! $verboseFlag || decorate info "Reloaded $(decorate code "$run") @ $(decorate info "${home//${HOME-}/~}")"
  else
    ! $verboseFlag || decorate info "Running $(decorate file "$home/$run")" "$(decorate each code "$@")"
    __echo "$home/$run" "$@"
  fi
  return 0
}
_bashLibrary() {
  # _IDENTICAL_ usageDocument 1
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

  local home checkAssertions=() executor=contextOpen

  home=$(__catchEnvironment "$usage" buildHome) || return $?

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
        executor=$(usageArgumentCallable "$usage" "$argument" "${1-}") || return $?
        ;;
      --home)
        shift
        home=$(usageArgumentDirectory "$usage" "$argument" "${1-}") || return $?
        ;;
      --check)
        shift || __throwArgument "$usage" "shift $argument" || return $?
        checkAssertions+=("$(usageArgumentDirectory "$usage" "checkDirectory" "$1")") || return $?
        ;;
      *)
        break
        ;;
    esac
    shift || :
  done

  local fileList

  fileList=$(fileTemporaryName "$usage") || return $?
  if [ "$#" -eq 0 ]; then
    __catchEnvironment "$usage" cat >"$fileList" || return $?
  else
    __catchEnvironment "$usage" printf "%s\n" "$@" >"$fileList" || return $?
  fi

  local undo=()

  # CHANGE DIRECTORY HERE
  __catchEnvironment "$usage" muzzle pushd "$home" || return $?
  [ "$home" = "$(pwd)" ] || __throwEnvironment "$usage" "Unable to cd to $home" || return $?
  undo=(muzzle popd)

  statusMessage decorate success Making shell files executable ...

  local shellFile
  while read -r shellFile; do
    statusMessage decorate info "+x $(decorate file "$shellFile")"
  done < <(__catchEnvironment "$usage" makeShellFilesExecutable) || _undo $? "${undo[@]}" || return $?

  statusMessage --last decorate success Checking assertions ...
  _bashSanitizeCheckAssertions "$usage" "${checkAssertions[@]+"${checkAssertions[@]}"}" || _undo $? "${undo[@]}" || return $?

  # Operates on specific files
  statusMessage decorate success Checking syntax ...
  _bashSanitizeCheckLint "$usage" <"$fileList" || _undo $? "${undo[@]}" || _clean $? "$fileList" || return $?

  statusMessage decorate success Checking copyright ...
  _bashSanitizeCheckCopyright "$usage" <"$fileList" || _undo $? "${undo[@]}" || _clean $? "$fileList" || return $?

  statusMessage decorate success Checking debugging ...
  _bashSanitizeCheckDebugging "$usage" <"$fileList" || _undo $? "${undo[@]}" || _clean $? "$fileList" || return $?
  rm -rf "$fileList" || :
  __catchEnvironment "$usage" "${undo[@]}" || return $?
  statusMessage decorate success Completed ...
  printf "\n"
}
_bashSanitize() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_bashSanitizeCheckLint() {
  local usage="$1" && shift

  statusMessage decorate success "Running shellcheck ..." || :
  __catchEnvironment "$usage" bashLintFiles || return $?
}

_bashSanitizeCheckAssertions() {
  local usage="$1" && shift
  local item checkAssertions directory

  checkAssertions=("$@")
  while read -r item; do
    checkAssertions+=("$(__catchEnvironment "$usage" dirname "${item}")") || return $?
  done < <(find "." -type f -name '.check-assertions' ! -path "*/.*/*")

  for directory in "${checkAssertions[@]+"${checkAssertions[@]}"}"; do
    statusMessage --first decorate warning "Checking assertions in $(decorate code "${directory}") ... "
    if ! findUncaughtAssertions "$directory" --list; then
      # When ready - add --interactive here as well
      findUncaughtAssertions "$directory" --exec "$executor" &
      __throwEnvironment "$usage" findUncaughtAssertions "$directory" --list || return $?
    else
      decorate success "all files passed"
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
  __catchEnvironment "$usage" buildEnvironmentLoad BUILD_COMPANY || return $?

  year="$(date +%Y)"
  statusMessage decorate warning "Checking $year and $BUILD_COMPANY ..." || :
  matches=$(fileTemporaryName "$usage") || return $?
  if fileNotMatches "Copyright &copy; $year" "$BUILD_COMPANY" -- "${copyrightExceptions[@]+"${copyrightExceptions[@]}"}" -- - >"$matches"; then
    set +v
    while IFS=":" read -r file pattern; do
      error="$(decorate error "No pattern found")" pattern="$(decorate value "$pattern")" file="$(decorate code "$file")" mapEnvironment <<<"{error}: {pattern} missing from {file}"
    done <"$matches"
    __throwEnvironment "$usage" found debugging || _clean $? "$matches" || return $?
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
  matches=$(fileTemporaryName "$usage") || return $?
  if fileMatches 'set ["]\?-x' -- "${debugPatterns[@]+${debugPatterns[@]}}" -- - >"$matches"; then
    dumpPipe fileMatches "${BASH_SOURCE[0]}" <"$matches"
    while IFS=":" read -r file line remain; do
      file="$(decorate code "$file")" error="$(decorate error "debugging found")" line="$(decorate value "$line")" remain="$(decorate code "$remain")" mapEnvironment <<<"{error}: {file}:{line} @ {remain}"
    done <"$matches"
    __throwEnvironment "$usage" found debugging || return $?
  fi
}

# Usage: {fn} [ directory ... ]
# Argument: directory ... - Required. Directory. Directory to `source` all `.sh` files found.
# Security: Loads bash files
# Load a directory of `.sh` files using `source` to make the code available.
# Has security implications. Use with caution and ensure your directory is protected.
bashSourcePath() {
  local usage="_${FUNCNAME[0]}"

  [ $# -gt 0 ] || __throwArgument "$usage" "Requires a directory" || return $?

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
      *)
        local path
        path=$(usageArgumentDirectory "$usage" "directory" "$argument") || return $?
        # shellcheck disable=SC2015
        while read -r tool; do
          local tool="${tool#./}"
          [ -f "$path/$tool" ] || __throwEnvironment "$usage" "$path/$tool is not a bash source file" || return $?
          [ -x "$path/$tool" ] || __throwEnvironment "$usage" "$path/$tool is not executable" || return $?
          # shellcheck source=/dev/null
          source "$path/$tool" || __throwEnvironment "$usage" "source $path/$tool" || return $?
        done < <(cd "$path" && find "." -type f -name '*.sh' ! -path "*/.*/*" || :)
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift || __throwArgument "$usage" "missing #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
  done
}
_bashSourcePath() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} script
# Checks a bash script to ensure all dependencies are met, outputs a list of unmet dependencies
# Scans a bash script for lines which look like:
#
# Depends: token1 token2
#
# Each dependency token is:
#
# - a bash function which MUST be defined
# - a shell script (executable) which must be present
#
# If all dependencies are met, exit status of 0.
# If any dependencies are not met, exit status of 1 and a list of unmet dependencies are listed
#
# Argument: --require - Flag. Optional. Requires at least one or more dependencies to be listed and met to pass
bashCheckDepends() {
  local usage="_${FUNCNAME[0]}"

  local requireFlag=false

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
      --require)
        requireFlag=true
        ;;
      *)
        files+=("$(usageArgumentFile "$usage" "checkFile" "${1-}")") || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift || __throwArgument "$usage" "missing #$__index/$__count: $argument $(decorate each code "${__saved[@]}")" || return $?
  done

  ! $requireFlag || [ "${#files[@]}" -gt 0 ] || __throwArgument "$usage" "No files supplied but at least one is required" || return $?

  local file

  # dependencies=$(fileTemporaryName "$usage")
  while read -r matchLine; do
    echo "$matchLine"
    #| tee "$dependencies"
  done < <(grep -e '[:space:]*#[:space:]*Depends:[:space:]*' "${files[@]}" | trimSpace)
}
_bashCheckDepends() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
