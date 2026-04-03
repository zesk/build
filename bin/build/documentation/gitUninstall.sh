#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="package - Additional packages to uninstall"$'\n'""
base="git.sh"
description="Uninstalls the \`git\` binary"$'\n'""
file="bin/build/tools/git.sh"
fn="gitUninstall"
foundNames=([0]="argument" [1]="summary")
rawComment="Uninstalls the \`git\` binary"$'\n'"Argument: package - Additional packages to uninstall"$'\n'"Summary: Uninstall git"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="39d6230492936d0e156da4e32557793909dfa40b"
summary="Uninstall git"$'\n'""
usage="gitUninstall [ package ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitUninstall'$'\e''[0m '$'\e''[[(blue)]m[ package ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpackage  '$'\e''[[(value)]mAdditional packages to uninstall'$'\e''[[(reset)]m'$'\n'''$'\n''Uninstalls the '$'\e''[[(code)]mgit'$'\e''[[(reset)]m binary'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitUninstall [ package ]'$'\n'''$'\n''    package  Additional packages to uninstall'$'\n'''$'\n''Uninstalls the git binary'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
