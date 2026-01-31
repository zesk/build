#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="deploy.sh"
description="Environment: PWD"$'\n'"Argument: applicationLinkPath - Path. Required. Path where the link is created."$'\n'"Argument: applicationPath - Path. Optional. Path where the link will point to. If not supplied uses current working directory."$'\n'"Link new version of application."$'\n'"When called, current directory is the **new** application and the \`applicationLinkPath\` which is"$'\n'"passed as an argument is the place where the **new** application should be linked to"$'\n'"in order to activate it."$'\n'"Summary: Link deployment to new version of the application"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Environment error"$'\n'"Return Code: 2 - Argument error"$'\n'""
file="bin/build/tools/deploy.sh"
foundNames=()
rawComment="Environment: PWD"$'\n'"Argument: applicationLinkPath - Path. Required. Path where the link is created."$'\n'"Argument: applicationPath - Path. Optional. Path where the link will point to. If not supplied uses current working directory."$'\n'"Link new version of application."$'\n'"When called, current directory is the **new** application and the \`applicationLinkPath\` which is"$'\n'"passed as an argument is the place where the **new** application should be linked to"$'\n'"in order to activate it."$'\n'"Summary: Link deployment to new version of the application"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Environment error"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/deploy.sh"
sourceHash="a31b1bbd4c1948917bf8d67d421a1dfa3abe655d"
summary="Environment: PWD"
usage="deployLink"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdeployLink'$'\e''[0m'$'\n'''$'\n''Environment: PWD'$'\n''Argument: applicationLinkPath - Path. Required. Path where the link is created.'$'\n''Argument: applicationPath - Path. Optional. Path where the link will point to. If not supplied uses current working directory.'$'\n''Link new version of application.'$'\n''When called, current directory is the '$'\e''[[(red)]mnew'$'\e''[[(reset)]m application and the '$'\e''[[(code)]mapplicationLinkPath'$'\e''[[(reset)]m which is'$'\n''passed as an argument is the place where the '$'\e''[[(red)]mnew'$'\e''[[(reset)]m application should be linked to'$'\n''in order to activate it.'$'\n''Summary: Link deployment to new version of the application'$'\n''Return Code: 0 - Success'$'\n''Return Code: 1 - Environment error'$'\n''Return Code: 2 - Argument error'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: deployLink'$'\n'''$'\n''Environment: PWD'$'\n''Argument: applicationLinkPath - Path. Required. Path where the link is created.'$'\n''Argument: applicationPath - Path. Optional. Path where the link will point to. If not supplied uses current working directory.'$'\n''Link new version of application.'$'\n''When called, current directory is the new application and the applicationLinkPath which is'$'\n''passed as an argument is the place where the new application should be linked to'$'\n''in order to activate it.'$'\n''Summary: Link deployment to new version of the application'$'\n''Return Code: 0 - Success'$'\n''Return Code: 1 - Environment error'$'\n''Return Code: 2 - Argument error'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.447
