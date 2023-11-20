#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

if true; then
    # IDENTICAL makeShellFilesExecutable 1
    find . -name '*.sh' ! -path '*/.*' -print0 | xargs -0 chmod -v +x
fi
