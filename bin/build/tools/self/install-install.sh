#!/usr/bin/env bash
#
# install-install.sh
#
# Install the installer
#
# Copyright &copy; 2025 Market Acumen, Inc.

__installInstallBinary() {
  local handler="$1" && shift

  local exitCode=0
  local path="" applicationHome="" temp relTop
  local installBinName="" source="" target url="" urlFunction="" postFunction="" showDiffFlag=false source verb localFlag=false

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
    --bin)
      shift
      installBinName=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --url-function)
      shift
      urlFunction=$(usageArgumentCallable "$handler" "$argument" "${1-}") || return $?
      ;;
    --post)
      shift
      postFunction=$(usageArgumentCallable "$handler" "$argument" "${1-}") || return $?
      ;;
    --url)
      shift
      url=$(usageArgumentURL "$handler" "$argument" "${1-}") || return $?
      ;;
    --source)
      shift
      source=$(usageArgumentFile "$handler" "$argument" "${1-}") || return $?
      ;;
    --diff)
      showDiffFlag=true
      ;;
    --local)
      localFlag=true
      ;;
    *)
      if [ -z "$path" ]; then
        path=$(usageArgumentFileDirectory "$handler" "path" "$1") || return $?
      elif [ -z "$applicationHome" ]; then
        applicationHome=$(usageArgumentDirectory "$handler" "applicationHome" "$1") || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  [ -n "$installBinName" ] || __throwArgument "$handler" "--bin is required" || return $?
  [ -n "$source" ] || __throwArgument "$handler" "--local-path is required" || return $?

  # Validate paths and force realPath
  # default application home is $(pwd)
  [ -n "$applicationHome" ] || applicationHome="$(__catchEnvironment "$handler" pwd)" || return $?
  # default installation path home is $(pwd)/bin
  [ -n "$path" ] || path="$applicationHome/bin"
  path=$(__catchEnvironment "$handler" realPath "$path") || return $?
  applicationHome="$(__catchEnvironment "$handler" realPath "$applicationHome")" || return $?

  # Custom target binary?
  if [ "${path%.sh}" != "$path" ]; then
    target="$path"
    path=$(__catchEnvironment "$handler" dirname "$path") || return $?
  elif [ -d "$path" ]; then
    target="$path/$installBinName"
  else
    __throwEnvironment "$handler" "$path is not a directory" || return $?
  fi

  # Compute relTop
  relTop="${path#"$applicationHome"}"
  if [ "$relTop" = "$path" ]; then
    __throwArgument "$handler" "Path ($path) ($(realPath "$path")) is not within applicationHome ($applicationHome)" || return $?
  fi
  relTop=$(directoryRelativePath "$relTop")

  # Get installation binary
  temp="$path/.downloaded.$$"
  if $localFlag; then
    [ -x "$source" ] || __throwEnvironment "$handler" "$source is not executable" || return $?
    __catchEnvironment "$handler" cp "$source" "$temp" || return $?
  else
    if [ -z "$url" ]; then
      [ -n "$urlFunction" ] || __catchArgument "$handler" "Need --url or --url-function" || return $?
      url=$("$urlFunction" "$handler") || return $?
      [ -n "$url" ] || __throwEnvironment "$urlFunction failed to generate a URL" || return $?
      urlValid "$url" || __throwEnvironment "$urlFunction failed to generate a VALID URL: $url" || return $?
    fi
    if ! curl -s -o - "$url" >"$temp"; then
      __throwEnvironment "$handler" "Unable to download $(decorate code "$url")" || returnClean $? "$temp" || return $?
    fi
  fi
  if _installInstallBinaryCanCustomize "$temp"; then
    __catchEnvironment "$handler" _installInstallBinaryCustomize "$relTop" <"$temp" >"$temp.custom" || returnClean $? "$temp" "$temp.custom" || return $?
    __catchEnvironment "$handler" mv -f "$temp.custom" "$temp" || returnClean $? "$temp" "$temp.custom" || return $?
  fi
  if [ -n "$postFunction" ]; then
    __catchEnvironment "$handler" "$postFunction" <"$temp" >"$temp.custom" || returnClean $? "$temp" "$temp.custom" || return $?
    __catchEnvironment "$handler" mv -f "$temp.custom" "$temp" || returnClean $? "$temp" "$temp.custom" || return $?
  fi

  verb=Installed
  [ ! -f "$target" ] || verb=Updated
  # Show diffs
  ! $showDiffFlag || _installInstallBinaryDiffer "$handler" "$temp" "$target" || returnClean $? "$temp" || return $?
  # Copy to target
  __catchEnvironment "$handler" cp "$temp" "$target" || returnClean $? "$temp" || return $?
  rm -rf "$temp" || :
  # Clean up and make executable
  __catchEnvironment "$handler" chmod +x "$target" || exitCode=$?
  [ "$exitCode" -ne 0 ] && return "$exitCode"
  # Life is good
  statusMessage --last printf -- "%s %s (%s=\"%s\")" "$(decorate success "$verb")" "$(decorate code "$target")" "$(decorate label relTop)" "$(decorate value "$relTop")"
  return 0
}

# Fetch the remote URL to get installer
__installInstallBuildRemote() {
  local handler="$1"
  export BUILD_INSTALL_URL

  __catch "$handler" packageWhich curl curl || return $?
  __catch "$handler" buildEnvironmentLoad BUILD_INSTALL_URL || return $?
  urlParse "${BUILD_INSTALL_URL-}" >/dev/null || __throwEnvironment "$handler" "BUILD_INSTALL_URL ($BUILD_INSTALL_URL) is not a valid URL" || return $?

  printf "%s\n" "${BUILD_INSTALL_URL}"
}

# Helper for installInstallBuild
__installInstallBinaryLegacy() {
  local temp
  local handler="returnMessage"

  temp=$(fileTemporaryName "$handler") || return $?
  cat >"$temp"
  if __installInstallBinaryIsLegacy <"$temp"; then
    __catch "$handler" __installInstallBinaryCustomizeLegacy "$relTop" <"$temp" || returnClean $? "$temp" || return $?
  else
    __catchEnvironment "$handler" cat "$temp" || return $?
  fi
  __catchEnvironment "$handler" rm "$temp" || return $?
}
__installInstallBinaryIsLegacy() {
  grep -q '^relTop=' >/dev/null
}
__installInstallBinaryCustomizeLegacy() {
  sed "s/^relTop=.*$/relTop=$(quoteSedReplacement "$1")/g"
}

# Usage: {fn} source target
# Show differences between installations
_installInstallBinaryDiffer() {
  local handler="$1" diffLines
  shift
  if [ -x "$target" ]; then
    diffLines="$(__catchEnvironment "$handler" _installInstallBinaryDifferFilter -c "$@")" || return $?
    [ "$diffLines" -gt 0 ] || return 0
    decorate magenta "--- Changes: $diffLines ---"
    _installInstallBinaryDifferFilter "$@" || :
    decorate magenta "--- End of changes ---"
  fi
}

# Usage: {fn} diff-arguments
# Argument: diff-arguments - Required. Arguments. Passed to diff.
_installInstallBinaryDifferFilter() {
  diff "$@" | grep -v -e '^__installPackageConfiguration ' | grep -c '[<>]'
}

_installInstallBinaryCanCustomize() {
  grep -q -e '^__installPackageConfiguration ' "$@"
}
_installInstallBinaryCustomize() {
  grep -v -e '^__installPackageConfiguration '
  printf "__installPackageConfiguration %s \"%s\"\n" "$1" '$@'
}
