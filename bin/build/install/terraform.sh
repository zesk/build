#!/usr/bin/env bash
#
# terraform.sh
#
# Depends: apt
#
# terraform install if needed
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
init="$(date +%s)"

set -eo pipefail

me="$(basename "$0")"
quietLog=./.build/$me.log
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

#shellcheck source=/dev/null
. ./bin/build/tools.sh

errorEnvironment=1

addHashicorpAptKey() {
    # apt-key is deprecated for good reasons
    # https://stackoverflow.com/questions/68992799/warning-apt-key-is-deprecated-manage-keyring-files-in-trusted-gpg-d-instead
    local stamp ring=/etc/apt/keyrings sourcesPath=/etc/apt/sources.list.d/

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

    stamp=$(beginTiming)
    consoleInfo -n "Fetching Hashicorp GPG key ... "
    if ! curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee "$ring" >/dev/null; then
        return $?
    fi
    reportTiming "$stamp" OK

    stamp=$(beginTiming)
    consoleInfo -n "Adding repository and updating sources ... "
    echo "deb [signed-by=/etc/apt/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" >/etc/apt/sources.list.d/hashicorp.list
    if ! apt-get update -y >>"$quietLog"; then
        buildFailed "$quietLog"
        return $errorEnvironment
    fi
    reportTiming "$stamp" OK
    # Optional (you can find the email address / ID using `apt-key list`)
    # apt-key del support@example.com
}

#
# Main
#
if which terraform >/dev/null; then
    consoleSuccess "terraform is already installed"
    exit 0
fi

./bin/build/install/apt.sh gnupg software-properties-common curl figlet

if ! addHashicorpAptKey; then
    buildFailed "$quietLog"
    exit $errorEnvironment
fi

./bin/build/install/apt.sh terraform
if ! which terraform >/dev/null; then
    consoleError "No terraform binary found - installation failed" 1>&2
    exit $errorEnvironment
fi
reportTiming "$init" "terraform installed in"
