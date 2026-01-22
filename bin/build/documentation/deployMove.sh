#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deploy.sh"
argument="applicationPath - Directory. Required. Application target path."$'\n'""
base="deploy.sh"
description="Safe application deployment by moving"$'\n'""$'\n'""$'\n'"Deploy current application to target path"$'\n'""$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployMove"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceModified="1768721469"
summary="Safe application deployment by moving"
usage="deployMove applicationPath"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdeployMove[0m [38;2;255;255;0m[35;48;2;0;0;0mapplicationPath[0m[0m

    [31mapplicationPath  [1;97mDirectory. Required. Application target path.[0m

Safe application deployment by moving


Deploy current application to target path

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: deployMove applicationPath

    applicationPath  Directory. Required. Application target path.

Safe application deployment by moving


Deploy current application to target path

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
