#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# developer.sh Tools for developers and developer.sh
#

# Announce a list of functions now available
developerAnnounce() {
  local aa=() ff=() item itemType
  while read -r item; do
    [ -n "$item" ] || continue
    [ "$item" = "${item#_}" ] || continue
    itemType=$(type -t "$item")
    case "$itemType" in
      alias) aa+=("$item") ;;
      function) ff+=("$item") ;;
      *) decorate info "Type of $(decorate value "$item") is $(decorate code "$itemType") - not handled" 1>&2 ;;
    esac
  done
  [ "${#ff[@]}" -eq 0 ] || decorate info "Available functions $(decorate each code "${ff[@]}")"
  [ "${#aa[@]}" -eq 0 ] || decorate info "Available aliases $(decorate each code "${aa[@]}")"
}

# Undo a set of developer functions or aliases
# stdin: List of functions and aliases to remove from the current environment
developerUndo() {
  local item
  while read -r item; do
    [ -n "$item" ] || continue
    local itemType
    itemType=$(type -t "$item")
    case "$itemType" in
      alias) unalias "$item" ;;
      function) unset "${item}" ;;
      *) decorate info "Type of $(decorate value "$item") is $(decorate code "$itemType") - not handled" 1>&2 ;;
    esac
  done
}

# Track changes to the bash environment
# Argument: source - File. Required. Source which we are tracking for changes to bash environment
# Argument: --verbose - Flag. Optional. Be verbose about what the function is doing.
# Argument: --list - Flag. Optional. Show the list of what has changed since the first invocation.
# stdout: list of function|alias|environment
developerTrack() {
  local usage="_${FUNCNAME[0]}"
  local source="" listChanges=false verboseFlag=false

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
      --list)
        listChanges=true
        ;;
      --verbose)
        verboseFlag=true
        ;;
      *)
        source=$(usageArgumentRealFile "$usage" "source" "${1-}") || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  [ -n "$source" ] || __throwArgument "$usage" "source required" || return $?

  local cachePath

  hash=$(shaPipe <<<"$source")
  cachePath=$(__catchEnvironment "$usage" buildCacheDirectory "${FUNCNAME[0]}" "$hash") || return $?
  ! $verboseFlag || statusMessage decorate info "Cache path is $(decorate file "$cachePath")"

  if $listChanges; then
    local tempPath itemType
    if [ ! -f "$cachePath/function" ]; then
      __throwEnvironment "$usage" "Finish called but never started" || return $?
    fi
    # shellcheck source=/dev/null
    source "$cachePath/alias.source" || __throwEnvironment "$usage" "Aliases reload failed" || return $?
    tempPath=$(fileTemporaryName "$usage" -d) || return $?
    ! $verboseFlag || statusMessage decorate info "Finishing tracking ... comparing with $tempPath"
    __developerTrack "$usage" "$tempPath" || return $?
    printf -- "%s" "" >"$cachePath/CHANGES"
    for itemType in "alias" "function" "environment"; do
      ! $verboseFlag || statusMessage decorate info "Running $itemType"
      diff "$tempPath/$itemType" "$cachePath/$itemType" | grep '^[<>]' | cut -c 3- >>"$cachePath/CHANGES"
    done
    cat "$cachePath/CHANGES"
  else
    ! $verboseFlag || statusMessage decorate info "Starting developer tracking"
    __catchEnvironment "$usage" printf -- "%s\n" "$source" >"$cachePath/source" || return $?
    __developerTrack "$usage" "$cachePath" || return $?
    ! $verboseFlag || statusMessage --last decorate info "Developer tracking on"
  fi
}
__developerTrack() {
  local usage="$1" path="$2"
  alias -p | tee "$path/alias.source" | removeFields 1 | cut -d = -f 1 | sort -u >"$path/alias" || return $?
  declare -F | cut -d ' ' -f 3 | sort -u >"$path/function" || return $?
  environmentVariables | sort -u >"$path/environment" || return $?
}
_developerTrack() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Add a development link to the local version of Zesk Build for testing in local projects
# Argument: --reset - Flag. Optional. Revert the link and reinstall using the original binary.
buildDevelopmentLink() {
  local usage="_${FUNCNAME[0]}"

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
      --reset)
        ;;
      *)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  developerDevelopmentLink --binary "install-bin-build.sh" --path "bin/build" --version-json "bin/build/build.json" --variable "BUILD_DEVELOPMENT_HOME" "$@"
}
_buildDevelopmentLink() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Link a current library with another version being developed nearby using a link
# Does not work inside docker containers unless you explicitly do some magic with paths (maybe we will add this)
# Argument: --binary - String. Required. The binary to install the library remotely if needed to revert back.
# Argument: --path - ApplicationDirectory. Required. The library path to convert to a link.
# Argument: --version-json - ApplicationFile. Required. The library JSON file to check.
# Argument: --variable - EnvironmentVariable. Required. The environment variable which represents the local path of the library to link to.
# Argument: --reset - Flag. Optional. Revert the link and reinstall using the original binary.
developerDevelopmentLink() {
  local usage="_${FUNCNAME[0]}"

  local resetFlag=false binary="" path="" versionJSON="" variable=""

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
      --binary)
        shift
        binary=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        ;;
      --path)
        shift
        path=$(usageArgumentRemoteDirectory "$usage" "$argument" "${1-}") || return $?
        ;;
      --version-json)
        shift
        versionJSON=$(usageArgumentRemoteDirectory "$usage" "$argument" "${1-}") || return $?
        ;;
      --variable)
        shift
        variable=$(usageArgumentEnvironmentVariable "$usage" "$argument" "${1-}") || return $?
        ;;
      --reset)
        resetFlag=true
        ;;
      *)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "$binary" ] || __throwArgument "$usage" "--binary is required" || return $?
  [ -n "$path" ] || __throwArgument "$usage" "--path is required" || return $?
  [ -n "$versionJSON" ] || __throwArgument "$usage" "--version-json is required" || return $?
  [ -n "$variable" ] || __throwArgument "$usage" "--variable is required" || return $?
  local home target

  local developmentHome=""

  [ -n "$binary" ] || __throwArgument "$usage" "--binary is required" || return $?
  path="${path%/}"
  [ -n "$versionJSON" ] || __throwArgument "$usage" "--version-json is required" || return $?

  home=$(__catchEnvironment "$usage" buildHome) || return $?
  target="$home/$path"

  showName=$(buildEnvironmentGet APPLICATION_NAME) || return $?
  showName=$(decorate value "$showName")
  developmentHome=$(__catchEnvironment "$usage" buildEnvironmentGet "$variable") || return $?
  if [ -n "$developmentHome" ]; then
    developmentHome=$(__catchEnvironment "$usage" realPath "${developmentHome%/}") || return $?
  fi
  [ -d "$developmentHome/$path" ] || __throwEnvironment "$usage" "$variable is not a directory: $(decorate error "$developmentHome/$path")" || return $?
  home=$(__catchEnvironment "$usage" realPath "${home%/}") || return $?

  [ "$home" != "$developmentHome" ] || __throwEnvironment "$usage" "This $(decorate warning "is") the development directory: $showName" || return $?

  if $resetFlag; then
    local versionText
    versionText="$(jq -r .version <"$home/$versionJSON")"
    if [ -L "$target" ]; then
      __developerDevelopmentLink "$home" "$path" "$binary" "$developmentHome"
    else
      statusMessage --last printf -- "%s using %s\n" "$showName" "$(decorate file "$target")" "$versionText"
    fi
  else
    local arrowIcon="➡️" aok="✅"
    if [ -L "$target" ]; then
      printf -- "%s %s %s %s\n" "$aok" "$(decorate file "$target")" "$arrowIcon" "$(decorate file "$(realPath "$target")")"
    elif [ -f "$home/$versionJSON" ]; then
      if confirmYesNo --timeout 30 --default false "$(decorate warning "Removing $(decorate file "$target") in project $showName"?)"; then
        __catchEnvironment "$usage" rm -rf "$target" || return $?
        __catchEnvironment "$usage" ln -s "$developmentHome/$path" "$target" || return $?
      else
        statusMessage --last decorate error "Nothing removed."
      fi
    else
      __throwEnvironment "$usage" "$versionJSON does not exist, will not update." || return $?
    fi
  fi
}
_developerDevelopmentLink() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__developerDevelopmentRevert() {
  local home="$1" relPath="$2" binary="$3" developmentHome="$4"

  local target="$home/$relPath/"

  __catchEnvironment "$usage" rm -rf "$target" || return $?
  local installer
  if installer=$(find "$home" -name "$binary" | head -n 1); then
    if [ ! -x "$installer" ]; then
      decorate warning "$(decorate file "$installer") is not executable, replacing" || return $?
      installer=""
    fi
  fi
  if [ -z "$installr" ]; then
    __catchEnvironment "$usage" requireDirectory "$target" || return $?
    installer="$developmentHome/$relPath/$binary"]
    [ -x "$installer" ] || __throwEnvironment "$usage" "$installer does not exist" || return $?
    __catchEnvironment "$usage" cp "$installer" "$target/$binary" || return $?
    installer="$target/$binary"
  fi
  __catchEnvironment "$usage" "$installer" || return $?
}
