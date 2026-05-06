#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="organization - String. Organization name."$'\n'"repository - String. Repository name."$'\n'""
base="bitbucket.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Compute the URL to create a new PR"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/bitbucket.sh"
fn="bitbucketPRNewURL"
fnMarker="bitbucketprnewurl"
foundNames=([0]="argument")
line="100"
rawComment="Compute the URL to create a new PR"$'\n'"Argument: organization - String. Organization name."$'\n'"Argument: repository - String. Repository name."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bitbucket.sh"
sourceHash="1f4c241b99592c40a01d7716c3276a12de251352"
sourceLine="100"
summary="Compute the URL to create a new PR"
summaryComputed="true"
usage="bitbucketPRNewURL [ organization ] [ repository ]"
