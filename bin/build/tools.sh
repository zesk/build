#!/usr/bin/env bash
#
# Shell colors
#
# Usage: source ./bin/build/tools.sh
#
# Depends: -
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
errEnv=1

# shellcheck source=/dev/null
. ./bin/build/tools/text.sh
# shellcheck source=/dev/null
. ./bin/build/tools/colors.sh
# shellcheck source=/dev/null
. ./bin/build/tools/pipeline.sh
# shellcheck source=/dev/null
. ./bin/build/tools/os.sh

# shellcheck source=/dev/null
. ./bin/build/tools/usage.sh
# shellcheck source=/dev/null
. ./bin/build/tools/aws.sh
# shellcheck source=/dev/null
. ./bin/build/tools/git.sh
# shellcheck source=/dev/null
. ./bin/build/tools/docker.sh
