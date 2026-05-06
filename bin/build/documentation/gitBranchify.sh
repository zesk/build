#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Check out a branch with the current version and optional formatting"$'\n'""$'\n'"\`BUILD_BRANCH_FORMAT\` is a string which can contain tokens in the form \`{user}\` and \`{version}\`"$'\n'""$'\n'"The default value is \`{version}-{user}\`"$'\n'""$'\n'""
descriptionLineCount="6"
environment="BUILD_BRANCH_FORMAT"$'\n'""
file="bin/build/tools/git.sh"
fn="gitBranchify"
fnMarker="gitbranchify"
foundNames=([0]="environment" [1]="argument")
line="1093"
rawComment="Check out a branch with the current version and optional formatting"$'\n'"\`BUILD_BRANCH_FORMAT\` is a string which can contain tokens in the form \`{user}\` and \`{version}\`"$'\n'"The default value is \`{version}-{user}\`"$'\n'"Environment: BUILD_BRANCH_FORMAT"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="1093"
summary="Check out a branch with the current version and optional"
summaryComputed="true"
usage="gitBranchify [ --help ]"
