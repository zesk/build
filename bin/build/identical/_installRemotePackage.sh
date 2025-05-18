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
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: relative - Required. RelativePath. Path from this script to our application root. INTERNAL.
# Argument: defaultPackagePath - Required. RelativePath. Path from application root to where the package should be installed. INTERNAL.
# Argument: packageInstallerName - Required. ApplicationFile. The new installer file, post installation, relative to the `installationPath`. INTERNAL.
# Argument: installationPath - Optional. ApplicationDirectory. Path to where the package should be installed instead of the defaultPackagePath.
# Argument: --help - Optional. Flag. Display this help.
# Argument: --source source - Optional. String. Source to display for the binary name. INTERNAL.
# Argument: --name name - Optional. String. Name to display for the remote package name. INTERNAL.
# Argument: --local localPackageDirectory - Optional. Directory. Directory of an existing installation to mock behavior for testing. INTERNAL.
# Argument: --url url - Optional. URL. URL of a tar.gz file. Download source code from here.
# Argument: --user username - Optional. String. Add `username:password` to remote request.
# Argument: --password passwordText - Optional. String. Add `username:password` to remote request.
# Argument: --header headerText - Optional. String. Add one or more headers to the remote request.
# Argument: --version-function urlFunction - Optional. Function. Function to compare live version to local version. Exits 0 if they match. Output version text if you want. INTERNAL.
# Argument: --url-function urlFunction - Optional. Function. Function to return the URL to download. INTERNAL.
# Argument: --check-function checkFunction - Optional. Function. Function to check the installation and output the version number or package name. INTERNAL.
# Argument: --installer installer - Optional. Executable. Multiple. Binary to run after installation succeeds. Can be supplied multiple times. If `installer` begins with a `@` then any errors by the installer are ignored.
# Argument: --replace file - Optional. File. Replace the target file with this script and delete this one. Internal only, do not use. INTERNAL.
# Argument: --finalize file - Optional. File. Remove the temporary file and exit 0. INTERNAL.
# Argument: --debug - Optional. Flag. Debugging is on. INTERNAL.
# Argument: --force - Optional. Flag. Force installation even if file is up to date.
# Argument: --skip-self - Optional. Flag. Skip the installation script self-update. (By default it is enabled.)
# Argument: --diff - Optional. Flag. Show differences between old and new file.
# Exit Code: 1 - Environment error
# Exit Code: 2 - Argument error
# Requires: cp rm cat printf realPath whichExists _return fileTemporaryName __catchArgument __throwArgument __catchEnvironment decorate usageArgumentString isFunction
_installRemotePackage() {
  local usage="_${FUNCNAME[0]}"

  local relative="${1-}" defaultPackagePath="${2-}" packageInstallerName="${3-}"

  shift 3

  case "${BUILD_DEBUG-}" in 1 | true) __installRemotePackageDebug BUILD_DEBUG ;; esac

  local source="" name="${FUNCNAME[1]}"
  local localPath="" fetchArguments=() url="" versionFunction="" urlFunction="" checkFunction="" installers=()
  local installPath="" installArgs=() forceFlag=false installReason="" skipSelf=false

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
    --mock | --local)
      [ -z "$localPath" ] || __throwArgument "$usage" "$argument already" || return $?
      shift
      [ -n "${1-}" ] || __throwArgument "$usage" "$argument blank argument #$__index" || return $?
      localPath="$(__catchArgument "$usage" realPath "${1%/}")" || return $?
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
    --check-function)
      shift
      [ -z "$checkFunction" ] || __throwArgument "$usage" "$argument already" || return $?
      isFunction "${1-}" || __throwArgument "$usage" "$argument not callable: ${1-}" || return $?
      checkFunction="$1"
      ;;
    --installer)
      shift
      installers+=("$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
      ;;
    #
    # I believe this ensures that the process running does not modify its source script directly
    #
    # 1. Copy new script to bin/installer.sh.$$
    # 2. Run exec bin/installer.sh.$$ --replace bin/installer.sh
    # 3. Memory reloaded with "new" version of script
    # 4. New version copies itself (.sh.$$) to old installer (.sh version), and runs
    # 4. exec bin/installer.sh --finalize bin/installer.sh.$$
    # 5. Loads NEW version of script, and then deletes `bin/installer.sh.$$` and exits
    #
    # But I could be wrong.
    #
    --replace)
      local newName
      shift
      newName=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
      decorate bold-blue "Updating -> $(decorate bold-orange "$newName")"
      __catchEnvironment "$usage" cp -f "${BASH_SOURCE[0]}" "$newName" || return $?
      __catchEnvironment "$usage" chmod +x "$newName" || return $?
      exec "$newName" --finalize "${BASH_SOURCE[0]}" || return $?
      return 0
      ;;
    --finalize)
      local oldName
      shift
      oldName=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
      __catchEnvironment "$usage" rm -rf "$oldName" || return $?
      return 0
      ;;
    --debug)
      __installRemotePackageDebug "$argument"
      ;;
    --skip-self)
      skipSelf=true
      ;;
    --force)
      forceFlag=true
      installReason="--force specified"
      ;;
    --diff)
      installArgs+=("$argument")
      ;;
    *)
      installPath=$(usageArgumentString "$usage" "installPath" "$1") || return $?
      installPath="${installPath%/}"
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  local installFlag=false
  local myBinary myPath applicationHome installPath packagePath
  # Move to starting point
  myBinary=$(__catchEnvironment "$usage" realPath "${BASH_SOURCE[0]}") || return $?
  myPath="${myBinary%/*}" || return $?
  applicationHome=$(__catchEnvironment "$usage" realPath "$myPath/$relative") || return $?
  applicationHome="${applicationHome%/}"
  [ -n "$installPath" ] || installPath="$applicationHome/$defaultPackagePath"
  packagePath="${installPath#"$applicationHome"}"
  packagePath="${packagePath#/}"

  __catchEnvironment "$usage" pushd "$applicationHome" || return $?
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
    if newVersion=$("$versionFunction" "$usage" "$applicationHome" "$packagePath"); then
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

  local message suffix
  if $installFlag; then
    local start
    start=$(($(__catchEnvironment "$usage" date +%s) + 0)) || return $?
    __installRemotePackageDirectory "$usage" "$packagePath" "$applicationHome" "$url" "$localPath" "${fetchArguments[@]+"${fetchArguments[@]}"}" || return $?
    [ -d "$packagePath" ] || __throwEnvironment "$usage" "Unable to download and install $packagePath (not a directory, still)" || return $?
    message="Installed "
    suffix="in $(($(date +%s) - start)) seconds$binName"
  else
    message=""
    suffix="already installed"
  fi
  local messageFile
  messageFile=$(fileTemporaryName "$usage") || return $?
  if [ -n "$checkFunction" ]; then
    "$checkFunction" "$usage" "$packagePath" >"$messageFile" 2>&1 || return $?
  else
    __catchEnvironment "$usage" printf -- "%s\n" "$packagePath" >"$messageFile" || return $?
  fi
  message="${message}Installed $(cat "$messageFile") $suffix"
  __catchEnvironment "$usage" rm -f "$messageFile" || return $?
  __installRemotePackageGitCheck "$applicationHome" "$packagePath" || :
  message="$message (local)$binName"
  printf -- "%s\n" "$message"

  local exitCode=0

  if [ "${#installers[@]}" -gt 0 ]; then
    local installer lastExit=0 installerLog

    installerLog=$(fileTemporaryName "$usage") || return $?

    for installer in "${installers[@]}"; do
      local ignoreErrors=false
      if [ "${installer#@}" != "$installer" ]; then
        ignoreErrors=true
        installer="${installer#@}"
      fi
      if [ ! -f "$installer" ]; then
        __throwEnvironment "$usage" "$installer is missing" || exitCode=$?
        continue
      fi
      if [ ! -x "$installer" ]; then
        __throwEnvironment "$usage" "$installer is not executable" || exitCode=$?
        continue
      fi
      decorate info "Running installer $(decorate code "$installer") ($ignoreErrors) ..."
      __catchEnvironment "$usage" "$installer" >"$installerLog" 2>&1 || lastExit=$?
      if [ $lastExit -gt 0 ]; then
        if $ignoreErrors; then
          decorate warning "Installer $(decorate code "$installer") did not succeed [$(decorate value "$lastExit")]"
          decorate code <"$installerLog"
        else
          decorate error "Installer $(decorate code "$installer") failed [$(decorate value "$lastExit")]" 1>&2
          decorate code <"$installerLog" 1>&2
          exitCode=$lastExit || :
        fi
        printf -- "" >"$installerLog" || :
      fi
    done

    rm -f "$installerLog" || :

    if [ "$exitCode" != 0 ]; then
      # Exit before replacing script below
      return "$exitCode"
    fi
  fi
  $skipSelf || __installRemotePackageLocal "$installPath/$packageInstallerName" "$myBinary" "$relative"
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
  {
    grep -v -e '^__installPackageConfiguration ' <"$source"
    printf "%s %s \"%s\"\n" "__installPackageConfiguration" "$relTop" '$@'
  } >"$myBinary.$$"
  if ! chmod +x "$myBinary.$$"; then
    rm -rf "$myBinary.$$" || :
    _environment "chmod +x failed" || return $?
  fi
  exec "$myBinary.$$" --replace "$myBinary"
}
