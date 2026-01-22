#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="package - Additional packages to uninstall"$'\n'""
base="git.sh"
description="Uninstalls the \`git\` binary"$'\n'""
file="bin/build/tools/git.sh"
fn="gitUninstall"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1769063211"
summary="Uninstall git"$'\n'""
usage="gitUninstall [ package ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgitUninstall[0m [94m[ package ][0m

    [94mpackage  [1;97mAdditional packages to uninstall[0m

Uninstalls the [38;2;0;255;0;48;2;0;0;0mgit[0m binary

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: gitUninstall [ package ]

    package  Additional packages to uninstall

Uninstalls the git binary

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
