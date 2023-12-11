#!/bin/bash
#
# Local local container to test build
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

if [ ! -d ./bin/build ]; then
    ./bin/build/install-bin-build.sh
fi

#shellcheck source=/dev/null
. ./bin/build/tools.sh

bitbucketContainer "$@"
