#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deploy.sh"
argument="deployHome - Directory. Required. Deployment database home."$'\n'"versionName - String. Required. Application ID to look for"$'\n'""
base="deploy.sh"
description="Get the next version of the supplied version"$'\n'""$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployNextVersion"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceModified="1768721469"
summary="Get the next version of the supplied version"
usage="deployNextVersion deployHome versionName"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdeployNextVersion[0m [38;2;255;255;0m[35;48;2;0;0;0mdeployHome[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mversionName[0m[0m

    [31mdeployHome   [1;97mDirectory. Required. Deployment database home.[0m
    [31mversionName  [1;97mString. Required. Application ID to look for[0m

Get the next version of the supplied version

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: deployNextVersion deployHome versionName

    deployHome   Directory. Required. Deployment database home.
    versionName  String. Required. Application ID to look for

Get the next version of the supplied version

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
