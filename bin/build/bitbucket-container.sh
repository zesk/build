#!/bin/bash
#
# Bitbucket local container to test pipeline-related things
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# fn: {base}
# Usage: {fn}
# See `bitbucketContainer` for arguments and usage.
# See: bitbucketContainer
__binBitbucketContainer() {
  "$(dirname "${BASH_SOURCE[0]}")/tools.sh" bitbucketContainer ./bin/build/bash-build.sh "$@"
}
__binBitbucketContainer "$@"
