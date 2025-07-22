#!/usr/bin/env bash
#
# Copy this into your project and customize for your own installer process.
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Debugging: 73b0bd4ba49583263542da725669003fc821eb63

__installPackageConfiguration() {
  local rel="$1"
  shift
  _installRemotePackage "$rel" "{APPLICATION_RELATIVE_PATH}" "${BASH_SOURCE[0]##*/}" --version-function __installFetchVersion --url-function __installURL --check-function _installCheck --name "Zesk Build" "$@"
}

# URL of latest release
__installLatestVersion() {
  printf -- "%s\n" "https://localhost/latest.json"
}
__installLatestURL() {
  printf -- "%s\n" "https://localhost/latest.tar.gz"
}

# Download remote JSON as a temporary file (delete it)
# Requires: whichExists __throwEnvironment fileTemporaryName __installLatestVersion curl urlFetch printf
__installJSON() {
  local usage="$1" jsonFile message

  whichExists jq || __throwEnvironment "$usage" "Requires jq to install" || return $?
  jsonFile=$(fileTemporaryName "$usage") || return $?
  if ! urlFetch "$(__installLatestVersion)" "$jsonFile"; then
    message="$(printf -- "%s\n%s\n" "Unable to fetch latest JSON:" "$(cat "$jsonFile")")"
    rm -rf "$jsonFile" || :
    __throwEnvironment "$usage" "$message" || return $?
  fi
  printf "%s\n" "$jsonFile"
}

# Requires: __installJSON rm __throwArgument printf
__installURL() {
  local usage="$1" jsonFile

  jsonFile=$(__installJSON "$usage") || return $?
  url=$(__installLatestURL "$usage" "$jsonFile") || return $?
  rm -f "$jsonFile" || :
  [ "${url#https://}" != "$url" ] || __throwArgument "$usage" "URL must begin with https://" || return $?
  printf -- "%s\n" "$url"
}

# Used to check the remote version against the local version of a package to be installed.
# fn: packageVersionFunction
# Argument: handler - Function. Required. Function to call when an error occurs. Signature `errorHandler`.
# Argument: applicationHome - Directory. Required. Path to the application home where target will be installed, or is installed. (e.g. myApp/)
# Argument: installPath - Directory. Required. Path to the installPath home where target will be installed, or is installed. (e.g. myApp/bin/build)
# Exit Code: 0 - Do not upgrade, version is same as remote (stdout is found, current version)
# Exit Code: 1 - Do upgrade, version changed. (stdout is version change details)
# See: _installRemotePackage
# Requires: __installJSON jsonField jq versionSort decorate __installLatestVersion __throwArgument
__installFetchVersion() {
  local usage="$1" installPath="$2" packagePath="$3" jsonFile version url upIcon="☝️" okIcon="👌"

  whichExists jq || __throwEnvironment "$usage" "Requires jq to install" || return $?
  jsonFile=$(fileTemporaryName "$usage") || return $?

  if ! urlFetch "$(__installLatestVersion)" "$jsonFile"; then
    local message
    message="$(printf -- "%s\n%s\n" "Unable to fetch version JSON:" "$(cat "$jsonFile")")"
    rm -f "$jsonFile" || :
    __throwEnvironment "$usage" "$message" || return $?
  fi

  # Version comparison
  version=$(jsonField "$usage" "$jsonFile" .version) || returnClean $? "$jsonFile" || return $?
  rm -f "$jsonFile" || :
  if [ -d "$packagePath" ] && [ -f "$packagePath/package.json" ]; then
    local latest
    myVersion=$(jq -r .version <"$packagePath/package.json")
    # shellcheck disable=SC2119
    latest=$(printf "%s\n" "$myVersion" "$version" | versionSort | tail -n 1)
    if [ "$myVersion" = "$latest" ]; then
      printf -- "%s %s" "$okIcon" "$(decorate info "$version")"
      return 0
    fi
    printf -- "%s %s️ %s" "$(decorate error "$myVersion")" "$upIcon" "$(decorate success "$version")"
  fi
  return 1
}

# Check the install directory after installation and output the version
# Requires: __installCheck
_installCheck() {
  __installCheck "zesk/build" "build.json" "$@"
}

# _IDENTICAL_ jsonField 29

# Fetch a non-blank field from a JSON file with error handling
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: handler - Function. Required. Error handler.
# Argument: jsonFile - File. Required. A JSON file to parse
# Argument: ... - Arguments. Optional. Passed directly to jq
# stdout: selected field
# stderr: error messages
# Exit Code: 0 - Field was found and was non-blank
# Exit Code: 1 - Field was not found or is blank
# Requires: jq whichExists __throwEnvironment printf rm decorate head
jsonField() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local handler="$1" jsonFile="$2" value message && shift 2

  [ -f "$jsonFile" ] || __throwEnvironment "$handler" "$jsonFile is not a file" || return $?
  whichExists jq || __throwEnvironment "$handler" "Requires jq - not installed" || return $?
  if ! value=$(jq -r "$@" <"$jsonFile"); then
    message="$(printf -- "%s\n%s\n" "Unable to fetch selector $(decorate each code "$@") from JSON:" "$(head -n 100 "$jsonFile")")"
    __throwEnvironment "$handler" "$message" || return $?
  fi
  [ -n "$value" ] || __throwEnvironment "$handler" "$(printf -- "%s\n%s\n" "Selector $(decorate each code "$@") was blank from JSON:" "$(head -n 100 "$jsonFile")")" || return $?
  printf -- "%s\n" "$value"
}
_jsonField() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL __installCheck 20

