#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deploy.sh"
argument="deployHome - Directory. Required. Deployment database home."$'\n'"applicationPath - Directory. Required. Application target path."$'\n'""
base="deploy.sh"
description="Automatically convert application deployments using non-links to links."$'\n'""$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployMigrateDirectoryToLink"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceModified="1768721469"
summary="Automatically convert application deployments using non-links to links."
usage="deployMigrateDirectoryToLink deployHome applicationPath"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdeployMigrateDirectoryToLink[0m [38;2;255;255;0m[35;48;2;0;0;0mdeployHome[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mapplicationPath[0m[0m

    [31mdeployHome       [1;97mDirectory. Required. Deployment database home.[0m
    [31mapplicationPath  [1;97mDirectory. Required. Application target path.[0m

Automatically convert application deployments using non-links to links.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: deployMigrateDirectoryToLink deployHome applicationPath

    deployHome       Directory. Required. Deployment database home.
    applicationPath  Directory. Required. Application target path.

Automatically convert application deployments using non-links to links.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
