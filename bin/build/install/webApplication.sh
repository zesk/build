#!/usr/bin/env bash
#
# Support scripts to set up a system for running PHP and Apache software
#
# Copyright &copy; 2024 Market Acumen, LLC
#
set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
source ./bin/build/tools.sh

webApplicationConfigure() {
    while [ $# -gt 0 ]; do
        case $1 in

        esac
    done
}
