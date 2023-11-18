#!/usr/bin/env bash
#
# terraform.sh
#
# Terraform tools
#
# Depends: apt
#
# terraform install if needed
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

#
# Add keys to enable apt to download terraform directly from hashicorp.com
#
# Usage: addHashicorpAptKey
# Exit Code: 1 - if environmeny is awry
# Exit Code: 0 - All good to install terraform
#
addHashicorpAptKey() {
    # apt-key is deprecated for good reasons
    # https://stackoverflow.com/questions/68992799/warning-apt-key-is-deprecated-manage-keyring-files-in-trusted-gpg-d-instead
    local stamp ring=/etc/apt/keyrings sourcesPath=/etc/apt/sources.list.d/ quietLog

    stamp=$(beginTiming)
    if [ ! -d "$sourcesPath" ]; then
        consoleError "No $sourcesPath exists - not an apt system" 1>&2
        return $errorEnvironment
    fi

    if ! touch "$sourcesPath/$$.test" 2>/dev/null; then
        consoleError "No permission to modify $sourcesPath, failing" 1>&2
        return $errorEnvironment
    fi
    rm "$sourcesPath/$$.test"

    if [ ! -d "$ring" ]; then
        if ! mkdir -p "$ring"; then
            consoleError "Unable to create $ring" 1>&2
            return $errorEnvironment
        fi
    fi

    ring="$ring/hashicorp.gpg"

    consoleInfo -n "Fetching Hashicorp GPG key ... "
    if ! curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee "$ring" >/dev/null; then
        return $?
    fi
    reportTiming "$stamp" OK

    stamp=$(beginTiming)
    consoleInfo -n "Adding repository and updating sources ... "
    echo "deb [signed-by=/etc/apt/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" >/etc/apt/sources.list.d/hashicorp.list
    quietLog=$(buildQuietLog addHashicorpAptKey)
    if ! requireFileDirectory "$quietLog"; then
        return $?
    fi
    if ! apt-get update -y >>"$quietLog"; then
        buildFailed "$quietLog"
        return $errorEnvironment
    fi
    reportTiming "$stamp" OK
}

#
# Install terraform binary
#
# Exit Code: 1 - Error with environment
# Exit Code: 0 - Installed successfully
# Usage: terraformInstall [ pacakge ... ]
# Argument: package - Additional packages to install using apt
#
terraformInstall() {
    local init

    init=$(beginTiming)
    if which terraform >/dev/null; then
        consoleSuccess "terraform is already installed"
        return 0
    fi

    aptInstall gnupg software-properties-common curl figlet

    if ! addHashicorpAptKey; then
        return $?
    fi

    if ! aptInstall terraform "$@"; then
        return $?
    fi

    if ! which terraform >/dev/null; then
        consoleError "No terraform binary found - installation failed" 1>&2
        return $errorEnvironment
    fi
    reportTiming "$init" "terraform installed in"
}
