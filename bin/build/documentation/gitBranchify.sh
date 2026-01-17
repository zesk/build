#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="--help -  Flag. Optional.Display this help."$'\n'""
base="git.sh"
description="Check out a branch with the current version and optional formatting"$'\n'""$'\n'"\`BUILD_BRANCH_FORMAT\` is a string which can contain tokens in the form \`{user}\` and \`{version}\`"$'\n'""$'\n'"The default value is \`{version}-{user}\`"$'\n'""$'\n'""
environment="BUILD_BRANCH_FORMAT"$'\n'""
file="bin/build/tools/git.sh"
fn="gitBranchify"
foundNames=([0]="environment" [1]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/git.sh"
sourceModified="1768683853"
summary="Check out a branch with the current version and optional"
usage="gitBranchify [ --help ]"
