#!/usr/bin/env bash
#
# Identical template
#
# Original of _installRemotePackage
#
# See: bin/build/install-bin-build.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.

# These next three functions are not used and are here simply to provide documentation.

# Used to check the remote version against the local version of a package to be installed.
# fn: packageVersionFunction
# Argument: handler - Function. Required. Function to call when an error occurs. Signature `errorHandler`.
# Argument: applicationHome - Directory. Required. Path to the application home where target will be installed, or is installed. (e.g. myApp/)
# Argument: installPath - Directory. Required. Path to the installPath home where target will be installed, or is installed. (e.g. myApp/bin/build)
# Argument: fixedVersion - EmptyString. Optional. If a fixed version is requested this is the requested version.
# `versionFunction` should exit 0 to halt the installation, in addition it should output the current version as a decorated string.
# stdout: version information
# Return Code: 0 - Do not upgrade, version is same as remote (stdout is found, current version)
# Return Code: 1 - Do upgrade, version changed. (stdout is version change details)
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
# INTERNAL:    Example:     version-function handler applicationHome installPath requestedVersion
# INTERNAL:    Argument: handler - Function. Required. Function to call when an error occurs.
# INTERNAL:    Argument: applicationHome - Directory. Required. Path to the application home where target will be installed, or is installed. (e.g. myApp/)
# INTERNAL:    Argument: installPath - Directory. Required. Path to the installPath home where target will be installed, or is installed. (e.g. myApp/bin/build)
# INTERNAL:    Argument: requestedVersion - EmptyString. Optional. Requested version to install.
# INTERNAL:
# INTERNAL: `version-function` should return 0 to halt the installation. Any other return code, installation continues normally.
# INTERNAL:
# INTERNAL: Calling signature for `url-function`:
# INTERNAL:
# INTERNAL:    Example:      url-function handler requestedVersion
# INTERNAL:    Argument: handler - Function. Required. Function to call when an error occurs.
# INTERNAL:    Argument: requestedVersion - EmptyString. Optional. Requested version to install.
# INTERNAL:
# INTERNAL: `url-function` should output a URL and exit 0. Any other return code terminates installation.
# INTERNAL:
# INTERNAL: Calling signature for `check-function`:
# INTERNAL:
# INTERNAL:    Example:      check-function handler installPath
# INTERNAL:    Argument: handler - Function. Required. Function to call when an error occurs.
# INTERNAL:    Argument: installPath - Directory. Required. Path to the installPath home where target will be installed, or is installed. (e.g. myApp/bin/build)
# INTERNAL:
# INTERNAL: If `checkFunction` fails, it should output any errors to `stderr` and return a non-zero exit code.
# INTERNAL:
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: relative - RelativePath. Required. Path from this script to our application root. INTERNAL.
# Argument: defaultPackagePath - RelativePath. Required. Path from application root to where the package should be installed. INTERNAL.
# Argument: packageInstallerName - ApplicationFile. Required. The new installer file, post installation, relative to the `installationPath`. INTERNAL.
# Argument: installationPath - ApplicationDirectory. Optional. Path to where the package should be installed instead of the defaultPackagePath.
# Argument: --help - Flag. Optional. Display this help.
# Argument: --source source - String. Optional. Source to display for the binary name. INTERNAL.
# Argument: --name name - String. Optional. Name to display for the remote package name. INTERNAL.
# Argument: --local localPackageDirectory - Directory. Optional. Directory of an existing installation to mock behavior for testing. INTERNAL.
# Argument: --url url - URL. Optional. URL of a tar.gz file. Download source code from here.
# Argument: --user username - String. Optional. Add `username:password` to remote request.
# Argument: --password passwordText - String. Optional. Add `username:password` to remote request.
# Argument: --header headerText - String. Optional. Add one or more headers to the remote request.
# Argument: --version-function urlFunction - Function. Optional. Function to compare live version to local version. Exits 0 if they match. Output version text if you want. INTERNAL.
# Argument: --version version - String. Optional. Download just **this** version of Zesk Build. Prevents stable breaking with new versions of Zesk Build.
# Argument: --url-function urlFunction - Function. Optional. Function to return the URL to download. INTERNAL.
# Argument: --check-function checkFunction - Function. Optional. Function to check the installation and output the version number or package name. INTERNAL.
# Argument: --installer installer - Executable. Optional. Multiple. Binary to run after installation succeeds. Can be supplied multiple times. If `installer` begins with a `@` then any errors by the installer are ignored.
# Argument: --replace file - File. Optional. Replace the target file with this script and delete this one. Internal only, do not use. INTERNAL.
# Argument: --finalize file - File. Optional. Remove the temporary file and exit 0. INTERNAL.
# Argument: --debug - Flag. Optional. Debugging is on. INTERNAL.
# Argument: --force - Flag. Optional. Force installation even if file is up to date.
# Argument: --skip-self - Flag. Optional. Skip the installation script self-update. (By default it is enabled.)
# Argument: --diff - Flag. Optional. Show differences between old and new file.
# Return Code: 1 - Environment error
# Return Code: 2 - Argument error
# Requires: cp rm cat printf fileRealPath executableExists returnMessage fileTemporaryName catchArgument throwArgument catchEnvironment decorate validate isFunction __decorateExtensionQuote
_installRemotePackage() {
  local handler="_${FUNCNAME[0]}"

  local relative="${1-}" defaultPackagePath="${2-}" packageInstallerName="${3-}"

  shift 3

  case "${BUILD_DEBUG-}" in 1 | true) __installRemotePackageDebug BUILD_DEBUG ;; esac

  local source="" name="${FUNCNAME[1]}"
  local localPath="" fetchArguments=() url="" urlFunction="" checkFunction="" installers=()
  local versionFunction="" fixedVersion=""
  local installPath="" installArgs=() forceFlag=false installReason="" skipSelf=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --source) shift && source=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --name) shift && name=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --mock | --local)
      [ -z "$localPath" ] || throwArgument "$handler" "$argument already" || return $?
      shift && localPath="$(catchArgument "$handler" fileRealPath "${1%/}")" || return $?
      ;;
    --user | --header | --password) shift && fetchArguments+=("$argument" "$(validate "$handler" String "$argument" "${1-}")") || return $? ;;
    --url)
      [ -z "$url" ] || throwArgument "$handler" "$argument already" || return $?
      shift && url=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    --version) shift && fixedVersion=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --version-function)
      [ -z "$versionFunction" ] || throwArgument "$handler" "$argument already" || return $?
      shift && versionFunction=$(validate "$handler" "Function" "$argument" "${1-}") || return $?
      ;;
    --url-function)
      [ -z "$urlFunction" ] || throwArgument "$handler" "$argument already" || return $?
      shift && urlFunction=$(validate "$handler" "Function" "$argument" "${1-}") || return $?
      ;;
    --check-function)
      [ -z "$checkFunction" ] || throwArgument "$handler" "$argument already" || return $?
      shift && checkFunction=$(validate "$handler" "Function" "$argument" "${1-}") || return $?
      ;;
    --installer) shift && installers+=("$(validate "$handler" String "$argument" "${1-}")") || return $? ;;
    # I believe this ensures that the process running does not modify its source script directly
    #
    # 1. Copy new script to bin/install.sample.sh.$$
    # 2. Run exec bin/install.sample.sh.$$ --replace bin/install.sample.sh
    # 3. Memory reloaded with "new" version of script
    # 4. New version copies itself (.sh.$$) to old installer (.sh version), and runs
    # 4. exec bin/install.sample.sh --finalize bin/install.sample.sh.$$
    # 5. Loads NEW version of script, and then deletes `bin/install.sample.sh.$$` and exits
    #
    # But I could be wrong.
    --replace)
      local newName
      shift
      newName=$(validate "$handler" String "$argument" "${1-}") || return $?
      decorate BOLD blue "Updating -> $(decorate BOLD orange "$newName")"
      catchEnvironment "$handler" cp -f "${BASH_SOURCE[0]}" "$newName" || return $?
      catchEnvironment "$handler" chmod +x "$newName" || return $?
      exec "$newName" --finalize "${BASH_SOURCE[0]}" || return $?
      return 0
      ;;
    --finalize)
      local oldName
      shift
      oldName=$(validate "$handler" String "$argument" "${1-}") || return $?
      catchEnvironment "$handler" rm -rf "$oldName" || return $?
      return 0
      ;;
    --debug)
      __installRemotePackageDebug "$argument"
      ;;
    --skip-self) skipSelf=true ;;
    --force) forceFlag=true && installReason="--force specified" ;;
    --diff) installArgs+=("$argument") ;;
    *) installPath=$(validate "$handler" String "installPath" "$1") || return $? ;;
    esac
    shift
  done

  local installFlag=false
  local myBinary myPath applicationHome installPath packagePath
  # Move to starting point
  myBinary=$(catchEnvironment "$handler" fileRealPath "${BASH_SOURCE[0]}") || return $?
  myPath="${myBinary%/*}" || return $?
  applicationHome=$(catchEnvironment "$handler" fileRealPath "$myPath/$relative") || return $?
  applicationHome="${applicationHome%/}"
  [ -n "$installPath" ] || installPath="$applicationHome/$defaultPackagePath"
  installPath="${installPath%/}"
  packagePath="${installPath#"$applicationHome"}"
  packagePath="${packagePath#/}"

  catchEnvironment "$handler" pushd "$applicationHome" || return $?
  if [ -z "$url" ]; then
    if [ -n "$urlFunction" ]; then
      url=$(catchEnvironment "$handler" "$urlFunction" "$handler" "$fixedVersion") || return $?
      if [ -z "$url" ]; then
        throwArgument "$handler" "$urlFunction $fixedVersion failed" || return $?
      fi
    fi
  fi
  if [ -z "$url" ] && [ -z "$localPath" ]; then
    throwArgument "$handler" "--local or --url|--url-function is required" || return $?
  fi

  if [ ! -d "$installPath" ]; then
    [ -n "$installReason" ] || installReason="not installed"
    if $forceFlag; then
      printf "%s (%s)\n" "$(decorate orange "Forcing installation")" "$(decorate blue "$installReason")"
    fi
    installFlag=true
  elif ! $forceFlag && [ -n "$versionFunction" ]; then
    local newVersion=""
    if newVersion=$("$versionFunction" "$handler" "$applicationHome" "$packagePath" "$fixedVersion"); then
      printf "%s %s %s\n" "$(decorate value "$name")" "$(decorate info "Newest version installed")" "$newVersion"
      __installRemotePackageGitCheck "$applicationHome" "$packagePath" || :
      return 0
    fi
    forceFlag=true
    [ -z "$fixedVersion" ] && installReason="newer version available: $newVersion" || installReason="fixed version available: $newVersion"
  fi
  if $forceFlag; then
    [ -n "$installReason" ] || installReason="directory exists"
    printf "%s (%s)\n" "$(decorate orange "Forcing installation")" "$(decorate BOLD blue "$installReason")"
    installFlag=true
  fi
  binName="$(basename "$myBinary")"
  if [ "$binName" = "main" ]; then
    skipSelf=true
    binName=" ($(decorate BOLD orange "bash pipe"))"
  else
    binName=" ($(decorate BOLD blue "$(basename "$myBinary")"))"
  fi
  local suffix
  if $installFlag; then
    local start
    start=$(($(catchEnvironment "$handler" date +%s) + 0)) || return $?
    __installRemotePackageDirectory "$handler" "$packagePath" "$applicationHome" "$url" "$localPath" "${fetchArguments[@]+"${fetchArguments[@]}"}" || return $?
    [ -d "$packagePath" ] || throwEnvironment "$handler" "Unable to download and install $packagePath (not a directory, still)" || return $?
    suffix="in $(($(date +%s) - start)) seconds$binName"
  else
    suffix="already installed"
  fi
  local messageFile
  messageFile=$(fileTemporaryName "$handler") || return $?
  if [ -n "$checkFunction" ]; then
    "$checkFunction" "$handler" "$packagePath" >"$messageFile" 2>&1 || return $?
  else
    catchEnvironment "$handler" printf -- "%s\n" "$packagePath" >"$messageFile" || return $?
  fi
  local message
  message="Installed $(cat "$messageFile") $suffix"
  catchEnvironment "$handler" rm -f "$messageFile" || return $?
  __installRemotePackageGitCheck "$applicationHome" "$packagePath" || :
  message="$message (local)$binName"
  printf -- "%s\n" "$message"

  local exitCode=0

  if [ "${#installers[@]}" -gt 0 ]; then
    local installer lastExit=0 installerLog

    installerLog=$(fileTemporaryName "$handler") || return $?

    for installer in "${installers[@]}"; do
      local ignoreErrors=false
      if [ "${installer#@}" != "$installer" ]; then
        ignoreErrors=true
        installer="${installer#@}"
      fi
      if [ ! -f "$installer" ]; then
        throwEnvironment "$handler" "$installer is missing" || exitCode=$?
        continue
      fi
      if [ ! -x "$installer" ]; then
        throwEnvironment "$handler" "$installer is not executable" || exitCode=$?
        continue
      fi
      decorate info "Running installer $(decorate code "$installer") ($ignoreErrors) ..."
      catchEnvironment "$handler" "$installer" >"$installerLog" 2>&1 || lastExit=$?
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
# Argument: returnCode - UnsignedInteger. Required. Exit code.
# Argument: message ... - EmptyString. Optional. Error message to show.
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
# Requires: catchReturn catchEnvironment throwEnvironment urlFetch
__installRemotePackageDirectory() {
  local handler="$1" packagePath="$2" applicationHome="$3" url="$4" localPath="$5"
  local start tarArgs osName
  local target="$applicationHome/.$$.package.tar.gz"

  shift 5
  if [ -n "$localPath" ]; then
    __installRemotePackageDirectoryLocal "$handler" "$packagePath" "$applicationHome" "$localPath"
    return $?
  fi
  catchReturn "$handler" urlFetch "$url" "$target" || return $?
  [ -f "$target" ] || throwEnvironment "$handler" "$target does not exist after download from $url" || return $?
  packagePath=${packagePath%/}
  packagePath=${packagePath#/}
  if ! osName="$(uname)" || [ "$osName" != "Darwin" ]; then
    tarArgs=(--wildcards "*/$packagePath/*")
  else
    tarArgs=(--include="*$packagePath/*")
  fi
  catchEnvironment "$handler" pushd "$(dirname "$target")" >/dev/null || return $?
  catchEnvironment "$handler" rm -rf "$packagePath" || return $?
  catchEnvironment "$handler" tar xf "$target" --strip-components=1 "${tarArgs[@]}" || return $?
  catchEnvironment "$handler" popd >/dev/null || return $?
  rm -f "$target" || :
}

# Install the build directory from a copy
# Requires: rm mv cp mkdir
# Requires: returnUndo catchEnvironment throwEnvironment
__installRemotePackageDirectoryLocal() {
  local handler="$1" packagePath="$2" applicationHome="$3" localPath="$4" installPath tempPath

  installPath="${applicationHome%/}/${packagePath#/}"
  # Clean target regardless
  if [ -d "$installPath" ]; then
    tempPath="$installPath.aboutToDelete.$$"
    catchEnvironment "$handler" rm -rf "$tempPath" || return $?
    catchEnvironment "$handler" mv -f "$installPath" "$tempPath" || return $?
    catchEnvironment "$handler" cp -r "$localPath" "$installPath" || returnUndo $? rf -f "$installPath" -- mv -f "$tempPath" "$installPath" || return $?
    catchEnvironment "$handler" rm -rf "$tempPath" || :
  else
    tempPath=$(catchEnvironment "$handler" dirname "$installPath") || return $?
    [ -d "$tempPath" ] || catchEnvironment "$handler" mkdir -p "$tempPath" || return $?
    catchEnvironment "$handler" cp -r "$localPath" "$installPath" || return $?
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
      "$(decorate code "printf \"%s\n\" \"$pattern/\" >> \"$ignoreFile\"")"
  fi
}

# Argument: source - File. New source installer to customize.
# Argument: targetBinary - File. Target installer to update.
# Argument: relativePath - RelativePath. Path to the top of the project for the installer.
# Assumes our source handles the `--replace` argument to replace itself.
# Requires: grep printf chmod wait
# Requires: returnEnvironment isUnsignedInteger cat returnClean
__installRemotePackageLocal() {
  local source="$1" myBinary="$2" relTop="$3"
  {
    grep -v -e '^__installPackageConfiguration ' <"$source"
    printf "%s %s \"%s\"\n" "__installPackageConfiguration" "$relTop" '$@'
  } >"$myBinary.$$"
  if ! chmod +x "$myBinary.$$"; then
    rm -rf "$myBinary.$$" || :
    returnEnvironment "chmod +x failed" || return $?
  fi
  exec "$myBinary.$$" --replace "$myBinary"
}

# <-- END of IDENTICAL _installRemotePackage
