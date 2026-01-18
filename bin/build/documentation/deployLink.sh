#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/deploy.sh"
argument="applicationLinkPath - Path. Required. Path where the link is created."$'\n'"applicationPath - Path. Optional. Path where the link will point to. If not supplied uses current working directory."$'\n'""
base="deploy.sh"
description="Link new version of application."$'\n'""$'\n'"When called, current directory is the **new** application and the \`applicationLinkPath\` which is"$'\n'"passed as an argument is the place where the **new** application should be linked to"$'\n'"in order to activate it."$'\n'""$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Environment error"$'\n'"Return Code: 2 - Argument error"$'\n'""
environment="PWD"$'\n'""
file="bin/build/tools/deploy.sh"
fn="deployLink"
foundNames=([0]="environment" [1]="argument" [2]="summary")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/deploy.sh"
sourceModified="1768695708"
summary="Link deployment to new version of the application"$'\n'""
usage="deployLink applicationLinkPath [ applicationPath ]"
