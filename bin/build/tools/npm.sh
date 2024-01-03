#!/usr/bin/env bash
#
# npm functions
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh os.sh apt.sh
# bin: npm
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

#
# Usage: npmInstall npmVersion
# Environment: BUILD_NPM_VERSION - Read-only. Default version. If not specified, uses `latest`.
# Summary: Install NPM in the build environment
# Install NPM in the build environment
# If this fails it will output the installation log.
# When this tool succeeds the `npm` binary is available in the local operating system.
# Environment: - `BUILD_NPM_VERSION` - String. Default to `latest`. Used to install `npm -i npm@$BUILD_NPM_VERSION` on install.
# Exit Code: 1 - If installation of npm fails
# Exit Code: 0 - If npm is already installed or installed without error
# Binary: npm.sh
#
npmInstall() {
    local start npm_version quietLog

    if which npm 2>/dev/null 1>&2; then
        return 0
    fi

    start=$(beginTiming)
    npm_version="${1-${BUILD_NPM_VERSION:-latest}}"
    quietLog=$(buildQuietLog npmInstall)

    if ! aptInstall npm; then
        return "$errorEnvironment"
    fi

    if ! requireFileDirectory "$quietLog"; then
        return "$errorEnvironment"
    fi
    if ! npm i -g "npm@$npm_version" --force >>"$quietLog" 2>&1; then
        buildFailed "$quietLog"
        return "$errorEnvironment"
    fi
    reportTiming "$start" OK
}
