#!/usr/bin/env bash
#
# apt functions
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: colors.sh pipeline.sh
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

#
# Run apt-get update once and only once in the pipeline, at least
# once an hour as well (when testing)
#
# Short Description: Do `apt-get update` once
# Usage: aptUpdateOnce
# Environment: Stores state files in `./.build/` directory which is created if it does not exist.
#
aptUpdateOnce() {
    local older name quietLog start cacheFile=.apt-update

    quietLog=$(buildQuietLog aptUpdateOnce)
    name=$(buildCacheDirectory "$cacheFile")
    if ! requireFileDirectory "$quietLog" || ! requireFileDirectory "$name"; then
        return "$errorEnvironment"
    fi
    # once an hour, technically
    older=$(find "$(buildCacheDirectory)" -name "$cacheFile" -mmin +60 | head -n 1)
    if [ -n "$older" ]; then
        rm -rf "$older"
    fi
    if [ -f "$name" ]; then
        return 0
    fi
    if ! which apt-get >/dev/null; then
        consoleError "No apt-get available" 1>&2
        return 1
    fi
    start=$(beginTiming)
    consoleInfo -n "apt-get update ... "
    if ! DEBIAN_FRONTEND=noninteractive apt-get update -y >"$quietLog" 2>&1; then
        buildFailed "$quietLog"
        return "$errorEnvironment"
    fi
    reportTiming "$start" OK
    date >"$name"
}

#
# Install packages using `apt-get`. If `apt-get` is not available, this succeeds
# and assumes packages will be available.
#
# Usage: aptInstall [ package ... ]
# Example:     aptInstall shellcheck
# Exit Code: 0 - If `apt-get` is not installed, returns 0.
# Exit Code: 1 - If `apt-get` fails to install the packages
# Short Description: Install packages using `apt-get`
# Argument: package - One or more packages to install
#
aptInstall() {
    local installedLog quietLog
    local actualPackages=() packages=(apt-utils figlet jq "$@")
    local apt start

    start=$(beginTiming)
    quietLog=$(buildQuietLog aptInstall)
    installedLog="$(buildCacheDirectory apt.packages)"
    apt=$(which apt-get || :)
    if [ -z "$apt" ]; then
        consoleWarning "No apt, continuing anyway ..."
        return 0
    fi

    if ! aptUpdateOnce; then
        return "$errorEnvironment"
    fi
    if ! requireFileDirectory "$quietLog" || ! requireFileDirectory "$installedLog"; then
        return "$errorEnvironment"
    fi
    touch "$installedLog" || return $?

    for p in "${packages[@]}"; do
        if ! grep -q -e "^$p$" "$installedLog"; then
            actualPackages+=("$p")
            printf "%s\n" "$p" >>"$installedLog"
        fi
    done

    if [ "${#actualPackages[@]}" -eq 0 ]; then
        if [ -n "$*" ]; then
            consoleSuccess "Already installed: $*"
        fi
        return 0
    fi
    consoleInfo -n "Installing ${actualPackages[*]} ... "
    if ! DEBIAN_FRONTEND=noninteractive "$apt" install -y "${actualPackages[@]}" >>"$quietLog" 2>&1; then
        buildFailed "$quietLog"
        return "$errorEnvironment"
    fi
    reportTiming "$start" OK
}

#
# whichApt binary aptInstallPackage
#
# Installs an apt package if a binary does not exist in the which path.
# The assumption here is that `aptInstallPackage` will install the desired `binary`.
#
# If fails, runs `buildFailed` and outputs the log file.
#
# Confirms that `binary` is installed after installation succeeds.
#
# Short Description: Install tools using `apt-get` if they are not found
# Usage: whichApt binary aptInstallPackage
# Example:     whichApt shellcheck shellcheck
# Example:     whichApt mariadb mariadb-client
# Argument: binary - The binary to look for
# Argument: aptInstallPackage - The package name to install if the binary is not found in the `$PATH`.
# Environment: Technically this will install the binary and any related files as a package.
#
whichApt() {
    local binary=$1 quietLog
    shift
    if which "$binary" >/dev/null; then
        return 0
    fi
    if ! aptInstall "$@"; then
        return $errorEnvironment
    fi
    if which "$binary" >/dev/null; then
        return 0
    fi
    consoleError "Apt packages \"$*\" did not add $binary to the PATH $PATH"
    buildFailed "$quietLog"
}
