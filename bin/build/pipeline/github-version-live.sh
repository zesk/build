#!/usr/bin/env bash
#
# github-version-live.sh
#
# Depends: apt.sh
#
# Get the live version from the GitHub API
#
# See: githubLatestRelease
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
"$(dirname "${BASH_SOURCE[0]}")/../tools.sh" githubLatestRelease "$@"
