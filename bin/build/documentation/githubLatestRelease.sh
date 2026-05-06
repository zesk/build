#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="projectName - String. Required. Github project name in the form of \`owner/repository\`"$'\n'""
base="github.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Get the latest release version"$'\n'""$'\n'""
descriptionLineCount="2"
environment="GITHUB_ACCESS_TOKEN"$'\n'""
file="bin/build/tools/github.sh"
fn="githubLatestRelease"
fnMarker="githublatestrelease"
foundNames=([0]="argument" [1]="environment")
line="121"
rawComment="Get the latest release version"$'\n'"Argument: projectName - String. Required. Github project name in the form of \`owner/repository\`"$'\n'"Environment: GITHUB_ACCESS_TOKEN"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/github.sh"
sourceHash="20111d4ebf3d141c00e6ffadada721a727fc8da2"
sourceLine="121"
summary="Get the latest release version"
summaryComputed="true"
usage="githubLatestRelease projectName"
