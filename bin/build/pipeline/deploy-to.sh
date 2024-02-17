#!/usr/bin/env bash
#
# Deploy an application to a server host and path
#
# Artifact: .deployed-hosts
#
# Used to track failed or successful host deployment
# Must be preserved between pipeline steps
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
"$(dirname "${BASH_SOURCE[0]}")/../tools.sh" deployToRemote "$@"