# Check the directory after an installation and output the version and ID from a file
#
# Argument: name - String. Required. Installed name.
# Argument: versionFile - RelativeFile. Required. Relative path to version file, containing `.id` and `.version` jq selectors.
# Argument: usageFunction - Function. Required. Call this on failure.
# Argument: installPath - Directory. Required. Path to check for installation.
# Argument: versionSelector - String. Optional. Selector to use to extract version from the file.
# Argument: idSelector - String. Optional. Selector to use to extract version from the file.
# Requires: dirname jq decorate printf __throwEnvironment read jq
__installCheck() {
  local name="$1" version="$2" usage="$3" installPath="$4" versionSelector="${5-".version"}" idSelector="${6-".id"}"
  local versionFile="$installPath/$version" id
  if [ ! -f "$versionFile" ]; then
    __throwEnvironment "$usage" "$(printf "%s: %s\n\n  %s\n  %s\n" "$(decorate error "$name")" "Incorrect version or broken install (can't find $version):" "rm -rf $(dirname "$installPath/$version")" "${BASH_SOURCE[0]}")" || return $?
  fi
  read -r version id < <(jq -r "($versionSelector + \" \" + $idSelector)" <"$versionFile" || :) || :
  [ -n "$version" ] && [ -n "$id" ] || __throwEnvironment "$usage" "$versionFile missing version: \"$version\" or id: \"$id\"" || return $?
  printf "%s %s (%s)\n" "$(decorate bold-blue "$name")" "$(decorate code "$version")" "$(decorate orange "$id")"
}

# IDENTICAL _installRemotePackage 399

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
# Requires: cp rm cat printf realPath whichExists _return fileTemporaryName __catchArgument __throwArgument __catchEnvironment decorate usageArgumentString isFunction __decorateExtensionQuote
_installRemotePackage() {
  local handler="_${FUNCNAME[0]}"

  local relative="${1-}" defaultPackagePath="${2-}" packageInstallerName="${3-}"

  shift 3

  case "${BUILD_DEBUG-}" in 1 | true) __installRemotePackageDebug BUILD_DEBUG ;; esac

  local source="" name="${FUNCNAME[1]}"
  local localPath="" fetchArguments=() url="" versionFunction="" urlFunction="" checkFunction="" installers=()
  local installPath="" installArgs=() forceFlag=false installReason="" skipSelf=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ argumentBlankCheck 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --source)
      shift
      source=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --name)
      shift
      name=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --mock | --local)
      [ -z "$localPath" ] || __throwArgument "$handler" "$argument already" || return $?
      shift
      [ -n "${1-}" ] || __throwArgument "$handler" "$argument blank argument #$__index" || return $?
      localPath="$(__catchArgument "$handler" realPath "${1%/}")" || return $?
      ;;
    --user | --header | --password)
      shift
      fetchArguments+=("$argument" "$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    --url)
      shift
      [ -z "$url" ] || __throwArgument "$handler" "$argument already" || return $?
      [ -n "${1-}" ] || __throwArgument "$handler" "$argument blank argument" || return $?
      url="$1"
      ;;
    --version-function)
      shift
      [ -z "$versionFunction" ] || __throwArgument "$handler" "$argument already" || return $?
      isFunction "${1-}" || __throwArgument "$handler" "$argument not callable: ${1-}" || return $?
      versionFunction="$1"
      ;;
    --url-function)
      shift
      [ -z "$urlFunction" ] || __throwArgument "$handler" "$argument already" || return $?
      isFunction "${1-}" || __throwArgument "$handler" "$argument not callable: ${1-}" || return $?
      urlFunction="$1"
      ;;
    --check-function)
      shift
      [ -z "$checkFunction" ] || __throwArgument "$handler" "$argument already" || return $?
      isFunction "${1-}" || __throwArgument "$handler" "$argument not callable: ${1-}" || return $?
      checkFunction="$1"
      ;;
    --installer)
      shift
      installers+=("$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    #
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
    #
    --replace)
      local newName
      shift
      newName=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      decorate bold-blue "Updating -> $(decorate bold-orange "$newName")"
      __catchEnvironment "$handler" cp -f "${BASH_SOURCE[0]}" "$newName" || return $?
      __catchEnvironment "$handler" chmod +x "$newName" || return $?
      exec "$newName" --finalize "${BASH_SOURCE[0]}" || return $?
      return 0
      ;;
    --finalize)
      local oldName
      shift
      oldName=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      __catchEnvironment "$handler" rm -rf "$oldName" || return $?
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
      installPath=$(usageArgumentString "$handler" "installPath" "$1") || return $?
      installPath="${installPath%/}"
      ;;
    esac
    shift
  done

  local installFlag=false
  local myBinary myPath applicationHome installPath packagePath
  # Move to starting point
  myBinary=$(__catchEnvironment "$handler" realPath "${BASH_SOURCE[0]}") || return $?
  myPath="${myBinary%/*}" || return $?
  applicationHome=$(__catchEnvironment "$handler" realPath "$myPath/$relative") || return $?
  applicationHome="${applicationHome%/}"
  [ -n "$installPath" ] || installPath="$applicationHome/$defaultPackagePath"
  packagePath="${installPath#"$applicationHome"}"
  packagePath="${packagePath#/}"

  __catchEnvironment "$handler" pushd "$applicationHome" || return $?
  if [ -z "$url" ]; then
    if [ -n "$urlFunction" ]; then
      url=$(__catchEnvironment "$handler" "$urlFunction" "$handler") || return $?
      if [ -z "$url" ]; then
        __throwArgument "$handler" "$urlFunction failed" || return $?
      fi
    fi
  fi
  if [ -z "$url" ] && [ -z "$localPath" ]; then
    __throwArgument "$handler" "--local or --url|--url-function is required" || return $?
  fi

  if [ ! -d "$installPath" ]; then
    [ -n "$installReason" ] || installReason="not installed"
    if $forceFlag; then
      printf "%s (%s)\n" "$(decorate orange "Forcing installation")" "$(decorate blue "$installReason")"
    fi
    installFlag=true
  elif ! $forceFlag && [ -n "$versionFunction" ]; then
    local newVersion=""
    if newVersion=$("$versionFunction" "$handler" "$applicationHome" "$packagePath"); then
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
    start=$(($(__catchEnvironment "$handler" date +%s) + 0)) || return $?
    __installRemotePackageDirectory "$handler" "$packagePath" "$applicationHome" "$url" "$localPath" "${fetchArguments[@]+"${fetchArguments[@]}"}" || return $?
    [ -d "$packagePath" ] || __throwEnvironment "$handler" "Unable to download and install $packagePath (not a directory, still)" || return $?
    message="Installed "
    suffix="in $(($(date +%s) - start)) seconds$binName"
  else
    message=""
    suffix="already installed"
  fi
  local messageFile
  messageFile=$(fileTemporaryName "$handler") || return $?
  if [ -n "$checkFunction" ]; then
    "$checkFunction" "$handler" "$packagePath" >"$messageFile" 2>&1 || return $?
  else
    __catchEnvironment "$handler" printf -- "%s\n" "$packagePath" >"$messageFile" || return $?
  fi
  message="${message}Installed $(cat "$messageFile") $suffix"
  __catchEnvironment "$handler" rm -f "$messageFile" || return $?
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
        __throwEnvironment "$handler" "$installer is missing" || exitCode=$?
        continue
      fi
      if [ ! -x "$installer" ]; then
        __throwEnvironment "$handler" "$installer is not executable" || exitCode=$?
        continue
      fi
      decorate info "Running installer $(decorate code "$installer") ($ignoreErrors) ..."
      __catchEnvironment "$handler" "$installer" >"$installerLog" 2>&1 || lastExit=$?
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
  local handler="$1" packagePath="$2" applicationHome="$3" url="$4" localPath="$5"
  local start tarArgs osName
  local target="$applicationHome/.$$.package.tar.gz"

  shift 5
  if [ -n "$localPath" ]; then
    __installRemotePackageDirectoryLocal "$handler" "$packagePath" "$applicationHome" "$localPath"
    return $?
  fi
  __catchEnvironment "$handler" urlFetch "$url" "$target" || return $?
  [ -f "$target" ] || __throwEnvironment "$handler" "$target does not exist after download from $url" || return $?
  packagePath=${packagePath%/}
  packagePath=${packagePath#/}
  if ! osName="$(uname)" || [ "$osName" != "Darwin" ]; then
    tarArgs=(--wildcards "*/$packagePath/*")
  else
    tarArgs=(--include="*$packagePath/*")
  fi
  __catchEnvironment "$handler" pushd "$(dirname "$target")" >/dev/null || return $?
  __catchEnvironment "$handler" rm -rf "$packagePath" || return $?
  __catchEnvironment "$handler" tar xf "$target" --strip-components=1 "${tarArgs[@]}" || return $?
  __catchEnvironment "$handler" popd >/dev/null || return $?
  rm -f "$target" || :
}

