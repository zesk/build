#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-09
# shellcheck disable=SC2034
argument="none"
base="package.sh"
description="List installed packages on this system using package manager"$'\n'""
file="bin/build/tools/package.sh"
foundNames=()
rawComment="List installed packages on this system using package manager"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="9446d27b896551a886e9f28cfed65cfe5e5451bf"
summary="List installed packages on this system using package manager"
summaryComputed="true"
usage="packageInstalledList"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpackageInstalledList'$'\e''[0m'$'\n'''$'\n''List installed packages on this system using package manager'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: packageInstalledList'$'\n'''$'\n''List installed packages on this system using package manager'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
