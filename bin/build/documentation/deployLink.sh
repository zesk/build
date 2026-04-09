#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-09
# shellcheck disable=SC2034
argument="applicationLinkPath - Path. Required. Path where the link is created."$'\n'"applicationPath - Path. Optional. Path where the link will point to. If not supplied uses current working directory."$'\n'""
base="deploy.sh"
description="Link new version of application."$'\n'"When called, current directory is the **new** application and the \`applicationLinkPath\` which is"$'\n'"passed as an argument is the place where the **new** application should be linked to"$'\n'"in order to activate it."$'\n'""
environment="PWD"$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployLink"
foundNames=([0]="environment" [1]="argument" [2]="summary" [3]="return_code")
line="236"
lowerFn="deploylink"
rawComment="Environment: PWD"$'\n'"Argument: applicationLinkPath - Path. Required. Path where the link is created."$'\n'"Argument: applicationPath - Path. Optional. Path where the link will point to. If not supplied uses current working directory."$'\n'"Link new version of application."$'\n'"When called, current directory is the **new** application and the \`applicationLinkPath\` which is"$'\n'"passed as an argument is the place where the **new** application should be linked to"$'\n'"in order to activate it."$'\n'"Summary: Link deployment to new version of the application"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Environment error"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceHash="5a5eadb87fbfbe1607e28405b9f8a9b51d2cc067"
sourceLine="236"
summary="Link deployment to new version of the application"$'\n'""
usage="deployLink applicationLinkPath [ applicationPath ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeployLink'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mapplicationLinkPath'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ applicationPath ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mapplicationLinkPath  '$'\e''[[(value)]mPath. Required. Path where the link is created.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mapplicationPath      '$'\e''[[(value)]mPath. Optional. Path where the link will point to. If not supplied uses current working directory.'$'\e''[[(reset)]m'$'\n'''$'\n''Link new version of application.'$'\n''When called, current directory is the '$'\e''[[(red)]mnew'$'\e''[[(reset)]m application and the '$'\e''[[(code)]mapplicationLinkPath'$'\e''[[(reset)]m which is'$'\n''passed as an argument is the place where the '$'\e''[[(red)]mnew'$'\e''[[(reset)]m application should be linked to'$'\n''in order to activate it.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- PWD'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: deployLink applicationLinkPath [ applicationPath ]'$'\n'''$'\n''    applicationLinkPath  Path. Required. Path where the link is created.'$'\n''    applicationPath      Path. Optional. Path where the link will point to. If not supplied uses current working directory.'$'\n'''$'\n''Link new version of application.'$'\n''When called, current directory is the new application and the applicationLinkPath which is'$'\n''passed as an argument is the place where the new application should be linked to'$'\n''in order to activate it.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- PWD'$'\n'''
documentationPath="documentation/source/tools/deploy.md"
