#!/usr/bin/env bash
#
# aws.sh
#
# Depends: python
#
# aws cli install
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL binBuildInstallDeprecatedWarning 1
printf "%s\n\n    %s %s\n\n" "bin/install/$(basename "${BASH_SOURCE[0]}") was DEPRECATED 2024-10-15 please use" "bin/build/tools.sh" "$(grep dirname "${BASH_SOURCE[0]}" | grep -v DEPRECATED | awk '{ print $3 }')" 1>&2

"$(dirname "${BASH_SOURCE[0]}")/../tools.sh" awsInstall "$@"
