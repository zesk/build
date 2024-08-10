#!/usr/bin/env bash
#
# Identical template
#
# Original of _installRemotePackage
#
# See: bin/build/install-bin-build.sh
#
# Requires IDENTICAL: _realPath whichExists _colors _tinySugar _return
#
# Copyright &copy; 2024 Market Acumen, Inc.

# IDENTICAL _installRemotePackage EOF

# Usage: {fn} relativePath installPath url urlFunction [ --local localPackageDirectory ] [ --debug ] [ --force ] [ --diff ]
# fn: {base}
# Installs a remote package system in a local project directory if not installed. Also
# will overwrite the installation binary with the latest version after installation.
#
# URL can be determined programmatically using `urlFunction`.
#
# Argument: --local localPackageDirectory - Optional. Directory. Directory of an existing bin/infrastructure installation to mock behavior for testing
# Argument: --url url - Optional. URL. URL of a tar.gz. file. Download source code from here.
# Argument: --user headerText - Optional. String. Add `username:password` to remote request.
# Argument: --header headerText - Optional. String. Add one or more headers to the remote request.
# Argument: --url-function urlFunction - Optional. Function. Function to return the URL to download.
# Argument: --check-function checkFunction - Optional. Function. Function to check the installation and output the version number or package name.
# Argument: --debug - Optional. Flag. Debugging is on.
# Argument: --force - Optional. Flag. Force installation even if file is up to date.
# Argument: --diff - Optional. Flag. Show differences between old and new file.
# Argument: --replace - Optional. Flag. Replace an old version of this script with this one and delete this one. Internal only, do not use.
# Exit Code: 1 - Environment error
# Exit Code: 2 - Argument error
_installRemotePackage() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex
  local relative="${1-}" packagePath="${2-}" packageInstallerName="${3-}"
  local argument start ignoreFile tarArgs
  local forceFlag installFlag localPath message installArgs
  local myBinary myPath osName url urlFunction checkFunction applicationHome installPath headers

  shift 3
  case "${BUILD_DEBUG-}" in 1 | true) __installRemotePackageDebug BUILD_DEBUG ;; esac

  installArgs=()
  url=
  localPath=
  forceFlag=false
  urlFunction=
  checkFunction=
  headers=()
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument #$argumentIndex: $argument" || return $?
    case "$argument" in
      --debug)
        __installRemotePackageDebug "$argument"
        ;;
      --diff)
        installArgs+=("$argument")
        ;;
      --replace)
        newName="${BASH_SOURCE[0]%.*}"
        __usageEnvironment "$usage" cp -f "${BASH_SOURCE[0]}" "$newName" || return $?
        __usageEnvironment "$usage" rm -rf "${BASH_SOURCE[0]}" || return $?
        return 0
        ;;
      --force)
        forceFlag=true
        ;;
      --mock | --local)
        [ -z "$localPath" ] || __failArgument "$usage" "$argument already" || return $?
        shift
        [ -n "${1-}" ] || __failArgument "$usage" "$argument blank argument #$argumentIndex" || return $?
        localPath="$(__usageArgument "$usage" realPath "${1%/}")" || return $?
        [ -x "$localPath/tools.sh" ] || __failArgument "$usage" "$argument argument (\"$(consoleCode "$localPath")\") must be path to bin/build containing tools.sh" || return $?
        ;;
      --user)
        shift
        headers+=("--user" "$(usageArgumentString "$usage" "$argument" "${1-}")")
        ;;
      --header)
        shift
        headers+=("-H" "$(usageArgumentString "$usage" "$argument" "${1-}")")
        ;;
      --url)
        shift
        [ -z "$url" ] || __failArgument "$usage" "$argument already" || return $?
        [ -n "${1-}" ] || __failArgument "$usage" "$argument blank argument" || return $?
        url="$1"
        ;;
      --url-function)
        shift
        [ -z "$urlFunction" ] || __failArgument "$usage" "$argument already" || return $?
        [ -n "${1-}" ] || __failArgument "$usage" "$argument blank argument" || return $?
        urlFunction="$1"
        ;;
      --check-function)
        shift
        [ -z "$checkFunction" ] || __failArgument "$usage" "$argument already" || return $?
        [ -n "${1-}" ] || __failArgument "$usage" "$argument blank argument" || return $?
        checkFunction="$1"
        ;;
      *)
        __failArgument "$usage" "unknown argument #$argumentIndex: $argument" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument" || return $?
  done

  if [ -z "$url" ]; then
    if [ -n "$urlFunction" ]; then
      url=$(__usageEnvironment "$usage" "$urlFunction" "$usage") || return $?
      if [ -z "$url" ]; then
        __failArgument "$usage" "$urlFunction failed" || return $?
      fi
    fi
  fi
  if [ -z "$url" ] && [ -z "$localPath" ]; then
    __failArgument "$usage" "--local or --url|--url-function is required" || return $?
  fi

  # Move to starting point
  myBinary=$(__usageEnvironment "$usage" realPath "${BASH_SOURCE[0]}") || return $?
  myPath="$(__usageEnvironment "$usage" dirname "$myBinary")" || return $?
  applicationHome=$(__usageEnvironment "$usage" realPath "$myPath/$relative") || return $?
  installPath="$applicationHome/$packagePath"
  installFlag=false
  if [ ! -d "$installPath" ]; then
    if $forceFlag; then
      printf "%s (%s)\n" "$(consoleOrange "Forcing installation")" "$(consoleBlue "directory does not exist")"
    fi
    installFlag=true
  elif $forceFlag; then
    printf "%s (%s)\n" "$(consoleOrange "Forcing installation")" "$(consoleBoldBlue "directory exists")"
    installFlag=true
  fi
  binName=" ($(consoleBoldBlue "$(basename "$myBinary")"))"
  if $installFlag; then
    start=$(($(__usageEnvironment "$usage" date +%s) + 0)) || return $?
    __installRemotePackageDirectory "$usage" "$packagePath" "$applicationHome" "$url" "$localPath" "${headers[@]+"${headers[@]}"}" || return $?
    [ -d "$installPath" ] || __failEnvironment "$usage" "Unable to download and install $packagePath ($installPath not a directory, still)" || return $?
    messageFile=$(__usageEnvironment "$usage" mktemp) || return $?
    if [ -n "$checkFunction" ]; then
      "$checkFunction" "$usage" "$installPath" >"$messageFile" 2>&1 || return $?
    else
      __usageEnvironment "$usage" printf "%s\n" "$packagePath" >"$messageFile" || return $?
    fi
    message="Installed $(cat "$messageFile") in $(($(date +%s) - start)) seconds$binName"
    rm -f "$messageFile" || :
  else
    messageFile=$(__usageEnvironment "$usage" mktemp) || return $?
    if [ -n "$checkFunction" ]; then
      "$checkFunction" "$usage" "$installPath" >"$messageFile" 2>&1 || return $?
    else
      __usageEnvironment "$usage" printf "%s\n" "$packagePath" >"$messageFile" || return $?
    fi
    message="$(cat "$messageFile") already installed"
    rm -f "$messageFile" || :
  fi
  __installRemotePackageGitCheck "$applicationHome" "$packagePath" || :
  message="$message (local)$binName"
  printf "%s\n" "$message"
  __installRemotePackageLocal "$installPath/$packageInstallerName" "$myBinary" "$relative"
}