# Install the build directory from a copy
# Requires: rm mv cp mkdir
# Requires: returnUndo __catchEnvironment __throwEnvironment
__installRemotePackageDirectoryLocal() {
  local handler="$1" packagePath="$2" applicationHome="$3" localPath="$4" installPath tempPath

  installPath="${applicationHome%/}/${packagePath#/}"
  # Clean target regardless
  if [ -d "$installPath" ]; then
    tempPath="$installPath.aboutToDelete.$$"
    __catchEnvironment "$handler" rm -rf "$tempPath" || return $?
    __catchEnvironment "$handler" mv -f "$installPath" "$tempPath" || return $?
    __catchEnvironment "$handler" cp -r "$localPath" "$installPath" || returnUndo $? rf -f "$installPath" -- mv -f "$tempPath" "$installPath" || return $?
    __catchEnvironment "$handler" rm -rf "$tempPath" || :
  else
    tempPath=$(__catchEnvironment "$handler" dirname "$installPath") || return $?
    [ -d "$tempPath" ] || __catchEnvironment "$handler" mkdir -p "$tempPath" || return $?
    __catchEnvironment "$handler" cp -r "$localPath" "$installPath" || return $?
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

# <-- END of IDENTICAL _installRemotePackage
# IDENTICAL versionSort 48

# Summary: Sort versions in the format v0.0.0
#
# Sorts semantic versions prefixed with a `v` character; intended to be used as a pipe.
#
# vXXX.XXX.XXX
#
# for sort - -k 1.c,1 - the `c` is the 1-based character index, so 2 means skip the 1st character
#
# Odd you can't globally flip sort order with -r - that only works with non-keyed entries I assume
#
# Argument: -r | --reverse - Reverse the sort order (optional)
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Example:    git tag | grep -e '^v[0-9.]*$' | versionSort
# Requires: __throwArgument sort usageDocument
versionSort() {
  local handler="_${FUNCNAME[0]}"

  local reverse=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ argumentBlankCheck 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    -r | --reverse)
      reverse="r"
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done
  sort -t . -k "1.2,1n$reverse" -k "2,2n$reverse" -k "3,3n$reverse"
}
_versionSort() {
  # Fix SC2120
  ! false || versionSort --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL usageArgumentCore 13

# Require an argument to be non-blank
# Argument: handler - Required. Function. Usage function to call upon failure.
# Argument: argument - Required. String. Name of the argument used in error messages.
# Argument: value - Optional. String, Value which should be non-blank otherwise an argument error is thrown.
# Exit Code: 2 - If `value` is blank
# Exit code: 0 - If `value` is non-blank
usageArgumentString() {
  local handler="$1" argument="$2"
  shift 2 || :
  [ -n "${1-}" ] || __throwArgument "$handler" "blank" "$argument" || return $?
  printf "%s\n" "$1"
}

# IDENTICAL urlFetch 125

# Fetch URL content
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --header header - String. Optional. Send a header in the format 'Name: Value'
# Argument: --wget - Flag. Optional. Force use of wget. If unavailable, fail.
# Argument: --curl - Flag. Optional. Force use of curl. If unavailable, fail.
# Argument: --binary binaryName - Callable. Use this binary instead. If the base name of the file is not `curl` or `wget` you MUST supply `--argument-format`.
# Argument: --argument-format format - Optional. String. Supply `curl` or `wget` for parameter formatting.
# Argument: --user userName - Optional. String. If supplied, uses HTTP Simple authentication. Usually used with `--password`. Note: User names may not contain the character `:` when using `curl`.
# Argument: --password password - Optional. String. If supplied along with `--user`, uses HTTP Simple authentication.
# Argument: url - Required. URL. URL to fetch to target file.
# Argument: file - Required. FileDirectory. Target file.
# Requires: _return whichExists printf decorate
# Requires: usageArgumentString
# Requires: __throwArgument __catchArgument
# Requires: __throwEnvironment __catchEnvironment
urlFetch() {
  local handler="_${FUNCNAME[0]}"

  local wgetArgs=() curlArgs=() headers wgetExists binary="" userHasColons=false user="" password="" format="" url="" target=""

  wgetExists=$(whichExists wget && printf true || printf false)

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ argumentBlankCheck 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --header)
      shift
      local name value
      name="${1%%:}"
      value="${1#*:}"
      if [ "$name" = "$1" ] || [ "$value" = "$1" ]; then
        __catchArgument "$handler" "Invalid $argument $1 passed" || return $?
      fi
      headers+=("$1")
      curlArgs+=("--header" "$1")
      wgetArgs+=("--header=$1")
      ;;
    --wget)
      binary="wget"
      ;;
    --curl)
      binary="curl"
      ;;
    --binary)
      shift
      binary=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      whichExists "$binary" || __throwArgument "$handler" "$binary must be in PATH: $PATH" || return $?
      ;;
    --argument-format)
      format=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      case "$format" in curl | wget) ;; *) __throwArgument "$handler" "$argument must be curl or wget" || return $? ;; esac
      ;;
    --password)
      shift
      password="$1"
      ;;
    --user)
      shift
      user=$(usageArgumentString "$handler" "$argument (user)" "$user") || return $?
      if [ "$user" != "${user#*:}" ]; then
        userHasColons=true
      fi
      curlArgs+=(--user "$user:$password")
      wgetArgs+=("--http-user=$user" "--http-password=$password")
      genericArgs+=("$argument" "$1")
      ;;
    --agent)
      shift
      local agent="$1"
      [ -n "$agent" ] || __throwArgument "$handler" "$argument must be non-blank" || return $?
      wgetArgs+=("--user-agent=$1")
      curlArgs+=("--user-agent" "$1")
      genericArgs+=("$argument" "$1")
      ;;
    *)
      if [ -z "$url" ]; then
        url="$1"
      elif [ -z "$target" ]; then
        target="$1"
        shift
        break
      else
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  if [ -n "$user" ]; then
    curlArgs+=(--user "$user:$password")
    wgetArgs+=("--http-user=$user" "--http-password=$password")
    genericArgs+=("--user" "$user" "--password" "$password")
  fi
  if [ "$binary" = "curl" ] && $userHasColons; then
    __throwArgument "$handler" "$argument: Users ($argument \"$(decorate code "$user")\") with colons are not supported by curl, use wget" || return $?
  fi
  if [ -z "$binary" ]; then
    if $wgetExists; then
      binary="wget"
    elif whichExists "curl"; then
      binary="curl"
    fi
  fi
  [ -n "$binary" ] || __throwEnvironment "$handler" "wget or curl required" || return $?
  [ -n "$format" ] || format="$binary"
  case "$format" in
  wget) __catchEnvironment "$handler" "$binary" -q --output-document="$target" --timeout=10 "${wgetArgs[@]+"${wgetArgs[@]}"}" "$url" "$@" || return $? ;;
  curl) __catchEnvironment "$handler" "$binary" -L -s "$url" "$@" -o "$target" "${curlArgs[@]+"${curlArgs[@]}"}" || return $? ;;
  *) __throwEnvironment "$handler" "No handler for binary format $(decorate value "$format") (binary is $(decorate code "$binary")) $(decorate each value "${genericArgs[@]}")" || return $? ;;
  esac
}
_urlFetch() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL __help 55

