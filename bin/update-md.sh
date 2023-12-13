#!/usr/bin/env bash
#
# Update .md copies
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

addNoteTo() {
    cp "$1" bin/build
    {
        echo
        echo "(this file is a copy - please modify the original)"
    } >>"bin/build/$1"
    git add "bin/build/$1"
}
addNoteTo README.md
addNoteTo LICENSE.md
