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

toolsDir="$(dirname "${BASH_SOURCE[0]}")/tools"

# Ordering matters

# no dependencies
# shellcheck source=/dev/null
. "$toolsDir/text.sh"

# shellcheck source=/dev/null
. "$toolsDir/colors.sh"
# shellcheck source=/dev/null
. "$toolsDir/pipeline.sh"
# shellcheck source=/dev/null
. "$toolsDir/os.sh"

# shellcheck source=/dev/null
. "$toolsDir/usage.sh"
# shellcheck source=/dev/null
. "$toolsDir/aws.sh"
# shellcheck source=/dev/null
. "$toolsDir/git.sh"
# shellcheck source=/dev/null
. "$toolsDir/docker.sh"
