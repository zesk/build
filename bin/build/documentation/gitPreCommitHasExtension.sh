#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/git.sh"
argument="extension - String. Optional. Extension to check. Use \`!\` for blank extension and \`@\` for all extensions. Can specify one or more."$'\n'""
base="git.sh"
description="Does this commit have the following file extensions?"$'\n'"Return code: 0 - if all extensions are present"$'\n'"Return code: 1 - if any extension is not present"$'\n'""
file="bin/build/tools/git.sh"
fn="gitPreCommitHasExtension"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/git.sh"
sourceModified="1768759336"
summary="Does this commit have the following file extensions?"
usage="gitPreCommitHasExtension [ extension ]"