# Simple help argument handler.
#
# Easy `--help` handler for any function useful when it's the only option.
#
# Useful for utilities which single argument types, single arguments, and no arguments (except for `--help`)
#
# Oddly one of the few functions we can not offer the `--help` flag for.
# DOC TEMPLATE: noArgumentsForHelp 1
# Without arguments, displays help.
# Argument: --only - Flag. Optional. Must be first parameter. If calling function ONLY takes the `--help` parameter then throw an argument error if the argument is anything but `--help`.
# Argument: usageFunction - Function. Required. Must be first or second parameter. If calling function ONLY takes the `--help` parameter then throw an argument error if the argument is anything but `--help`.
# Argument: arguments ... - Arguments. Optional. Arguments passed to calling function to check for `--help` argument.
#
# Example:     # NOT DEFINED usage local usage="_${FUNCNAME[0]}"
# Example:
# Example:     __help "_${FUNCNAME[0]}" "$@" || return 0
# Example:     [ "$1" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
# Example:     [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
# Example:     [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
# Example:
# Example:     # DEFINED usage
# Example:
# Example:     local usage="_${FUNCNAME[0]}"
# Example:     __help "$usage" "$@" || return 0
# Example:     [ "$1" != "--help" ] || __help "$usage" "$@" || return 0
# Example:     [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0
# Example:     [ $# -eq 0 ] || __help --only "$usage" "$@" || return "$(convertValue $? 1 0)"
# Example:
# Example:     # Blank Arguments for help
# Example:     [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
# Example:     [ $# -gt 0 ] || __help "$usage" --help || return 0
#
# DEPRECATED-Example: [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return $?
# DEPRECATED-Example: [ $# -eq 0 ] || __help --only "$usage" "$@" || return $?
#
# Requires: __throwArgument usageDocument ___help
__help() {
  [ $# -gt 0 ] || ! ___help 0 || return 0
  local handler="${1-}" && shift
  if [ "$handler" = "--only" ]; then
    handler="${1-}" && shift
    [ $# -gt 0 ] || return 0
    [ "$#" -eq 1 ] && [ "${1-}" = "--help" ] || __throwArgument "$handler" "Only argument allowed is --help: \"${1-}\"" || return $?
  fi
  while [ $# -gt 0 ]; do
    [ "$1" != "--help" ] || ! "$handler" 0 || return 1
    shift
  done
  return 0
}
___help() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

usageDocument() {
  usageDocumentSimple "$@"
}

# IDENTICAL usageDocumentSimple 33

# Output a simple error message for a function
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: source - File. Required. File where documentation exists.
# Argument: function - String. Required. Function to document.
# Argument: returnCode - UnsignedInteger. Required. Exit code to return.
# Argument: message ... - Optional. String. Message to display to the user.
# Requires: bashFunctionComment decorate read printf exitString __help usageDocument
usageDocumentSimple() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local source="${1-}" functionName="${2-}" returnCode="${3-}" color helpColor="info" icon="❌" line prefix="" done=false skip=false && shift 3

  case "$returnCode" in 0) icon="🏆" && color="info" && [ $# -ne 0 ] || skip=true ;; 1) color="error" ;; 2) color="bold-red" ;; *) color="orange" ;; esac
  [ "$returnCode" -eq 0 ] || exec 1>&2
  $skip || printf -- "%s [%s] %s\n" "$icon" "$(decorate "code" "$(exitString "$returnCode")")" "$(decorate "$color" "$*")"
  if [ ! -f "$source" ]; then
    export BUILD_HOME
    [ -d "${BUILD_HOME-}" ] || _argument "Unable to locate $source (${PWD-})" || return $?
    source="$BUILD_HOME/$source"
    [ -f "$source" ] || _argument "Unable to locate $source (${PWD-})" || return $?
  fi
  while ! $done; do
    IFS='' read -r line || done=true
    printf "%s%s\n" "$prefix" "$(decorate "$helpColor" "$line")"
    prefix=""
  done < <(bashFunctionComment "$source" "$functionName" | sed "s/{fn}/$functionName/g")
  return "$returnCode"
}
_usageDocumentSimple() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL bashFunctionComment 29

# Extract a bash comment from a file. Excludes lines containing the following tokens:
#
# - `" IDENTICAL "` or `"_IDENTICAL_"`
# - `"Internal:"` or `"INTERNAL:"`
# - `"DOC TEMPLATE:"`
#
# Argument: source - File. Required. File where the function is defined.
# Argument: functionName - String. Required. The name of the bash function to extract the documentation for.
# Requires: grep cut fileReverseLines __help
# Requires: usageDocument
bashFunctionComment() {
  local source="${1-}" functionName="${2-}"
  local maxLines=1000
  __help "_${FUNCNAME[0]}" "$@" || return 0
  grep -m 1 -B $maxLines "^$functionName() {" "$source" | grep -v -e '\( IDENTICAL \|_IDENTICAL_\|DOC TEMPLATE:\|Internal:\|INTERNAL:\)' | fileReverseLines | sed -n -e '1d' -e '/^#/!q; p' | fileReverseLines | cut -c 3-
  # Explained:
  # - grep -m 1 ... - Finds the `function() {` string in the file and all lines afterwards
  # - grep -v ... - Removes internal documentation and anything we want to hide from the user
  # - fileReverseLines - First reversal to get that comment, file lines are reverse ordered
  # - sed 1d - Deletes the first line (e.g. the `function() { ` which was the LAST thing in the line and is now our first line
  # - sed -n '/^#/!q; p' - `-n` - disables automatic printing. /^#/!q quits when it does not match a '#' comment and prints all `#` lines (effectively outputting just the comment lines)
  # - fileReverseLines - File is back to normal
  # - cut -c 3- - Delete the first 2 characters on each line
}
_bashFunctionComment() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL fileReverseLines 18

# Reverses a pipe's input lines to output using an awk trick.
#
# Not recommended on big files.
#
# Summary: Reverse output lines
# Source: https://web.archive.org/web/20090208232311/http://student.northpark.edu/pemente/awk/awk1line.txt
# Credits: Eric Pement
# Depends: awk
fileReverseLines() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }'
}
_fileReverseLines() {
  true || fileReverseLines --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL _realPath 20

# Find the full, actual path of a file avoiding symlinks or redirection.
# See: readlink realpath
# DOC TEMPLATE: noArgumentsForHelp 1
# Without arguments, displays help.
# Argument: file ... - Required. File. One or more files to `realpath`.
# Requires: whichExists realpath __help usageDocument _argument
realPath() {
  # __IDENTICAL__ --help-when-blank 1
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  if whichExists realpath; then
    realpath "$@"
  else
    readlink -f -n "$@"
  fi
}
_realPath() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL fileTemporaryName 19

# Generate a temporary file name using mktemp, and fail using a function
# Argument: handler - Function. Required. Function to call if mktemp fails. Function Type: _return
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: ... - Optional. Arguments. Any additional arguments are passed through to mktemp.
# Requires: __help __catchEnvironment mktemp usageDocument
fileTemporaryName() {
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "$@" || return 0
  handler="$1" && shift
  __catchEnvironment "$handler" mktemp "$@" || return $?
}
_fileTemporaryName() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# <-- END of IDENTICAL fileTemporaryName

# IDENTICAL whichExists 25

# Summary: Does a binary exist in the PATH?
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: binary ... - Required. String. One or more Binaries to find in the system `PATH`.
# Exit code: 0 - If all values are found
# Exit code: 1 - If any value is not found
# Requires: __throwArgument which decorate __decorateExtensionEach
whichExists() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local __saved=("$@") __count=$#
  [ $# -gt 0 ] || __throwArgument "$handler" "no arguments" || return $?
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ argumentBlankCheck 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    which "$1" >/dev/null || return 1
    shift
  done
}
_whichExists() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL _type 41

# Test if an argument is a positive integer (non-zero)
# Takes one argument only.
# Argument: value - EmptyString. Required. Value to check if it is an unsigned integer
# Exit Code: 0 - if it is a positive integer
# Exit Code: 1 - if it is not a positive integer
# Requires: __catchArgument isUnsignedInteger usageDocument
isPositiveInteger() {
  # _IDENTICAL_ functionSignatureSingleArgument 2
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if isUnsignedInteger "${1-}"; then
    [ "$1" -gt 0 ] || return 1
    return 0
  fi
  return 1
}
_isPositiveInteger() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Test if argument are bash functions
# Argument: string - Required. String to test if it is a bash function. Builtins are supported. `.` is explicitly not supported to disambiguate it from the current directory `.`.
# If no arguments are passed, returns exit code 1.
# Exit code: 0 - argument is bash function
# Exit code: 1 - argument is not a bash function
# Requires: __catchArgument isUnsignedInteger usageDocument type
isFunction() {
  # _IDENTICAL_ functionSignatureSingleArgument 2
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || __catchArgument "$handler" "Single argument only: $*" || return $?
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  # Skip illegal options "--" and "-foo"
  [ "$1" = "${1#-}" ] || return 1
  case "$(type -t "$1")" in function | builtin) [ "$1" != "." ] || return 1 ;; *) return 1 ;; esac
}
_isFunction() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL decorate 240

