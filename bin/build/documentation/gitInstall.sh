#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="package - Additional packages to install"$'\n'""
base="git.sh"
description="Installs the \`git\` binary"$'\n'""
exitCode="0"
file="bin/build/tools/git.sh"
foundNames=([0]="argument" [1]="summary")
rawComment="Installs the \`git\` binary"$'\n'"Argument: package - Additional packages to install"$'\n'"Summary: Install git if needed"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceModified="1769199547"
summary="Install git if needed"$'\n'""
usage="gitInstall [ package ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mgitInstall'$'\e''[0m '$'\e''[[blue]m[ package ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]mpackage  '$'\e''[[value]mAdditional packages to install'$'\e''[[reset]m'$'\n'''$'\n''Installs the '$'\e''[[code]mgit'$'\e''[[reset]m binary'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitInstall [ package ]'$'\n'''$'\n''    package  Additional packages to install'$'\n'''$'\n''Installs the git binary'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
