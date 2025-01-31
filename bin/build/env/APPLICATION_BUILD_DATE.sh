#!/usr/bin/env bash
# Time when a build was initiated, set upon first invocation if not already
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Deployment
# Type: DateTime

# shellcheck source=/dev/null
. "$(dirname "${BASH_SOURCE[0]}")/BUILD_TIMESTAMP.sh"

export APPLICATION_BUILD_DATE
APPLICATION_BUILD_DATE="${APPLICATION_BUILD_DATE:-"$(timestampToDate "$BUILD_TIMESTAMP" "%Y-%m-%d %H:%M:%S")"}"
