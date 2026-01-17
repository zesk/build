#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/github.sh"
argument="projectName - String. Required. Github project name in the form of \`owner/repository\`"$'\n'""
base="github.sh"
description="Get the latest release version"$'\n'""$'\n'""
environment="GITHUB_ACCESS_TOKEN"$'\n'""
file="bin/build/tools/github.sh"
fn="githubLatestRelease"
foundNames=([0]="argument" [1]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/github.sh"
sourceModified="1768683999"
summary="Get the latest release version"
usage="githubLatestRelease projectName"
