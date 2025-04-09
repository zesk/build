#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# developer.sh Tools for developers and developer.sh
#

# Announce a list of functions now available
developerAnnounce() {
  local aa=() ff=() types=() item itemType
  while read -r item; do
    [ -n "$item" ] || continue
    [ "$item" = "${item#_}" ] || continue
    itemType=$(type -t "$item")
    case "$itemType" in
      alias) aa+=("$item") ;;
      function) ff+=("$item") ;;
      *)
        local message
        message="$(decorate info "$(decorate value "$item") is of type $(isType "$item" | decorate each code)")"
        types+=("$message")
        ;;
    esac
  done
  [ "${#ff[@]}" -eq 0 ] || decorate info "Available functions $(decorate each code "${ff[@]}")"
  [ "${#aa[@]}" -eq 0 ] || decorate info "Available aliases $(decorate each code "${aa[@]}")"
  [ "${#types[@]}" -eq 0 ] || decorate info "Available types:$(printf "%s\n" "" "${types[@]}")"
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
  local source="" listChanges=false verboseFlag=false exportMarker

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
  exportMarker="__DEVELOPER_TRACK_MARKER_$hash"

  if $listChanges; then
    local tempPath itemType

    if [ ! -f "$cachePath/function" ]; then
      __throwEnvironment "$usage" "Finish called but never started" || return $?
    fi
    if ! muzzle isType "${exportMarker?}"; then
      if [ -f "$cachePath/CHANGES" ]; then
        cat "$cachePath/CHANGES"
        return 0
      fi
      __throwEnvironment "$usage" "CHANGES missing" || return $?
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
    __catchEnvironment "$usage" rm -rf "$tempPath" || return $?
    unset "${exportMarker?}"
    cat "$cachePath/CHANGES"
  else
    if muzzle isType "$exportMarker"; then
      printf "%s\n" "$(timingStart)" >>"$cachePath/reloaded"
      ! $verboseFlag || statusMessage --last decorate info "Developer tracking reloaded AND no-op"
    else
      export "${exportMarker?}"="$source"
      ! $verboseFlag || statusMessage decorate info "Starting developer tracking"
      __catchEnvironment "$usage" printf -- "%s\n" "$source" >"$cachePath/source" || return $?
      __developerTrack "$usage" "$cachePath" || return $?
      ! $verboseFlag || statusMessage --last decorate info "Developer tracking on"
    fi
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
      --reset | --copy) ;;

      *)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  developerDevelopmentLink --handler "$usage" --binary "install-bin-build.sh" --path "bin/build" --development-path "bin/build" --version-json "bin/build/build.json" --variable "BUILD_DEVELOPMENT_HOME" "${__saved[@]+"${__saved[@]}"}"
}
_buildDevelopmentLink() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Link a current library with another version being developed nearby using a link
# Does not work inside docker containers unless you explicitly do some magic with paths (maybe we will add this)
# Argument: --binary - String. Optional. The binary to install the library remotely if needed to revert back.
# Argument: --composer composerPackage - String. Optional. The composer package to convert to a link (or copy.)
# Argument: --path applicationPath - ApplicationDirectory. Required. The library path to convert to a link (or copy).
# Argument: --development-path developmentPath- Directory. Optional. Path in the target development directory to link (or copy) to the path.
# Argument: --version-json jsonFile - ApplicationFile. Required. The library JSON file to check.
# Argument: --version-selector jsonFile - String. Optional. Query to extract version from JSON file (defaults to `.version`)
# Argument: --variable variableNameValue - EnvironmentVariable. Required. The environment variable which represents the local path of the library to link to.
# Argument: --copy - Flag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization.
# Argument: --reset - Flag. Optional. Revert the link and reinstall using the original binary.
# Test: TODO
developerDevelopmentLink() {
  local usage="_${FUNCNAME[0]}"

  local resetFlag=false path="" versionJSON="" variable="" copyFlag=false composerPackage="" developmentPath="" versionSelector="" runBinary=()

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
      # _IDENTICAL_ --handler 4
      --handler)
        shift
        usage=$(usageArgumentFunction "$usage" "$argument" "${1-}") || return $?
        ;;
      --copy)
        copyFlag=true
        ;;
      --composer)
        shift
        composerPackage=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        ;;
      --binary)
        shift
        runBinary+=("$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
        ;;
      --development-path)
        shift
        developmentPath=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        ;;
      --path)
        shift
        path=$(usageArgumentApplicationDirectory "$usage" "$argument" "${1-}") || __throwArgument "$usage" "path failed #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
        ;;
      --version-json)
        shift
        versionJSON=$(usageArgumentApplicationFile "$usage" "$argument" "${1-}") || return $?
        ;;
      --version-selector)
        shift
        versionSelector=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
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

  [ -n "$versionSelector" ] || versionSelector=".version"

  local home target
  home=$(__catchEnvironment "$usage" buildHome) || return $?
  home=$(__catchEnvironment "$usage" realPath "${home%/}") || return $?

  if [ -z "$composerPackage" ]; then
    [ "${#runBinary[@]}" -gt 0 ] || __throwArgument "$usage" "--binary or --composer is required" || return $?
    [ -n "$path" ] || __throwArgument "$usage" "--path is required" || return $?
    [ -n "$versionJSON" ] || __throwArgument "$usage" "--version-json is required" || return $?
  else
    runBinary=(composer require "$composerPackage")
    path="vendor/$composerPackage"
    versionJSON="$path/composer.json"
    developmentPath=""
  fi
  [ -n "$variable" ] || __throwArgument "$usage" "--variable is required" || return $?

  local developmentHome=""

  path="${path%/}"
  target="$home/$path"
  developmentPath="${developmentPath#/}"
  developmentPath="${developmentPath%/}"

  showName=$(buildEnvironmentGet APPLICATION_NAME) || return $?
  showName=$(decorate label "$showName")

  # developmentHome
  developmentHome=$(__catchEnvironment "$usage" buildEnvironmentGet "$variable") || return $?
  if [ -n "$developmentHome" ]; then
    developmentHome=$(__catchEnvironment "$usage" realPath "${developmentHome%/}") || return $?
  fi

  local source="$developmentHome/$developmentPath"
  source="${source%/}"

  [ -d "$source" ] || __throwEnvironment "$usage" "$variable is not a directory: $(decorate error "$source")" || return $?

  [ "$home" != "$developmentHome" ] || __throwEnvironment "$usage" "This $(decorate warning "is") the development directory: $showName" || return $?

  if $resetFlag; then
    local versionText
    [ -f "$home/$versionJSON" ] || __throwEnvironment "$usage" "$(decorate file "$home/$versionJSON") does not exist" || return $?
    versionText="$(jq -r "$versionSelector" <"$home/$versionJSON")"
    if [ -L "$target" ]; then
      __developerDevelopmentRevert "$usage" "$home" "$path" "$developmentHome" "${runBinary[@]}"
    else
      statusMessage --last printf -- "%s using %s\n" "$showName" "$(decorate file "$target")" "$versionText"
    fi
  else
    local arrowIcon="➡️" aok="✅"

    [ -z "$developmentPath" ] || [ -d "$source" ] || __throwEnvironment "$usage" "$source is not a directory" || return $?

    if $copyFlag; then
      local verb
      if [ -L "$target" ]; then
        __catchEnvironment "$usage" rm "$target" || return $?
        __catchEnvironment "$usage" mkdir -p "$target" || return $?
      fi
      if whichExists rsync; then
        verb="Synchronized"
        __catchEnvironment "$usage" rsync -a "$source/" "$target/" || return $?
      else
        verb="Copied"
        __catchEnvironment "$usage" cp -R "$source/" "$target" || return $?
      fi
      printf -- "%s %s %s %s %s (%s)\n" "$aok" "$(decorate info "$verb")" "$(decorate file "$developmentHome")" "$arrowIcon" "$showName" "$(decorate file "$(realPath "$target")")"
    elif [ -L "$target" ]; then
      printf -- "%s %s %s %s\n" "$aok" "$(decorate file "$target")" "$arrowIcon" "$(decorate file "$(realPath "$target")")"
    elif [ -f "$home/$versionJSON" ]; then
      if confirmYesNo --timeout 30 --default false "$(decorate warning "Removing $(decorate file "$target") in project $showName"?)"; then
        __catchEnvironment "$usage" rm -rf "$target" || return $?
        __catchEnvironment "$usage" ln -s "$source" "$target" || return $?
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

# Installer can fall back
__developerDevelopmentRevert() {
  local usage="$1" home="$2" relPath="$3" developmentHome="$4" && shift 4

  [ $# -gt 0 ] || __throwArgument "$usage" "Missing installer" || return $?

  local target="$home/$relPath/"
  __catchEnvironment "$usage" rm -rf "$target" || return $?

  if [ $# -eq 1 ] && ! isExecutable "$1"; then
    local binary="$1" installer
    installer="$developmentHome/$relPath/$binary"]
    [ -x "$installer" ] || __throwEnvironment "$usage" "$installer does not exist" || return $?
    __catchEnvironment "$usage" requireDirectory "$target" || return $?
    __catchEnvironment "$usage" cp "$installer" "$target/$binary" || return $?
    set -- "$target/$binary"
  fi

  __catchEnvironment "$usage" "$@" || return $?
  [ -d "$target" ] || __throwEnvironment "$usage" "Installer $(decorate code "$*") did not install $(decorate file "$target")"
}
