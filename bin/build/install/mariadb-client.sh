#!/usr/bin/env bash
#
# mariadb-client.sh
#
# Depends: apt
#
# mariadb-client install if needed
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
"$(dirname "${BASH_SOURCE[0]}")/../tools.sh" mariadbInstall "$@"
