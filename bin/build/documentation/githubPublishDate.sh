#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/github.sh"
argument="ownerRepository - String. Github \`owner/repository\` string"$'\n'""
base="github.sh"
description="Output the publish date for the latest release of ownerRepository"$'\n'""
file="bin/build/tools/github.sh"
fn="githubPublishDate"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/github.sh"
sourceModified="1769063211"
summary="Output the publish date for the latest release of ownerRepository"
usage="githubPublishDate [ ownerRepository ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgithubPublishDate[0m [94m[ ownerRepository ][0m

    [94mownerRepository  [1;97mString. Github [38;2;0;255;0;48;2;0;0;0mowner/repository[0m string[0m

Output the publish date for the latest release of ownerRepository

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: githubPublishDate [ ownerRepository ]

    ownerRepository  String. Github owner/repository string

Output the publish date for the latest release of ownerRepository

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
