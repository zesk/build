#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="--help - Flag. Optional. Display this help."$'\n'""
base="git.sh"
description="Fetches a list of tags from git and filters those which start with v and a digit and returns"$'\n'"them sorted by version correctly."$'\n'""$'\n'"Return Code: 1 - If the \`.git\` directory does not exist"$'\n'"Return Code: 0 - Success"$'\n'""
file="bin/build/tools/git.sh"
fn="gitVersionList"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/git.sh"
sourceModified="1768721470"
summary="Fetches a list of tags from git and filters those"
usage="gitVersionList [ --help ]"
