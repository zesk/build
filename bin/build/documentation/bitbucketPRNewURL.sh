#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'organization - String. Organization name.\nrepository - String. Repository name.\n'
base="bitbucket.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Compute the URL to create a new PR\n\n'
descriptionLineCount="2"
file="bin/build/tools/bitbucket.sh"
fn="bitbucketPRNewURL"
fnMarker="bitbucketprnewurl"
foundNames=([0]="argument")
line="100"
rawComment=$'Compute the URL to create a new PR\nArgument: organization - String. Organization name.\nArgument: repository - String. Repository name.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/bitbucket.sh"
sourceHash="1f4c241b99592c40a01d7716c3276a12de251352"
sourceLine="100"
summary="Compute the URL to create a new PR"
summaryComputed="true"
usage="bitbucketPRNewURL [ organization ] [ repository ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbitbucketPRNewURL'$'\e''[0m '$'\e''[[(blue)]m[ organization ]'$'\e''[0m '$'\e''[[(blue)]m[ repository ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]morganization  '$'\e''[[(value)]mString. Organization name.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mrepository    '$'\e''[[(value)]mString. Repository name.'$'\e''[[(reset)]m'$'\n'''$'\n''Compute the URL to create a new PR'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bitbucketPRNewURL [ organization ] [ repository ]'$'\n'''$'\n''    organization  String. Organization name.'$'\n''    repository    String. Repository name.'$'\n'''$'\n''Compute the URL to create a new PR'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/bitbucket.md"
