#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="bitbucket.sh"
description="Compute the URL to create a new PR"$'\n'"Argument: organization - String. Organization name."$'\n'"Argument: repository - String. Repository name."$'\n'""
file="bin/build/tools/bitbucket.sh"
foundNames=()
rawComment="Compute the URL to create a new PR"$'\n'"Argument: organization - String. Organization name."$'\n'"Argument: repository - String. Repository name."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bitbucket.sh"
sourceHash="4a421c2dcbbf58af3dd11352be2e5851420ecd17"
summary="Compute the URL to create a new PR"
usage="bitbucketPRNewURL"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbitbucketPRNewURL'$'\e''[0m'$'\n'''$'\n''Compute the URL to create a new PR'$'\n''Argument: organization - String. Organization name.'$'\n''Argument: repository - String. Repository name.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bitbucketPRNewURL'$'\n'''$'\n''Compute the URL to create a new PR'$'\n''Argument: organization - String. Organization name.'$'\n''Argument: repository - String. Repository name.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.446
