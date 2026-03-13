#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="package - Additional packages to install"$'\n'""
base="git.sh"
description="Installs the \`git\` binary"$'\n'""
file="bin/build/tools/git.sh"
fn="gitInstall"
foundNames=([0]="argument" [1]="summary")
rawComment="Installs the \`git\` binary"$'\n'"Argument: package - Additional packages to install"$'\n'"Summary: Install git if needed"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="45b6673cbbcdf6c9e5146a922f9b837146aa0ed8"
summary="Install git if needed"$'\n'""
usage="gitInstall [ package ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitInstall'$'\e''[0m '$'\e''[[(blue)]m[ package ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpackage  '$'\e''[[(value)]mAdditional packages to install'$'\e''[[(reset)]m'$'\n'''$'\n''Installs the '$'\e''[[(code)]mgit'$'\e''[[(reset)]m binary'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitInstall [ package ]'$'\n'''$'\n''    package  Additional packages to install'$'\n'''$'\n''Installs the git binary'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
