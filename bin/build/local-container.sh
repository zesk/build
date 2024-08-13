#!/bin/bash
#
# Local container to test build
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# fn: {base}
# Usage: {fn}
# See `dockerLocalContainer` for arguments and usage.
# See: dockerLocalContainer
__binDockerLocalContainer() {
  "$(dirname "${BASH_SOURCE[0]}")/tools.sh" dockerLocalContainer "$@"
}
__binDockerLocalContainer "$@"
