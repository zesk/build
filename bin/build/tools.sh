#!/usr/bin/env bash
#
# Shell colors
#
# Usage: source ./bin/build/tools.sh
#
# Depends: -
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

toolsDir="$(dirname "${BASH_SOURCE[0]}")/tools"

# Ordering matters

# no dependencies
# shellcheck source=/dev/null
. "$toolsDir/debug.sh"

# no dependencies
# shellcheck source=/dev/null
. "$toolsDir/text.sh"

# shellcheck source=/dev/null
. "$toolsDir/colors.sh"
# Depends on colors.sh text.sh
# shellcheck source=/dev/null
. "$toolsDir/assert.sh"

# shellcheck source=/dev/null
. "$toolsDir/pipeline.sh"
# shellcheck source=/dev/null
. "$toolsDir/apt.sh"
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
# shellcheck source=/dev/null
. "$toolsDir/npm.sh"
# shellcheck source=/dev/null
. "$toolsDir/prettier.sh"
# shellcheck source=/dev/null
. "$toolsDir/install.sh"
# shellcheck source=/dev/null
. "$toolsDir/terraform.sh"

# no dependencies
# shellcheck source=/dev/null
. "$toolsDir/bitbucket.sh"

# shellcheck source=/dev/null
. "$toolsDir/tests.sh"

# shellcheck source=/dev/null
. "$toolsDir/documentation.sh"

# shellcheck source=/dev/null
. "$toolsDir/vendor.sh"
