#!/usr/bin/env bash
#
# Identical template
#
# Original of _installRemotePackage
#
# See: bin/build/install-bin-build.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.

# These next three functions are not used and are here simply to provide documentation.

# Used to check the remote version against the local version of a package to be installed.
# fn: packageVersionFunction
# Argument: handler - Function. Required. Function to call when an error occurs. Signature `errorHandler`.
# Argument: applicationHome - Directory. Required. Path to the application home where target will be installed, or is installed. (e.g. myApp/)
# Argument: installPath - Directory. Required. Path to the installPath home where target will be installed, or is installed. (e.g. myApp/bin/build)
# `versionFunction` should exit 0 to halt the installation, in addition it should output the current version as a decorated string.
# stdout: version information
# Exit Code: 0 - Do not upgrade, version is same as remote (stdout is found, current version)
# Exit Code: 1 - Do upgrade, version changed. (stdout is version change details)
# See: _installRemotePackage
__packageVersionFunction() {
  return 0
}

# fn: packageUrlFunction
# Prints the remote URL for a package, or exits non-zero on error.
#
# Takes a single argument, the error handler, a function.
#
# Argument: handler - Function. Required. Function to call when an error occurs.
# See: _installRemotePackage
__packageUrlFunction() {
  printf "%s\n" "https://localhost:1234/download.tar.gz"
}

# fn: packageCheckFunction
# Verify an installation afterwards.
#
# Argument: handler - Function. Required. Function to call when an error occurs.
# Argument: installPath - Directory. Required. Path to the installPath home where target will be installed, or is installed. (e.g. myApp/bin/build)
#
# If `checkFunction` fails, it should output any errors to `stderr` and return a non-zero exit code.
# See: _installRemotePackage
__packageCheckFunction() {
  return 0
}

###################################################################################################################################################################
###################################################################################################################################################################
###################################################################################################################################################################

# IDENTICAL _installRemotePackage EOF

