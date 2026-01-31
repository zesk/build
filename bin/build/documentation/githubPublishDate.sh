#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="github.sh"
description="Output the publish date for the latest release of ownerRepository"$'\n'"Argument: ownerRepository - String. Github \`owner/repository\` string"$'\n'""
file="bin/build/tools/github.sh"
foundNames=()
rawComment="Output the publish date for the latest release of ownerRepository"$'\n'"Argument: ownerRepository - String. Github \`owner/repository\` string"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/github.sh"
sourceHash="d78fdb57f330a4d130425cf0847c4740aa281790"
summary="Output the publish date for the latest release of ownerRepository"
usage="githubPublishDate"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgithubPublishDate'$'\e''[0m'$'\n'''$'\n''Output the publish date for the latest release of ownerRepository'$'\n''Argument: ownerRepository - String. Github '$'\e''[[(code)]mowner/repository'$'\e''[[(reset)]m string'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: githubPublishDate'$'\n'''$'\n''Output the publish date for the latest release of ownerRepository'$'\n''Argument: ownerRepository - String. Github owner/repository string'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.508
