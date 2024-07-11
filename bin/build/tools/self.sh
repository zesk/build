#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Zesk Build tools
#
# Test: o test/tools/self-tests.sh
# Docs: o docs/_templates/tools/self.md

# Installs `install-bin-build.sh` the first time in a new project, and modifies it to work.
# Argument: --help - Optional. Flag. This help.
# Argument: --diff - Optional. Flag. Show differences between new and old files if changed.
# Argument: --local - Optional. Flag. Use local copy of `install-bin-build.sh` instead of downloaded version.
# Argument: path - Optional. Directory. Path to install the binary. Default is `bin`. If ends with `.sh` will name the binary this name.
# Argument: applicationHome - Optional. Directory. Path to the application home directory. Default is current directory.
# Usage: {fn} [ --help ] [ --diff ] [ --local ] [ path [ applicationHome ] ]
installInstallBuild() {
  local usage="_${FUNCNAME[0]}"
  local argument exitCode
  local path applicationHome temp relTop
  local installBinName target url showDiffFlag localFlag verb

  exitCode=0
  installBinName="install-bin-build.sh"
  path=
  applicationHome=
  showDiffFlag=false
  localFlag=false
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return $?
        ;;
      --diff)
        showDiffFlag=true
        ;;
      --local)
        localFlag=true
        ;;
      *)
        if [ -z "$path" ]; then
          path=$(usageArgumentFileDirectory "$usage" "path" "$1") || return $?
        elif [ -z "$applicationHome" ]; then
          applicationHome=$(usageArgumentDirectory "$usage" "applicationHome" "$1") || return $?
        else
          __failArgument "$usage" "unknown argument: $(consoleValue "$argument")" || return $?
        fi
        ;;
    esac
    shift || :
  done

  # Validate paths
  # default application home is $(pwd)
  [ -n "$applicationHome" ] || applicationHome="$(__usageEnvironment "$usage" pwd)" || return $?
  # default installation path home is $(pwd)/bin
  [ -n "$path" ] || path="$applicationHome/bin"
  if ! isAbsolutePath "$path"; then
    path=$(__usageEnvironment "$usage" realPath "$path") || return $?
  fi
  if ! isAbsolutePath "$applicationHome"; then
    applicationHome="$(__usageEnvironment "$usage" realPath "$applicationHome")" || return $?
  fi

  # Custom target binary?
  if [ "${path%.sh}" != "$path" ]; then
    target="$path"
    path=$(__usageEnvironment "$usage" dirname "$path") || return $?
  elif [ -d "$path" ]; then
    target="$path/$installBinName"
  else
    __failEnvironment "$usage" "$path is not a directory" || return $?
  fi

  # Compute relTop
  relTop="${path#"$applicationHome"}"
  if [ "$relTop" = "$path" ]; then
    __failArgument "Path ($path) is not within applicationHome ($applicationHome)" || return $?
  fi
  if [ -z "$relTop" ]; then
    relTop=.
  else
    relTop=$(printf "%s\n" "$relTop" | sed -e 's/[^/]//g' -e 's/\//..\//g')
    relTop="${relTop%/}"
  fi

  # Get installation binary
  temp="$path/.downloaded.$$"
  if $localFlag; then
    export BUILD_HOME
    __usageEnvironment "$usage" buildEnvironmentLoad BUILD_HOME || return $?
    source="$BUILD_HOME/bin/build/$installBinName"
    [ -x "$source" ] || __failEnvironment "$usage" "$source is not executable" || return $?
    __usageEnvironment "$usage" cp "$source" "$temp" || return $?
  else
    url=$(_installInstallBuildRemote "$usage") || _clean $? "$temp" || return $?
    if ! curl -s -o - "$url" >"$temp"; then
      __failEnvironment "$usage" "Unable to download $(consoleCode "$url")" || _clean $? "$temp" || return $?
    fi
  fi

  # Modify based on current published version
  if _installInstallBuildIsLegacy <"$temp"; then
    __usageEnvironment "$usage" _installInstallBuildCustomizeLegacy "$relTop" <"$temp" >"$temp.custom"
  else
    __usageEnvironment "$usage" _installInstallBuildCustomize "$relTop" <"$temp" >"$temp.custom"
  fi
  verb=Installed
  [ ! -f "$target" ] || verb=Updated
  # Work modified file
  rm -f "$temp" || :
  temp="$temp.custom"
  # Show diffs
  ! $showDiffFlag || _installInstallBuildDiffer "$usage" "$temp" "$target" || _clean $? "$temp" || return $?
  # Copy to target
  __usageEnvironment "$usage" cp "$temp" "$target" || _clean $? "$temp" || return $?
  rm -rf "$temp" || :
  # Clean up and make executable
  __usageEnvironment "$usage" chmod +x "$target" || exitCode=$?
  [ "$exitCode" -ne 0 ] && return "$exitCode"
  # Life is good
  statusMessage printf -- "%s %s (%s=\"%s\")\n" "$(consoleSuccess "$verb")" "$(consoleCode "$target")" "$(consoleLabel relTop)" "$(consoleValue "$relTop")"
  clearLine || :
  return 0
}
_installInstallBuildIsLegacy() {
  grep -q '^relTop=' >/dev/null
}
_installInstallBuildCustomize() {
  grep -v -e '^installBinBuild '
  printf "installBinBuild %s \"%s\"\n" "$1" '$@'
}
_installInstallBuildCustomizeLegacy() {
  sed "s/^relTop=.*$/relTop=$(quoteSedPattern "$1")/g"
}
_installInstallBuild() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Fetch the remote URL to get installer
_installInstallBuildRemote() {
  local usage="$1"
  export BUILD_INSTALL_URL

  __usageEnvironment "$usage" whichApt curl curl || return $?
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_INSTALL_URL || return $?
  urlParse "${BUILD_INSTALL_URL-}" >/dev/null || __failEnvironment "$usage" "BUILD_INSTALL_URL ($BUILD_INSTALL_URL) is not a valid URL" || return $?

  printf "%s\n" "${BUILD_INSTALL_URL}"
}

# Usage: {fn} source target
# Show differences between installations
_installInstallBuildDiffer() {
  local usage="$1" diffLines
  shift
  if [ -x "$target" ]; then
    diffLines="$(__usageEnvironment "$usage" _installInstallBuildDifferFilter -c "$@")" || return $?
    [ "$diffLines" -gt 0 ] || return 0
    consoleMagenta "--- Changes: $diffLines ---"
    _installInstallBuildDifferFilter "$@" || :
    consoleMagenta "--- End of changes ---"
  fi
}

# Usage: {fn} diff-arguments
# Argument: diff-arguments - Required. Arguments. Passed to diff.
_installInstallBuildDifferFilter() {
  diff "$@" | grep -v -e '^installBinBuild ' | grep -c '[<>]'
}
