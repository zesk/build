#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="deployHome - Directory. Required. Deployment database home."$'\n'""
base="deploy.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Outputs the build target name which is based on the environment \`BUILD_TARGET\`."$'\n'""$'\n'"If this is called on a non-deployment system, use the application root instead of"$'\n'"\`deployHome\` for compatibility."$'\n'""$'\n'""
descriptionLineCount="5"
environment="BUILD_TARGET"$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployPackageName"
fnMarker="deploypackagename"
foundNames=([0]="argument" [1]="leak" [2]="environment")
leak="BUILD_TARGET"$'\n'""
line="102"
rawComment="Argument: deployHome - Directory. Required. Deployment database home."$'\n'"Outputs the build target name which is based on the environment \`BUILD_TARGET\`."$'\n'"If this is called on a non-deployment system, use the application root instead of"$'\n'"\`deployHome\` for compatibility."$'\n'"Leak: BUILD_TARGET"$'\n'"Environment: BUILD_TARGET"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceHash="9800c80d1e803796230e87b8fd398df05b0442b9"
sourceLine="102"
summary="Outputs the build target name which is based on the"
summaryComputed="true"
usage="deployPackageName deployHome"
