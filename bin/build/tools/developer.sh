#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# developer.sh Tools for developers and developer.sh
#

# Announce a list of functions now available
developerAnnounce() {
  local handler="_${FUNCNAME[0]}"
  local skipItems=()
  local debugFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --debug)
      debugFlag=true
      ;;
    *)
      source=$(usageArgumentRealFile "$handler" "source" "${1-}") || return $?
      ;;
    esac
    shift
  done

  IFS=$'\n' read -r -d "" -a skipItems < <(environmentSecureVariables)
  local aa=() ff=() types=() unknowns=() item itemType blank

  blank=$(decorate bold-orange "empty")
  while read -r item; do
    [ -n "$item" ] || continue
    [ "$item" = "${item#_}" ] || continue
    itemType=$(type -t "$item")
    case "$itemType" in
    alias) aa+=("$item") ;;
    function) ff+=("$item") ;;
    *)
      ! inArray "$item" "${skipItems[@]}" || continue
      if muzzle isType "$item"; then
        local message
        message="$(decorate info "$(decorate value "$item") is $(decorate bold-magenta "${!item-$blank}") ($(isType "$item" | decorate each code))")"
        types+=("$message")
      else
        unknowns+=("$item")
      fi
      ;;
    esac
  done
  [ "${#ff[@]}" -eq 0 ] || decorate info "Available functions $(decorate each code "${ff[@]}")"
  [ "${#aa[@]}" -eq 0 ] || decorate info "Available aliases $(decorate each code "${aa[@]}")"
  [ "${#types[@]}" -eq 0 ] || decorate info "Available variables:"$'\n'"$(printf -- "- %s\n" "${types[@]}")"
  ! $debugFlag || [ "${#unknowns[@]}" -eq 0 ] || decorate info "Unknowns: $(decorate error "${#unknowns[@]}")"
}
_developerAnnounce() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Undo a set of developer functions or aliases
# stdin: List of functions and aliases to remove from the current environment
developerUndo() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  local item
  while read -r item; do
    [ -n "$item" ] || continue
    local itemType
    itemType=$(type -t "$item")
    case "$itemType" in
    alias) unalias "$item" ;;
    function) unset "${item}" ;;
    *)
      if muzzle isType "$item"; then
        unset "$item"
      fi
      ;;
    esac
  done
}
_developerUndo() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Track changes to the bash environment
# Argument: source - File. Required. Source which we are tracking for changes to bash environment
# Argument: --verbose - Flag. Optional. Be verbose about what the function is doing.
# Argument: --list - Flag. Optional. Show the list of what has changed since the first invocation.
# stdout: list of function|alias|environment
developerTrack() {
  local handler="_${FUNCNAME[0]}"
  local source="" verboseFlag=false profileFlag=false optionalFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --profile) profileFlag=true ;;
    --developer) profileFlag=true && optionalFlag=true ;;
    --verbose)
      verboseFlag=true
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local cachePath

  cachePath=$(__catch "$handler" buildCacheDirectory "${FUNCNAME[0]}" "profile") || return $?
  if $profileFlag; then
    ! $optionalFlag || [ ! -f "$cachePath/environment" ] || return 0
    __developerTrack "$cachePath" || return $?
    return 0
  fi

  if [ ! -f "$cachePath/functions" ]; then
    __throwEnvironment "$handler" "developerTrack --profile never called" || return $?
  fi
  local tempPath itemType

  # shellcheck source=/dev/null
  source "$cachePath/alias.source" || __throwEnvironment "$handler" "Aliases reload failed" || return $?

  tempPath=$(fileTemporaryName "$handler" -d) || return $?
  __developerTrack "$tempPath" || return $?

  ! $verboseFlag || statusMessage decorate info "Finishing tracking ... comparing $cachePath with $tempPath"
  for itemType in "alias" "environment" "functions"; do comm -13 "$cachePath/$itemType" "$tempPath/$itemType"; done | sort -u
  __catchEnvironment "$handler" rm -rf "$tempPath" || return $?
}
__developerTrack() {
  local path="$1"
  __developerTrackEnvironment >"$path/environment"
  __developerTrackAliases "$path"
  __developerTrackFunctions >"$path/functions"
}
__developerTrackFunctions() {
  declare -F | awk '{ print $3 }' | sort -u
}
__developerTrackEnvironment() {
  environmentVariables | sort -u
}
__developerTrackAliases() {
  local path="$1"
  alias -p | sort -u | tee "$path/alias.source" | removeFields 1 | cut -d = -f 1 >"$path/alias" || return $?
}
_developerTrack() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Add a development link to the local version of Zesk Build for testing in local projects
# DOC TEMPLATE: developerDevelopmentLink 2
# Argument: --copy - Flag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization.
# Argument: --reset - Flag. Optional. Revert the link and reinstall using the original binary.
buildDevelopmentLink() {
  local handler="_${FUNCNAME[0]}"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --reset | --copy) ;;

    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done
  developerDevelopmentLink --handler "$handler" --binary "install-bin-build.sh" --path "bin/build" --development-path "bin/build" --version-json "bin/build/build.json" --variable "BUILD_DEVELOPMENT_HOME" "${__saved[@]+"${__saved[@]}"}"
}
_buildDevelopmentLink() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Link a current library with another version being developed nearby using a link
# Does not work inside docker containers unless you explicitly do some magic with paths (maybe we will add this)
# DOC TEMPLATE: developerDevelopmentLink 2
# Argument: --copy - Flag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization.
# Argument: --reset - Flag. Optional. Revert the link and reinstall using the original binary.
# Argument: --development-path developmentPath- Directory. Optional. Path in the target development directory to link (or copy) to the path.
# Argument: --version-json jsonFile - ApplicationFile. Required. The library JSON file to check.
# Argument: --version-selector jsonFile - String. Optional. Query to extract version from JSON file (defaults to `.version`). API.
# Argument: --variable variableNameValue - EnvironmentVariable. Required. The environment variable which represents the local path of the library to link to. API.
# Argument: --binary - String. Optional. The binary to install the library remotely if needed to revert back. API.
# Argument: --composer composerPackage - String. Optional. The composer package to convert to a link (or copy.). API.
# Argument: --path applicationPath - ApplicationDirectory. Required. The library path to convert to a link (or copy). API.
# Test: TODO
developerDevelopmentLink() {
  local handler="_${FUNCNAME[0]}"

  local resetFlag=false path="" versionJSON="" variable="" copyFlag=false composerPackage="" developmentPath="" versionSelector="" runBinary=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --copy)
      copyFlag=true
      ;;
    --composer)
      shift
      composerPackage=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --binary)
      shift
      runBinary+=("$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    --development-path)
      shift
      developmentPath=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --path)
      shift
      path=$(usageArgumentApplicationDirectory "$handler" "$argument" "${1-}") || __throwArgument "$handler" "path failed #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
      ;;
    --version-json)
      shift
      versionJSON=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --version-selector)
      shift
      versionSelector=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --variable)
      shift
      variable=$(usageArgumentEnvironmentVariable "$handler" "$argument" "${1-}") || return $?
      ;;
    --reset)
      resetFlag=true
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  [ -n "$versionSelector" ] || versionSelector=".version"

  local home target
  home=$(__catch "$handler" buildHome) || return $?
  home=$(__catchEnvironment "$handler" realPath "${home%/}") || return $?

  if [ -z "$composerPackage" ]; then
    [ "${#runBinary[@]}" -gt 0 ] || __throwArgument "$handler" "--binary or --composer is required" || return $?
    [ -n "$path" ] || __throwArgument "$handler" "--path is required" || return $?
    [ -n "$versionJSON" ] || __throwArgument "$handler" "--version-json is required" || return $?
  else
    runBinary=(composer require "$composerPackage")
    path="vendor/$composerPackage"
    versionJSON="$path/composer.json"
    developmentPath=""
  fi
  [ -n "$variable" ] || __throwArgument "$handler" "--variable is required" || return $?

  local developmentHome=""

  path="${path%/}"
  target="$home/$path"
  developmentPath="${developmentPath#/}"
  developmentPath="${developmentPath%/}"

  showName=$(buildEnvironmentGet APPLICATION_NAME) || return $?
  showName=$(decorate label "$showName")

  # developmentHome
  developmentHome=$(__catch "$handler" buildEnvironmentGet "$variable") || return $?
  if [ -n "$developmentHome" ]; then
    developmentHome=$(__catchEnvironment "$handler" realPath "${developmentHome%/}") || return $?
  fi

  local source="$developmentHome/$developmentPath"
  source="${source%/}"

  [ -d "$source" ] || __throwEnvironment "$handler" "$variable is not a directory: $(decorate error "$source")" || return $?

  [ "$home" != "$developmentHome" ] || __throwEnvironment "$handler" "This $(decorate warning "is") the development directory: $showName" || return $?

  if $resetFlag; then
    local versionText
    [ -f "$home/$versionJSON" ] || __throwEnvironment "$handler" "$(decorate file "$home/$versionJSON") does not exist" || return $?
    versionText="$(jq -r "$versionSelector" <"$home/$versionJSON")"
    if [ -L "$target" ]; then
      __developerDevelopmentRevert "$handler" "$home" "$path" "$developmentHome" "${runBinary[@]}"
    else
      statusMessage --last printf -- "%s using %s\n" "$showName" "$(decorate file "$target")" "$versionText"
    fi
  else
    local arrowIcon="➡️" aok="✅"

    [ -z "$developmentPath" ] || [ -d "$source" ] || __throwEnvironment "$handler" "$source is not a directory" || return $?

    if $copyFlag; then
      local verb
      if [ -L "$target" ]; then
        __catchEnvironment "$handler" rm "$target" || return $?
        __catchEnvironment "$handler" mkdir -p "$target" || return $?
      fi
      if whichExists rsync; then
        verb="Synchronized"
        __catchEnvironment "$handler" rsync -a --exclude "*/.git/" --delete "$source/" "$target/" || return $?
      else
        verb="Copied"
        __catchEnvironment "$handler" cp -R "$source/" "$target" || return $?
        __catchEnvironment find "$target" -name .git -type d -delete || return $?
      fi
      printf -- "%s %s %s %s %s (%s)\n" "$aok" "$(decorate info "$verb")" "$(decorate file "$developmentHome")" "$arrowIcon" "$showName" "$(decorate file "$(realPath "$target")")"
    elif [ -L "$target" ]; then
      printf -- "%s %s %s %s\n" "$aok" "$(decorate file "$target")" "$arrowIcon" "$(decorate file "$(realPath "$target")")"
    elif [ -f "$home/$versionJSON" ]; then
      if confirmYesNo --timeout 30 --default false "$(decorate warning "Removing $(decorate file "$target") in project $showName"?)"; then
        __catchEnvironment "$handler" rm -rf "$target" || return $?
        __catchEnvironment "$handler" ln -s "$source" "$target" || return $?
      else
        statusMessage --last decorate error "Nothing removed."
      fi
    else
      __throwEnvironment "$handler" "$versionJSON does not exist, will not update." || return $?
    fi
  fi
}

_developerDevelopmentLink() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Installer can fall back
__developerDevelopmentRevert() {
  local handler="$1" home="$2" relPath="$3" developmentHome="$4" && shift 4

  [ $# -gt 0 ] || __throwArgument "$handler" "Missing installer" || return $?

  local target="$home/$relPath/"
  __catchEnvironment "$handler" rm -rf "$target" || return $?

  if [ $# -eq 1 ] && ! isExecutable "$1"; then
    local binary="$1" installer
    installer="$developmentHome/$relPath/$binary"]
    [ -x "$installer" ] || __throwEnvironment "$handler" "$installer does not exist" || return $?
    __catch "$handler" directoryRequire "$target" || return $?
    __catchEnvironment "$handler" cp "$installer" "$target/$binary" || return $?
    set -- "$target/$binary"
  fi

  __catchEnvironment "$handler" "$@" || return $?
  [ -d "$target" ] || __throwEnvironment "$handler" "Installer $(decorate code "$*") did not install $(decorate file "$target")"
}
