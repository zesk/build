#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deploy.sh"
argument="deployHome - Directory. Required. Deployment database home."$'\n'""
base="deploy.sh"
description="Outputs the build target name which is based on the environment \`BUILD_TARGET\`."$'\n'""$'\n'"If this is called on a non-deployment system, use the application root instead of"$'\n'"\`deployHome\` for compatibility."$'\n'""
environment="BUILD_TARGET"$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployPackageName"
foundNames=([0]="argument" [1]="leak" [2]="environment")
leak="BUILD_TARGET"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/deploy.sh"
sourceModified="1768721469"
summary="Outputs the build target name which is based on the"
usage="deployPackageName deployHome"