# Error handler for _installRemotePackage
# Usage: {fn} exitCode [ message ... ]
__installRemotePackage() {
  local exitCode="$1"
  shift || :
  printf "%s: %s -> %s\n" "$(consoleCode "${BASH_SOURCE[0]}")" "$(consoleError "$*")" "$(consoleOrange "$exitCode")"
  return "$exitCode"
}

# Debug is enabled, show why
__installRemotePackageDebug() {
  consoleOrange "${1-} enabled" && set -x
}

# Install the package directory
__installRemotePackageDirectory() {
  local usage="$1" packagePath="$2" applicationHome="$3" url="$4" localPath="$5"
  local start tarArgs
  local target="$applicationHome/.$$.package.tar.gz"

  shift 5
  if [ -n "$localPath" ]; then
    __installRemotePackageDirectoryLocal "$usage" "$packagePath" "$applicationHome" "$localPath"
    return $?
  fi
  __usageEnvironment "$usage" curl -L -s "$url" -o "$target" "$@" || return $?
  [ -f "$target" ] || __failEnvironment "$usage" "$target does not exist after download from $url" || return $?
  packagePath=${packagePath%/}
  packagePath=${packagePath#/}
  if ! osName="$(uname)" || [ "$osName" != "Darwin" ]; then
    tarArgs=(--wildcards "*/$packagePath/*")
  else
    tarArgs=(--include="*/$packagePath/*")
  fi
  __usageEnvironment "$usage" pushd "$(dirname "$target")" >/dev/null || return $?
  __usageEnvironment "$usage" tar xf "$target" --strip-components=1 "${tarArgs[@]}" || return $?
  __usageEnvironment "$usage" popd >/dev/null || return $?
  rm -f "$target" || :
}

# Install the build directory from a copy
__installRemotePackageDirectoryLocal() {
  local usage="$1" packagePath="$2" applicationHome="$3" localPath="$4" installPath tempPath

  installPath="${applicationHome%/}/${packagePath#/}"
  # Clean target regardless
  if [ -d "$installPath" ]; then
    tempPath="$installPath.aboutToDelete.$$"
    __usageEnvironment "$usage" rm -rf "$tempPath" || return $?
    __usageEnvironment "$usage" mv -f "$installPath" "$tempPath" || return $?
    __usageEnvironment "$usage" cp -r "$localPath" "$installPath" || _undo $? rf -f "$installPath" || _undo $? mv -f "$tempPath" "$installPath" || return $?
    __usageEnvironment "$usage" rm -rf "$tempPath" || :
  else
    tempPath=$(__usageEnvironment "$usage" dirname "$installPath") || return $?
    [ -d "$tempPath" ] || __usageEnvironment "$usage" mkdir -p "$tempPath" || return $?
    __usageEnvironment "$usage" cp -r "$localPath" "$installPath" || return $?
  fi
}

# Check .gitignore is correct
__installRemotePackageGitCheck() {
  local applicationHome="$1" pattern="${2%/}"
  pattern="/${pattern#/}/"
  local ignoreFile="$1/.gitignore"
  if [ -f "$ignoreFile" ] && ! grep -q -e "^$pattern" "$ignoreFile"; then
    printf "%s %s %s %s:\n\n    %s\n" "$(consoleCode "$ignoreFile")" \
      "does not ignore" \
      "$(consoleCode "$pattern")" \
      "$(consoleError "recommend adding it")" \
      "$(consoleCode "echo $pattern/ >> $ignoreFile")"
  fi
}

# Usage: {fn} _installRemotePackageSource targetBinary relativePath
__installRemotePackageLocal() {
  local source="$1" myBinary="$2" relTop="$3" count=0 total=5
  {
    grep -v -e '^__installPackageConfiguration ' <"$source"
    printf "%s %s \"%s\"\n" "__installPackageConfiguration" "$relTop" '$@'
  } >"$myBinary.$$"
  chmod +x "$myBinary.$$" || _environment "chmod +x failed" || return $?
  pid=$(
    "$myBinary.$$" --replace &
    printf %d $!
  )
  if ! _integer "$pid"; then
    _environment "$usage" "Unable to run $myBinary.$$" || return $?
  fi
  while kill -0 "$pid" 2>/dev/null; do
    printf "%d\r" "$pid" "$count"
    count=$((count + 1))
    sleep 1
    if [ "$count" -gt "$total" ]; then
      printf "\n"
      _environment "Stopping waiting for $pid after $total seconds" || return $?
    fi
  done
  printf "\r     \r"
  return 0
}
