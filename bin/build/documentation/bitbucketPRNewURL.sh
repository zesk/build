#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bitbucket.sh"
argument="organization - String. Organization name."$'\n'"repository - String. Repository name."$'\n'""
base="bitbucket.sh"
description="Compute the URL to create a new PR"$'\n'""
file="bin/build/tools/bitbucket.sh"
fn="bitbucketPRNewURL"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bitbucket.sh"
sourceModified="1769063211"
summary="Compute the URL to create a new PR"
usage="bitbucketPRNewURL [ organization ] [ repository ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbitbucketPRNewURL[0m [94m[ organization ][0m [94m[ repository ][0m

    [94morganization  [1;97mString. Organization name.[0m
    [94mrepository    [1;97mString. Repository name.[0m

Compute the URL to create a new PR

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bitbucketPRNewURL [ organization ] [ repository ]

    organization  String. Organization name.
    repository    String. Repository name.

Compute the URL to create a new PR

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
