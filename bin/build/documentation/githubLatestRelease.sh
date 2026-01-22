#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/github.sh"
argument="projectName - String. Required. Github project name in the form of \`owner/repository\`"$'\n'""
base="github.sh"
description="Get the latest release version"$'\n'""$'\n'""
environment="GITHUB_ACCESS_TOKEN"$'\n'""
file="bin/build/tools/github.sh"
fn="githubLatestRelease"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/github.sh"
sourceModified="1769063211"
summary="Get the latest release version"
usage="githubLatestRelease projectName"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgithubLatestRelease[0m [38;2;255;255;0m[35;48;2;0;0;0mprojectName[0m[0m

    [31mprojectName  [1;97mString. Required. Github project name in the form of [38;2;0;255;0;48;2;0;0;0mowner/repository[0m[0m

Get the latest release version

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- GITHUB_ACCESS_TOKEN
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: githubLatestRelease projectName

    projectName  String. Required. Github project name in the form of owner/repository

Get the latest release version

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- GITHUB_ACCESS_TOKEN
- 
'
