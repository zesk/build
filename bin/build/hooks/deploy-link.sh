#!/usr/bin/env bash
#
# Run during deployRemoteFinish
#
# Run ON THE REMOTE SYSTEM, not in the pipeline so assume little.
#
# Start of deployment to system, delete caches and deal with post-maintenance stopping of services, etc.
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
"${BASH_SOURCE[0]#%/*}/../tools.sh" deployLink "$@"