# Installs {name} in a local project directory if not installed. Also
# will overwrite {source} with the latest version after installation.
#
# INTERNAL: URL can be determined programmatically using `urlFunction`.
# INTERNAL:
# INTERNAL: `versionFunction` can be used to avoid upgrades when versions have not changed. `versionFunction` can return a string which is appended to the message:
# INTERNAL:
# INTERNAL:      "{name} Newest version installed {versionFunctionOutput}"
# INTERNAL:
# INTERNAL: Calling signature for `version-function`:
# INTERNAL:
# INTERNAL:    Usage: version-function handler applicationHome installPath
# INTERNAL:    Argument: handler - Function. Required. Function to call when an error occurs.
# INTERNAL:    Argument: applicationHome - Directory. Required. Path to the application home where target will be installed, or is installed. (e.g. myApp/)
# INTERNAL:    Argument: installPath - Directory. Required. Path to the installPath home where target will be installed, or is installed. (e.g. myApp/bin/build)
# INTERNAL:
# INTERNAL: `version-function` should return 0 to halt the installation. Any other return code, installation continues normally.
# INTERNAL:
# INTERNAL: Calling signature for `url-function`:
# INTERNAL:
# INTERNAL:    Usage: url-function handler
# INTERNAL:    Argument: handler - Function. Required. Function to call when an error occurs.
# INTERNAL:
# INTERNAL: `url-function` should output a URL and exit 0. Any other return code terminates installation.
# INTERNAL:
# INTERNAL: Calling signature for `check-function`:
# INTERNAL:
# INTERNAL:    Usage: check-function handler installPath
# INTERNAL:    Argument: handler - Function. Required. Function to call when an error occurs.
# INTERNAL:    Argument: installPath - Directory. Required. Path to the installPath home where target will be installed, or is installed. (e.g. myApp/bin/build)
# INTERNAL:
# INTERNAL: If `checkFunction` fails, it should output any errors to `stderr` and return a non-zero exit code.
# INTERNAL:
# Argument: --source source - Optional. String. Source to display for the binary name. INTERNAL.
# Argument: --name name - Optional. String. Name to display for the remote package name. INTERNAL.
# Argument: --local localPackageDirectory - Optional. Directory. Directory of an existing installation to mock behavior for testing. INTERNAL.
# Argument: --url url - Optional. URL. URL of a tar.gz file. Download source code from here.
# Argument: --user headerText - Optional. String. Add `username:password` to remote request.
# Argument: --header headerText - Optional. String. Add one or more headers to the remote request.
# Argument: --version-function urlFunction - Optional. Function. Function to compare live version to local version. Exits 0 if they match. Output version text if you want. INTERNAL.
# Argument: --url-function urlFunction - Optional. Function. Function to return the URL to download. INTERNAL.
# Argument: --check-function checkFunction - Optional. Function. Function to check the installation and output the version number or package name. INTERNAL.
# Argument: --installer installer - Optional. Executable. Binary to run after installation succeeds.
# Argument: --replace fie - Optional. Flag. Replace the target file with this script and delete this one. Internal only, do not use. INTERNAL.
# Argument: --debug - Optional. Flag. Debugging is on. INTERNAL.
# Argument: --force - Optional. Flag. Force installation even if file is up to date.
# Argument: --diff - Optional. Flag. Show differences between old and new file.
# Exit Code: 1 - Environment error
# Exit Code: 2 - Argument error
# Requires: cp rm cat printf realPath whichExists _return fileTemporaryName __catchArgument __throwArgument __catchEnvironment decorate usageArgumentString isFunction
_installRemotePackage() {
  local usage="_${FUNCNAME[0]}"

  local relative="${1-}" packagePath="${2-}" packageInstallerName="${3-}"

  shift 3

  case "${BUILD_DEBUG-}" in 1 | true) __installRemotePackageDebug BUILD_DEBUG ;; esac

  local installArgs=() url="" localPath="" forceFlag=false installReason="" urlFunction="" checkFunction="" fetchArguments=()
  local name="${FUNCNAME[1]}"

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
      --source)
        shift
        source=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        ;;
      --name)
        shift
        name=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        ;;
      --debug)
        __installRemotePackageDebug "$argument"
        ;;
      --diff)
        installArgs+=("$argument")
        ;;
      --replace)
        shift
        newName=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        decorate bold-blue "Replacing $(decorate orange "${BASH_SOURCE[0]}") -> $(decorate bold-orange "$newName")"
        __catchEnvironment "$usage" cp -f "${BASH_SOURCE[0]}" "$newName" || return $?
        __catchEnvironment "$usage" rm -rf "${BASH_SOURCE[0]}" || return $?
        return 0
        ;;
      --force)
        forceFlag=true
        installReason="--force specified"
        ;;
      --mock | --local)
        [ -z "$localPath" ] || __throwArgument "$usage" "$argument already" || return $?
        shift
        [ -n "${1-}" ] || __throwArgument "$usage" "$argument blank argument #$__index" || return $?
        localPath="$(__catchArgument "$usage" realPath "${1%/}")" || return $?
        [ -x "$localPath/tools.sh" ] || __throwArgument "$usage" "$argument argument (\"$(decorate code "$localPath")\") must be path to bin/build containing tools.sh" || return $?
        ;;
      --user | --header | --password)
        shift
        fetchArguments+=("$argument" "$(usageArgumentString "$usage" "$argument" "${1-}")")
        ;;
      --url)
        shift
        [ -z "$url" ] || __throwArgument "$usage" "$argument already" || return $?
        [ -n "${1-}" ] || __throwArgument "$usage" "$argument blank argument" || return $?
        url="$1"
        ;;
      --version-function)
        shift
        [ -z "$versionFunction" ] || __throwArgument "$usage" "$argument already" || return $?
        isFunction "${1-}" || __throwArgument "$usage" "$argument not callable: ${1-}" || return $?
        versionFunction="$1"
        ;;
      --url-function)
        shift
        [ -z "$urlFunction" ] || __throwArgument "$usage" "$argument already" || return $?
        isFunction "${1-}" || __throwArgument "$usage" "$argument not callable: ${1-}" || return $?
        urlFunction="$1"
        ;;
      --installer)
        shift
        installers+=("$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
        ;;
      --check-function)
        shift
        [ -z "$checkFunction" ] || __throwArgument "$usage" "$argument already" || return $?
        isFunction "${1-}" || __throwArgument "$usage" "$argument not callable: ${1-}" || return $?
        checkFunction="$1"
        ;;
      *)
        __throwArgument "$usage" "unknown argument #$__index: $argument" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  local installFlag=false message
  local myBinary myPath applicationHome installPath
  # Move to starting point
  myBinary=$(__catchEnvironment "$usage" realPath "${BASH_SOURCE[0]}") || return $?
  myPath="$(__catchEnvironment "$usage" dirname "$myBinary")" || return $?
  applicationHome=$(__catchEnvironment "$usage" realPath "$myPath/$relative") || return $?
  installPath="$applicationHome/$packagePath"

  if [ -z "$url" ]; then
    if [ -n "$urlFunction" ]; then
      url=$(__catchEnvironment "$usage" "$urlFunction" "$usage") || return $?
      if [ -z "$url" ]; then
        __throwArgument "$usage" "$urlFunction failed" || return $?
      fi
    fi
  fi
  if [ -z "$url" ] && [ -z "$localPath" ]; then
    __throwArgument "$usage" "--local or --url|--url-function is required" || return $?
  fi

  if [ ! -d "$installPath" ]; then
    [ -n "$installReason" ] || installReason="not installed"
    if $forceFlag; then
      printf "%s (%s)\n" "$(decorate orange "Forcing installation")" "$(decorate blue "$installReason")"
    fi
    installFlag=true
  elif ! $forceFlag && [ -n "$versionFunction" ]; then
    local newVersion=""
    if newVersion=$("$versionFunction" "$usage" "$applicationHome" "$installPath"); then
      printf "%s %s %s\n" "$(decorate value "$name")" "$(decorate info "Newest version installed")" "$newVersion"
      __installRemotePackageGitCheck "$applicationHome" "$packagePath" || :
      return 0
    fi
    forceFlag=true
    installReason="newer version available: $newVersion"
  fi
  if $forceFlag; then
    [ -n "$installReason" ] || installReason="directory exists"
    printf "%s (%s)\n" "$(decorate orange "Forcing installation")" "$(decorate bold-blue "$installReason")"
    installFlag=true
  fi
  binName=" ($(decorate bold-blue "$(basename "$myBinary")"))"
  if $installFlag; then
    local start
    start=$(($(__catchEnvironment "$usage" date +%s) + 0)) || return $?
    __installRemotePackageDirectory "$usage" "$packagePath" "$applicationHome" "$url" "$localPath" "${fetchArguments[@]+"${fetchArguments[@]}"}" || return $?
    [ -d "$installPath" ] || __throwEnvironment "$usage" "Unable to download and install $packagePath ($installPath not a directory, still)" || return $?
    messageFile=$(fileTemporaryName "$usage") || return $?
    if [ -n "$checkFunction" ]; then
      "$checkFunction" "$usage" "$installPath" >"$messageFile" 2>&1 || return $?
    else
      __catchEnvironment "$usage" printf -- "%s\n" "$packagePath" >"$messageFile" || return $?
    fi
    message="Installed $(cat "$messageFile") in $(($(date +%s) - start)) seconds$binName"
    __catchEnvironment "$usage" rm -f "$messageFile" || return $?
  else
    messageFile=$(fileTemporaryName "$usage") || return $?
    if [ -n "$checkFunction" ]; then
      "$checkFunction" "$usage" "$installPath" >"$messageFile" 2>&1 || return $?
    else
      __catchEnvironment "$usage" printf -- "%s\n" "$packagePath" >"$messageFile" || return $?
    fi
    message="$(cat "$messageFile") already installed"
    rm -f "$messageFile" || :
  fi
  __installRemotePackageGitCheck "$applicationHome" "$packagePath" || :
  message="$message (local)$binName"
  printf -- "%s\n" "$message"
  __installRemotePackageLocal "$installPath/$packageInstallerName" "$myBinary" "$relative"

  local installer
  for installer in "${installers[@]+"${installers[@]}"}"; do
    [ -f "$installer" ] || __throwEnvironment "$usage" "$installer is missing" || return $?
    [ -x "$installer" ] || __throwEnvironment "$usage" "$installer is not executable" || return $?
    __catchEnvironment "$usage" "$installer" || return $?
  done
}

