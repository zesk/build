#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="ownerRepository - String. Github \`owner/repository\` string"$'\n'""
base="github.sh"
description="Output the publish date for the latest release of ownerRepository"$'\n'""
file="bin/build/tools/github.sh"
fn="githubPublishDate"
foundNames=([0]="argument")
rawComment="Output the publish date for the latest release of ownerRepository"$'\n'"Argument: ownerRepository - String. Github \`owner/repository\` string"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/github.sh"
sourceHash="b139e9ff26ace596d539eac776741adccae51061"
summary="Output the publish date for the latest release of ownerRepository"
summaryComputed="true"
usage="githubPublishDate [ ownerRepository ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgithubPublishDate'$'\e''[0m '$'\e''[[(blue)]m[ ownerRepository ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mownerRepository  '$'\e''[[(value)]mString. Github '$'\e''[[(code)]mowner/repository'$'\e''[[(reset)]m string'$'\e''[[(reset)]m'$'\n'''$'\n''Output the publish date for the latest release of ownerRepository'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: githubPublishDate [ ownerRepository ]'$'\n'''$'\n''    ownerRepository  String. Github owner/repository string'$'\n'''$'\n''Output the publish date for the latest release of ownerRepository'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
