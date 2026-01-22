#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deploy.sh"
argument="deployHome - Directory. Required. Deployment database home."$'\n'"versionName - String. Required. Application ID to look for"$'\n'""
base="deploy.sh"
description="Does a deploy version exist? versionName is the version identifier for deployments"$'\n'""$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployHasVersion"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceModified="1768721469"
summary="Does a deploy version exist? versionName is the version identifier"
usage="deployHasVersion deployHome versionName"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdeployHasVersion[0m [38;2;255;255;0m[35;48;2;0;0;0mdeployHome[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mversionName[0m[0m

    [31mdeployHome   [1;97mDirectory. Required. Deployment database home.[0m
    [31mversionName  [1;97mString. Required. Application ID to look for[0m

Does a deploy version exist? versionName is the version identifier for deployments

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: deployHasVersion deployHome versionName

    deployHome   Directory. Required. Deployment database home.
    versionName  String. Required. Application ID to look for

Does a deploy version exist? versionName is the version identifier for deployments

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
