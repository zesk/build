#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="applicationLinkPath - Path. Required. Path where the link is created."$'\n'"applicationPath - Path. Optional. Path where the link will point to. If not supplied uses current working directory."$'\n'""
base="deploy.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Link new version of application."$'\n'""$'\n'"When called, current directory is the **new** application and the \`applicationLinkPath\` which is"$'\n'"passed as an argument is the place where the **new** application should be linked to"$'\n'"in order to activate it."$'\n'""$'\n'""
descriptionLineCount="6"
environment="PWD"$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployLink"
fnMarker="deploylink"
foundNames=([0]="environment" [1]="argument" [2]="summary" [3]="return_code")
line="236"
rawComment="Environment: PWD"$'\n'"Argument: applicationLinkPath - Path. Required. Path where the link is created."$'\n'"Argument: applicationPath - Path. Optional. Path where the link will point to. If not supplied uses current working directory."$'\n'"Link new version of application."$'\n'"When called, current directory is the **new** application and the \`applicationLinkPath\` which is"$'\n'"passed as an argument is the place where the **new** application should be linked to"$'\n'"in order to activate it."$'\n'"Summary: Link deployment to new version of the application"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Environment error"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceHash="9800c80d1e803796230e87b8fd398df05b0442b9"
sourceLine="236"
summary="Link deployment to new version of the application"
summaryComputed=""
usage="deployLink applicationLinkPath [ applicationPath ]"