# Sets the environment variable `BUILD_COLORS` if not set, uses `TERM` to calculate
#
# Usage: hasColors
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Exit Code: 0 - Console or output supports colors
# Exit Code: 1 - Colors are likely not supported by console
# Environment: BUILD_COLORS - Optional. Boolean. Whether the build system will output ANSI colors.
# Requires: isPositiveInteger tput
hasColors() {
  # --help is only argument allowed
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"

  # Values allowed for this global are true and false
  # Important: DO NOT use buildEnvironmentLoad BUILD_COLORS TERM
  export BUILD_COLORS
  if [ -z "${BUILD_COLORS-}" ]; then
    BUILD_COLORS=false
    case "${TERM-}" in "" | "dumb" | "unknown") BUILD_COLORS=true ;; *)
      local termColors
      termColors="$(tput colors 2>/dev/null)"
      isPositiveInteger "$termColors" || termColors=2
      [ "$termColors" -lt 8 ] || BUILD_COLORS=true
      ;;
    esac
  elif [ "${BUILD_COLORS-}" != "true" ]; then
    BUILD_COLORS=false
  fi
  [ "${BUILD_COLORS-}" = "true" ]
}
_hasColors() {
  true || hasColors --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Semantics-based
#
# Usage: {fn} label lightStartCode darkStartCode endCode [ -n ] [ message ]
# Requires: hasColors printf
__decorate() {
  local prefix="$1" start="$2" dp="$3" end="$4" && shift 4
  export BUILD_COLORS_MODE BUILD_COLORS
  if [ -n "${BUILD_COLORS-}" ] && [ "${BUILD_COLORS-}" = "true" ] || [ -z "${BUILD_COLORS-}" ] && hasColors; then
    if [ "${BUILD_COLORS_MODE-}" = "dark" ]; then
      start="$dp"
    fi
    if [ $# -eq 0 ]; then printf -- "%s$start" ""; else printf -- "$start%s$end\n" "$*"; fi
    return 0
  fi
  [ $# -gt 0 ] || return 0
  if [ -n "$prefix" ]; then printf -- "%s: %s\n" "$prefix" "$*"; else printf -- "%s\n" "$*"; fi
}

# Output a list of build-in decoration styles, one per line
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
decorations() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf "%s\n" reset \
    underline no-underline bold no-bold \
    black black-contrast blue cyan green magenta orange red white yellow \
    bold-black bold-black-contrast bold-blue bold-cyan bold-green bold-magenta bold-orange bold-red bold-white bold-yellow \
    code info notice success warning error subtle label value decoration
}
_decorations() {
  ! false || decorations --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Singular decoration function
# Usage: decorate style [ text ... ]
# Argument: style - String. Required. One of: reset underline no-underline bold no-bold black black-contrast blue cyan green magenta orange red white yellow bold-black bold-black-contrast bold-blue bold-cyan bold-green bold-magenta bold-orange bold-red bold-white bold-yellow code info notice success warning error subtle label value decoration
# Argument: text - Text to output. If not supplied, outputs a code to change the style to the new style.
# stdout: Decorated text
# Requires: isFunction _argument awk __catchEnvironment usageDocument __executeInputSupport __help
decorate() {
  local handler="_${FUNCNAME[0]}" text="" what="${1-}" lp dp style
  [ "$what" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  shift && [ -n "$what" ] || __catchArgument "$handler" "Requires at least one argument: \"$*\"" || return $?

  if ! style=$(__decorateStyle "$what"); then
    local extend func="${what/-/_}"
    extend="__decorateExtension$(printf "%s" "${func:0:1}" | awk '{print toupper($0)}')${func:1}"
    # When this next line calls `__catchArgument` it results in an infinite loop, so don't - use _argument
    # shellcheck disable=SC2119
    isFunction "$extend" || _argument printf -- "%s\n%s\n" "Unknown decoration name: $what ($extend)" "$(decorations)" || return $?
    __executeInputSupport "$handler" "$extend" -- "$@" || return $?
    return 0
  fi
  IFS=" " read -r lp dp text <<<"$style" || :
  [ "$dp" != "-" ] || dp="$lp"
  local p='\033['

  __executeInputSupport "$handler" __decorate "$text" "${p}${lp}m" "${p}${dp:-$lp}m" "${p}0m" -- "$@" || return $?
}
_decorate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_decorateInitialize() {
  export __BUILD_COLORS
  [ -n "${__BUILD_COLORS-}" ] || __decorateStyles || return $?
}

# Fetch the requested style as a string: lp dp text
# dp may be a dash for simpler parsing - dp=lp when dp is blank or dash
# text is optional, lp is required to be non-blank
# Requires: isArray __decorateStyles
__decorateStyle() {
  local original style pattern=$'\n'"$1="

  _decorateInitialize || return $?
  original="${__BUILD_COLORS}"
  style="${__BUILD_COLORS#*"$pattern"}"
  [ "$style" != "$original" ] || return 1
  style="${style%%$'\n'*}"
  printf "%s\n" "$style"
}

# Default array styles, override if you wish
if ! isFunction __decorateStyles; then
  # This sets __BUILD_COLORS to the styles strings
  __decorateStyles() {
    __decorateStylesDefault
  }
fi

# Default array styles, override if you wish
__decorateStylesDefault() {
  local styles="
reset=0
underline=4
no-underline=24
bold=1
no-bold=21
black=109;7
black-contrast=107;30
blue=94
cyan=36
green=92
magenta=35
orange=33
red=31
white=48;5;0;37
yellow=48;5;16;38;5;11
bold-black=1;109;7
bold-black-contrast=1;107;30
bold-blue=1;94
bold-cyan=1;36
bold-green=92
bold-magenta=1;35
bold-orange=1;33
bold-red=1;31
bold-white=1;48;5;0;37
bold-yellow=1;48;5;16;38;5;11
code=1;97;44
info=38;5;20 1;33 Info
notice=46;31 1;97;44 Notice
success=42;30 0;32 Success
warning=1;93;41 - Warning
error=1;91 - ERROR
subtle=1;38;5;252 1;38;5;240
label=34;103 1;96
value=1;40;97 1;97
decoration=45;97 45;30
"
  export __BUILD_COLORS
  __BUILD_COLORS="$styles"
}

# fn: decorate each
# Usage: decorate each decoration argument1 argument2 ...
# Runs the following command on each subsequent argument for formatting
# Also supports formatting input lines instead (on the same line)
# Example:     decorate each code "$@"
# Requires: decorate printf
# Argument: style - String. Required. The style to decorate each element.
# Argument: -- - Flag. Optional. Pass as the first argument after the style to avoid reading arguments from stdin.
# Argument: --index - Flag. Optional. Show the index of each item before with a colon. `0:first 1:second` etc.
# Argument: --count - Flag. Optional. Show the count of items in the list after the list is generated.
__decorateExtensionEach() {
  local formatted=() item addIndex=false showCount=false index=0 prefix=""

  while [ $# -gt 0 ]; do
    case "$1" in
    --index) addIndex=true ;;
    --count) showCount=true ;;
    --arguments) showCount=true ;;
    *) code="$1" && shift && break ;;
    esac
    shift
  done
  if [ $# -eq 0 ]; then
    local byte
    if read -r -t 1 -n 1 byte; then
      if [ "$byte" = $'\n' ]; then
        formatted+=("$prefix$(decorate "$code" "")")
        byte=""
      fi
      local done=false
      while ! $done; do
        IFS='' read -r item || done=true
        [ -n "$byte$item" ] || ! $done || break
        ! $addIndex || prefix="$index:"
        formatted+=("$prefix$(decorate "$code" "$byte$item")")
        byte=""
        index=$((index + 1))
      done
    fi
  else
    [ "${1-}" != "--" ] || shift
    while [ $# -gt 0 ]; do
      ! $addIndex || prefix="$index:"
      item="$1"
      formatted+=("$prefix$(decorate "$code" "$item")")
      shift
      index=$((index + 1))
    done
  fi
  ! $showCount || formatted+=("[$index]")
  IFS=" " printf -- "%s\n" "${formatted[*]-}"
}

# fn: decorate quote
# Double-quote all arguments as properly quoted bash string
# Mostly $ and " are problematic within a string
# Requires: printf decorate
__decorateExtensionQuote() {
  local text="$*"
  text="${text//\"/\\\"}"
  text="${text//\$/\\\$}"
  printf -- "\"%s\"\n" "$text"
}

# <-- END of IDENTICAL decorate

# _IDENTICAL_ __executeInputSupport 39

# Support arguments and stdin as arguments to an executor
# Argument: executor ... -- - The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial `--`.
# Argument: -- - Alone after the executor forces `stdin` to be ignored. The `--` flag is also removed from the arguments passed to the executor.
# Argument: ... - Any additional arguments are passed directly to the executor
__executeInputSupport() {
  local handler="$1" executor=() && shift

  while [ $# -gt 0 ]; do
    if [ "$1" = "--" ]; then
      shift
      break
    fi
    executor+=("$1")
    shift
  done
  [ ${#executor[@]} -gt 0 ] || return 0

  local byte
  # On Darwin `read -t 0` DOES NOT WORK as a select on stdin
  if [ $# -eq 0 ] && IFS="" read -r -t 1 -n 1 byte; then
    local line done=false
    if [ "$byte" = $'\n' ]; then
      __catchEnvironment "$handler" "${executor[@]}" "" || return $?
      byte=""
    fi
    while ! $done; do
      IFS="" read -r line || done=true
      [ -n "$byte$line" ] || ! $done || break
      __catchEnvironment "$handler" "${executor[@]}" "$byte$line" || return $?
      byte=""
    done
  else
    if [ "${1-}" = "--" ]; then
      shift
    fi
    __catchEnvironment "$handler" "${executor[@]}" "$@" || return $?
  fi
}

# _IDENTICAL_ isArray 19

# Is a variable declared as an array?
# Argument: variableName - Required. String. Variable to check is an array.
isArray() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  while [ $# -gt 0 ]; do
    [ -n "${1-}" ] || return 1
    case "$(declare -p "${1-}" 2>/dev/null)" in
    *"declare -a"*) ;;
    *) return 1 ;;
    esac
    shift
  done
  return 0
}
_isArray() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# _IDENTICAL_ exitString 15

# Output the exit code as a string
#
# INTERNAL: Winner of the one-line bash award 10 years running
# Argument: code ... - UnsignedInteger. String. Exit code value to output.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# stdout: exitCodeToken, one per line
exitString() {
  local k="" && while [ $# -gt 0 ]; do case "$1" in 0) k="success" ;; 1) k="environment" ;; 2) k="argument" ;; 97) k="assert" ;; 105) k="identical" ;; 108) k="leak" ;; 116) k="timeout" ;; 120) k="exit" ;; 127) k="not-found" ;; 130) k="user-interrupt" ;; 141) k="interrupt" ;; 253) k="internal" ;; 254) k="unknown" ;; --help) "_${FUNCNAME[0]}" 0 && return $? || return $? ;; *) k="[exitString unknown \"$1\"]" ;; esac && [ -n "$k" ] || k="$1" && printf "%s\n" "$k" && shift; done
}
_exitString() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL _return 28

# Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)
# Argument: exitCode - Required. UnsignedInteger. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output
# Exit Code: exitCode
# Requires: isUnsignedInteger printf _return
_return() {
  local to=1 icon="✅" code="${1:-1}" && shift 2>/dev/null
  isUnsignedInteger "$code" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer \"$code\"" "$@" || return $?
  [ "$code" -eq 0 ] || icon="❌ [$code]" && to=2
  printf -- "%s %s\n" "$icon" "${*-§}" 1>&"$to"
  return "$code"
}

# Test if an argument is an unsigned integer
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Original: is_uint
# Usage: {fn} argument ...
# Exit Code: 0 - if it is an unsigned integer
# Exit Code: 1 - if it is not an unsigned integer
# Requires: _return
isUnsignedInteger() {
  [ $# -eq 1 ] || _return 2 "Single argument only: $*" || return $?
  case "${1#+}" in --help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

# IDENTICAL _tinySugar 89

# Run `handler` with an argument error
# Usage: {fn} handler ...
__throwArgument() {
  local handler="${1-}"
  shift && "$handler" 2 "$@" || return $?
}

# Run `handler` with an environment error
# Usage: {fn} handler ...
__throwEnvironment() {
  local handler="${1-}"
  shift && "$handler" 1 "$@" || return $?
}

# Run `command`, upon failure run `handler` with an argument error
# Usage: {fn} handler command ...
# Argument: handler - Required. String. Failure command
# Argument: command - Required. Command to run.
# Requires: __throwArgument
__catchArgument() {
  local handler="${1-}"
  shift && "$@" || __throwArgument "$handler" "$@" || return $?
}

# Run `command`, upon failure run `handler` with an environment error
# Usage: {fn} handler command ...
# Argument: handler - Required. String. Failure command
# Argument: command - Required. Command to run.
# Requires: __throwEnvironment
__catchEnvironment() {
  local handler="${1-}"
  shift && "$@" || __throwEnvironment "$handler" "$@" || return $?
}

# _IDENTICAL_ _errors 16

# Return `argument` error code. Outputs `message ...` to `stderr`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 2
# Requires: _return
_argument() {
  _return 2 "$@" || return $?
}

# Return `environment` error code. Outputs `message ...` to `stderr`.
# Argument: message ... - String. Optional. Message to output.
# Exit Code: 1
# Requires: _return
_environment() {
  _return 1 "$@" || return $?
}

# _IDENTICAL_ __environment 10

# Run `command ...` (with any arguments) and then `_environment` if it fails.
# Usage: {fn} command ...
# Argument: command ... - Any command and arguments to run.
# Exit Code: 0 - Success
# Exit Code: 1 - Failed
# Requires: _environment
__environment() {
  "$@" || _environment "$@" || return $?
}

# _IDENTICAL_ returnClean 21

# Delete files or directories and return the same exit code passed in.
# Argument: exitCode - Required. Integer. Exit code to return.
# Argument: item - Optional. One or more files or folders to delete, failures are logged to stderr.
# Requires: isUnsignedInteger _argument __environment usageDocument
# Group: Sugar
returnClean() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local exitCode="${1-}" && shift
  if ! isUnsignedInteger "$exitCode"; then
    __throwArgument "$handler" "$exitCode (not an integer) $*" || return $?
  else
    __environment rm -rf "$@" || return "$exitCode"
    return "$exitCode"
  fi
}
_returnClean() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# <-- END of IDENTICAL _tinySugar
# <-- END of IDENTICAL _tinySugar

# Argument: binary ... - Required. Executable. Any arguments are passed to `binary`.
# Run binary and output failed command upon error
# Requires: _return
__execute() {
  "$@" || _return "$?" "$@" || return $?
}

# IDENTICAL returnUndo 40

# Run a function and preserve exit code
# Returns `exitCode`
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: exitCode - Required. UnsignedInteger. Exit code to return.
# Argument: undoFunction - Optional. Command to run to undo something. Return status is ignored.
# Argument: -- - Flag. Optional. Used to delimit multiple commands.
# As a caveat, your command to `undo` can NOT take the argument `--` as a parameter.
# Example:     local undo thing
# Example:     thing=$(__catchEnvironment "$handler" createLargeResource) || return $?
# Example:     undo+=(-- deleteLargeResource "$thing")
# Example:     thing=$(__catchEnvironment "$handler" createMassiveResource) || returnUndo $? "${undo[@]}" || return $?
# Example:     undo+=(-- deleteMassiveResource "$thing")
# Requires: isPositiveInteger __catchArgument decorate __execute
# Requires: usageDocument
returnUndo() {
  [ "$1" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local __count=$# __saved=("$@") __handler="_${FUNCNAME[0]}" exitCode="${1-}" args=()
  shift
  isUnsignedInteger "$exitCode" || __catchArgument "$__handler" "Not an integer $(decorate value "$exitCode") (#$__count: $(decorate each code "${__saved[@]+"${__saved[@]}"}"))" || return $?
  while [ $# -gt 0 ]; do
    case "$1" in
    --)
      [ "${#args[@]}" -eq 0 ] || __execute "${args[@]}" || :
      args=()
      ;;
    *)
      args+=("$1")
      ;;
    esac
    shift
  done
  [ "${#args[@]}" -eq 0 ] || __execute "${args[@]}" || :
  return "$exitCode"
}
_returnUndo() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Final line will be rewritten on update
#
# Points to the project root relative to this file's location
#
# So:
#
# - "bin/install-bin-build.sh" -> ".."
# - "bin/pipeline/install-bin-build.sh" -> "../.."
# - "bin/app/vendorApp/install-bin-build.sh" -> "../../.."
#
# -- DO NOT EDIT ANYTHING ABOVE THIS LINE IT WILL BE OVERWRITTEN --
__installPackageConfiguration ../.. "$@"
