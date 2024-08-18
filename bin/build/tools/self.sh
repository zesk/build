#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Zesk Build tools
#
# Test: o test/tools/self-tests.sh
# Docs: o docs/_templates/tools/self.md


# Installs `install-bin-build.sh` the first time in a new project, and modifies it to work in the application path.
# Argument: --help - Optional. Flag. This help.
# Argument: --diff - Optional. Flag. Show differences between new and old files if changed.
# Argument: --local - Optional. Flag. Use local copy of `install-bin-build.sh` instead of downloaded version.
# Argument: path - Optional. Directory. Path to install the binary. Default is `bin`. If ends with `.sh` will name the binary this name.
# Argument: applicationHome - Optional. Directory. Path to the application home directory. Default is current directory.
# Usage: {fn} [ --help ] [ --diff ] [ --local ] [ path [ applicationHome ] ]
installInstallBuild() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex
  local exitCode
  local path applicationHome temp relTop home
  local installBinName source target url showDiffFlag localFlag verb

  exitCode=0
  installBinName="install-bin-build.sh"
  path=
  applicationHome=
  showDiffFlag=false
  localFlag=false
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
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
          __failArgument "$usage" "unknown argument #$argumentIndex: $argument" || return $?
        fi
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || return $?
  done

  # Validate paths and force realPath
  # default application home is $(pwd)
  [ -n "$applicationHome" ] || applicationHome="$(__usageEnvironment "$usage" pwd)" || return $?
  # default installation path home is $(pwd)/bin
  [ -n "$path" ] || path="$applicationHome/bin"
  path=$(__usageEnvironment "$usage" realPath "$path") || return $?
  applicationHome="$(__usageEnvironment "$usage" realPath "$applicationHome")" || return $?

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
    __failArgument "$usage" "Path ($path) ($(realPath "$path")) is not within applicationHome ($applicationHome)" || return $?
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
    home=$(__usageEnvironment "$usage" buildHome) || return $?
    source="$home/bin/build/$installBinName"
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
  grep -v -e '^__installPackageConfiguration '
  printf "__installPackageConfiguration %s \"%s\"\n" "$1" '$@'
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
  diff "$@" | grep -v -e '^__installPackageConfiguration ' | grep -c '[<>]'
}

# Usage: {fn}
# Environment: BUILD_HOME
# Prints the build home directory (usually same as the application root)
buildHome() {
  local usage="_${FUNCNAME[0]}"
  export BUILD_HOME
  if [ -z "${BUILD_HOME-}" ]; then
    # Special for a reason - do not use buildEnvironmentLoad - as it causes recursion problems
    __usageEnvironment "$usage" source "$(dirname "${BASH_SOURCE[0]}")/../env/BUILD_HOME.sh" || return $?
    [ -n "${BUILD_HOME-}" ] || __failEnvironment "$usage" "BUILD_HOME STILL blank" || return $?
  fi
  printf "%s\n" "${BUILD_HOME-}"
}
_buildHome() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# Environment: BUILD_HOME
# Prints the list of functions defined in Zesk Build
buildFunctions() {
  local usage="_${FUNCNAME[0]}"
  local home
  home=$(__usageEnvironment "$usage" buildHome) || return $?
  {
    cat "$home/bin/build/tools/_sugar.sh" "$home/bin/build/tools/sugar.sh" | grep -e '^_.*() {' | cut -d '(' -f 1
    "$home/bin/build/tools.sh" declare -F | cut -d ' ' -f 3 | grep -v -e '^_'
  }
}
_buildFunctions() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Path to cache directory for build system.
#
# Defaults to `$HOME/.build` unless `$HOME` is not a directory.
#
# Appends any passed in arguments as path segments.
#
# Example:     logFile=$({fn} test.log)
# Usage: {fn} [ pathSegment ... ]
# Argument: pathSegment - One or more directory or file path, concatenated as path segments using `/`
#
buildCacheDirectory() {
  local usage="_${FUNCNAME[0]}"

  local suffix
  export BUILD_CACHE
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_CACHE || return $?

  suffix="$(printf "%s/" "$@")"
  suffix="${suffix%/}"
  suffix="$(printf "%s/%s" "${BUILD_CACHE%/}" "${suffix%/}")"
  printf "%s\n" "${suffix%/}"
}
_buildCacheDirectory() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Load one or more environment settings from bin/build/env or bin/env.
#
# Usage: {fn} [ envName ... ]
# Argument: envName - Optional. String. Name of the environment value to load. Afterwards this should be defined (possibly blank) and `export`ed.
#
# If BOTH files exist, both are sourced, so application environments should anticipate values
# created by build's default.
#
# Modifies local environment. Not usually run within a subshell.
#
# Environment: $envName
#
buildEnvironmentLoad() {
  local usage="_${FUNCNAME[0]}"
  local env file found home

  home=$(__usageEnvironment "$usage" buildHome) || return $?
  for env in "$@"; do
    found=false
    for file in "$home/bin/build/env/$env.sh" "$home/bin/env/$env.sh"; do
      if [ -x "$file" ]; then
        export "${env?}" || __failArgument "$usage" "export $env failed" || return $?
        found=true
        set -a || :
        # shellcheck source=/dev/null
        source "$file" || __failEnvironment "$usage" source "$file" return $?
        set +a || :
      fi
    done
    $found || __failEnvironment "$usage" "Missing $file" || return $?
  done
}
_buildEnvironmentLoad() {
  local exitCode

  exitCode="${1-}"
  shift || :
  printf "bin/build/env ERROR: %s\n" "$@" 1>&2
  debuggingStack
  return "$exitCode"
}

#
#
# Usage: {fn} name
# Argument: name - The log file name
# Argument: --no-create - Optional. Do not require creation of the directory where the log file will appear.
#
buildQuietLog() {
  local argument logFile flagMake argument
  local usage="_${FUNCNAME[0]}"

  flagMake=true
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case $1 in
      --no-create)
        flagMake=false
        ;;
      *)
        logFile="$(buildCacheDirectory "$1.log")" || __failEnvironment "$usage" buildCacheDirectory "$1.log" || return $?
        ! "$flagMake" || __usageEnvironment "$usage" requireFileDirectory "$logFile" || return $?
        printf "%s\n" "$logFile"
        ;;
    esac
    shift || :
  done
}
_buildQuietLog() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
