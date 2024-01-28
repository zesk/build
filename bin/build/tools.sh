#!/usr/bin/env bash
#
# Shell tools
#
# Usage: # shellcheck source=/dev/null
# Usage: . ./bin/build/tools.sh
# Depends: -
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# documentTemplate: ./docs/_templates/__function.md
#

toolsDir="$(dirname "${BASH_SOURCE[0]}")/tools"

# Ordering matters

# no dependencies
# shellcheck source=/dev/null
. "$toolsDir/debug.sh"

# shellcheck source=/dev/null
. "$toolsDir/type.sh"

# no dependencies
# shellcheck source=/dev/null
. "$toolsDir/text.sh"

# no dependencies
# shellcheck source=/dev/null
. "$toolsDir/date.sh"

# shellcheck source=/dev/null
. "$toolsDir/url.sh"

# shellcheck source=/dev/null
. "$toolsDir/colors.sh"

# Depends on text.sh
# shellcheck source=/dev/null
. "$toolsDir/sed.sh"

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
. "$toolsDir/log.sh"

# shellcheck source=/dev/null
. "$toolsDir/usage.sh"
# shellcheck source=/dev/null
. "$toolsDir/aws.sh"
# shellcheck source=/dev/null
. "$toolsDir/git.sh"
# shellcheck source=/dev/null
. "$toolsDir/docker.sh"
# shellcheck source=/dev/null
. "$toolsDir/ssh.sh"
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
. "$toolsDir/test.sh"

# shellcheck source=/dev/null
. "$toolsDir/version.sh"

# shellcheck source=/dev/null
. "$toolsDir/markdown.sh"

# shellcheck source=/dev/null
. "$toolsDir/documentation.sh"

# shellcheck source=/dev/null
. "$toolsDir/documentation/index.sh"

# shellcheck source=/dev/null
. "$toolsDir/documentation/see.sh"

# shellcheck source=/dev/null
. "$toolsDir/vendor.sh"

# shellcheck source=/dev/null
. "$toolsDir/interactive.sh"

# shellcheck source=/dev/null
. "$toolsDir/identical.sh"

if [ "$(basename "${0##-}")" = "$(basename "${BASH_SOURCE[0]}")" ] && [ $# -gt 0 ]; then
  # Only require when running as a shell command
  set -eou pipefail
  # Run remaining command line arguments
  "$@"
fi
