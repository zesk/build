#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deploy.sh"
argument="deployHome - Directory. Required. Deployment database home."$'\n'""
base="deploy.sh"
description="Outputs the build target name which is based on the environment \`BUILD_TARGET\`."$'\n'""$'\n'"If this is called on a non-deployment system, use the application root instead of"$'\n'"\`deployHome\` for compatibility."$'\n'""
environment="BUILD_TARGET"$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployPackageName"
leak="BUILD_TARGET"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceModified="1768721469"
summary="Outputs the build target name which is based on the"
usage="deployPackageName deployHome"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdeployPackageName[0m [38;2;255;255;0m[35;48;2;0;0;0mdeployHome[0m[0m

    [31mdeployHome  [1;97mDirectory. Required. Deployment database home.[0m

Outputs the build target name which is based on the environment [38;2;0;255;0;48;2;0;0;0mBUILD_TARGET[0m.

If this is called on a non-deployment system, use the application root instead of
[38;2;0;255;0;48;2;0;0;0mdeployHome[0m for compatibility.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_TARGET
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: deployPackageName deployHome

    deployHome  Directory. Required. Deployment database home.

Outputs the build target name which is based on the environment BUILD_TARGET.

If this is called on a non-deployment system, use the application root instead of
deployHome for compatibility.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- BUILD_TARGET
- 
'
