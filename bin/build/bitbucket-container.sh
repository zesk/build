#!/bin/bash
#
# Bitbucket local container to test pipeline-related things
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# fn: {base}
# Usage: {fn}
# See `bitbucketContainer` for arguments and usage.
# See: bitbucketContainer
__binBitbucketContainer() {
  "$(dirname "${BASH_SOURCE[0]}")/tools.sh" bitbucketContainer "$@"
}
__binBitbucketContainer "$@"
