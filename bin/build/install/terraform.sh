#!/usr/bin/env bash
#
# terraform.sh
#
# Depends: apt
#
# terraform install if needed
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
"$(dirname "${BASH_SOURCE[0]}")/../tools.sh" terraformInstall "$@"
