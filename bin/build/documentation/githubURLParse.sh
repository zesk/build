#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/github.sh"
argument="url - URL. Required. URL to parse."$'\n'""
base="github.sh"
description="Parse a GitHub URL and return the owner and project name"$'\n'""
file="bin/build/tools/github.sh"
fn="githubURLParse"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/github.sh"
sourceModified="1769063211"
summary="Parse a GitHub URL and return the owner and project"
usage="githubURLParse url"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mgithubURLParse[0m [38;2;255;255;0m[35;48;2;0;0;0murl[0m[0m

    [31murl  [1;97mURL. Required. URL to parse.[0m

Parse a GitHub URL and return the owner and project name

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: githubURLParse url

    url  URL. Required. URL to parse.

Parse a GitHub URL and return the owner and project name

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