# Error handler for _installRemotePackage
# Usage: {fn} exitCode [ message ... ]
# Requires: usageDocumentSimple
__installRemotePackage() {
  local source content
  source=$(basename "${BASH_SOURCE[0]}")
  content="$(usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@" | grep -v "INTERNAL")"
  content="${content//\{name\}/$name}"
  content="${content//\{source\}/$source}"
  printf -- "%s\n" "$content"
}

# Debug is enabled, show why
# Requires: decorate
# Debugging: 73b0bd4ba49583263542da725669003fc821eb63
__installRemotePackageDebug() {
  decorate orange "${1-} enabled" && set -x
}

# Install the package directory
# Requires: uname pushd popd rm tar dirname
# Requires: __catchEnvironment __throwEnvironment urlFetch
__installRemotePackageDirectory() {
  local usage="$1" packagePath="$2" applicationHome="$3" url="$4" localPath="$5"
  local start tarArgs osName
  local target="$applicationHome/.$$.package.tar.gz"

  shift 5
  if [ -n "$localPath" ]; then
    __installRemotePackageDirectoryLocal "$usage" "$packagePath" "$applicationHome" "$localPath"
    return $?
  fi
  __catchEnvironment "$usage" urlFetch "$url" "$target" || return $?
  [ -f "$target" ] || __throwEnvironment "$usage" "$target does not exist after download from $url" || return $?
  packagePath=${packagePath%/}
  packagePath=${packagePath#/}
  if ! osName="$(uname)" || [ "$osName" != "Darwin" ]; then
    tarArgs=(--wildcards "*/$packagePath/*")
  else
    tarArgs=(--include="*$packagePath/*")
  fi
  __catchEnvironment "$usage" pushd "$(dirname "$target")" >/dev/null || return $?
  __catchEnvironment "$usage" rm -rf "$packagePath" || return $?
  __catchEnvironment "$usage" tar xf "$target" --strip-components=1 "${tarArgs[@]}" || return $?
  __catchEnvironment "$usage" popd >/dev/null || return $?
  rm -f "$target" || :
}

# Install the build directory from a copy
# Requires: rm mv cp mkdir
# Requires: _undo __catchEnvironment __throwEnvironment
__installRemotePackageDirectoryLocal() {
  local usage="$1" packagePath="$2" applicationHome="$3" localPath="$4" installPath tempPath

  installPath="${applicationHome%/}/${packagePath#/}"
  # Clean target regardless
  if [ -d "$installPath" ]; then
    tempPath="$installPath.aboutToDelete.$$"
    __catchEnvironment "$usage" rm -rf "$tempPath" || return $?
    __catchEnvironment "$usage" mv -f "$installPath" "$tempPath" || return $?
    __catchEnvironment "$usage" cp -r "$localPath" "$installPath" || _undo $? rf -f "$installPath" -- mv -f "$tempPath" "$installPath" || return $?
    __catchEnvironment "$usage" rm -rf "$tempPath" || :
  else
    tempPath=$(__catchEnvironment "$usage" dirname "$installPath") || return $?
    [ -d "$tempPath" ] || __catchEnvironment "$usage" mkdir -p "$tempPath" || return $?
    __catchEnvironment "$usage" cp -r "$localPath" "$installPath" || return $?
  fi
}

# Check .gitignore is correct
# Requires: grep printf
# Requires: decorate
__installRemotePackageGitCheck() {
  local applicationHome="$1" pattern="${2%/}"
  pattern="/${pattern#/}/"
  local ignoreFile="$1/.gitignore"
  if [ -f "$ignoreFile" ] && ! grep -q -e "^$pattern" "$ignoreFile"; then
    printf -- "%s %s %s %s:\n\n    %s\n" "$(decorate code "$ignoreFile")" \
      "does not ignore" \
      "$(decorate code "$pattern")" \
      "$(decorate error "recommend adding it")" \
      "$(decorate code "echo $pattern/ >> $ignoreFile")"
  fi
}

# Usage: {fn} _installRemotePackageSource targetBinary relativePath
# Requires: grep printf chmod wait
# Requires: _environment isUnsignedInteger cat _clean
__installRemotePackageLocal() {
  local source="$1" myBinary="$2" relTop="$3"
  local log="$myBinary.$$.log"
  {
    grep -v -e '^__installPackageConfiguration ' <"$source"
    printf "%s %s \"%s\"\n" "__installPackageConfiguration" "$relTop" '$@'
  } >"$myBinary.$$"
  chmod +x "$myBinary.$$" || _environment "chmod +x failed" || return $?
  "$myBinary.$$" --replace "$myBinary" >"$log" 2>&1 &
  local pid=$!
  if ! isUnsignedInteger "$pid"; then
    _environment "Unable to run $myBinary.$$" || return $?
  fi
  wait "$pid" || _environment "$(printf "%s\n%s\n" "install log failed: $pid" "$(cat "$log")")" || _clean $? "$log" || return $?
  _clean 0 "$log" || return $?
}
