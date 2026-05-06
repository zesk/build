#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--non-interactive - Flag. Optional. Do not prompt for input and fail if input is required."$'\n'"--owner ownerName - String. Optional. The \`APPLICATION_OWNER\`."$'\n'"--name applicationName - String. Optional. The \`APPLICATION_NAME\`."$'\n'"--code codeName - String. Optional. The \`APPLICATION_CODE\`."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="application.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Set up a new project for Zesk Build"$'\n'"- Creates shell development environment"$'\n'"- Registers git hooks"$'\n'"- Configures base environment variables"$'\n'"EXPERIMENTAL - not finished yet."$'\n'""$'\n'""
descriptionLineCount="6"
file="bin/build/tools/application.sh"
fn="buildApplicationConfigure"
fnMarker="buildapplicationconfigure"
foundNames=([0]="summary" [1]="argument")
line="146"
rawComment="Summary: Configure project for Zesk Build"$'\n'"Set up a new project for Zesk Build"$'\n'"- Creates shell development environment"$'\n'"- Registers git hooks"$'\n'"- Configures base environment variables"$'\n'"EXPERIMENTAL - not finished yet."$'\n'"Argument: --non-interactive - Flag. Optional. Do not prompt for input and fail if input is required."$'\n'"Argument: --owner ownerName - String. Optional. The \`APPLICATION_OWNER\`."$'\n'"Argument: --name applicationName - String. Optional. The \`APPLICATION_NAME\`."$'\n'"Argument: --code codeName - String. Optional. The \`APPLICATION_CODE\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/application.sh"
sourceHash="562d2de8a12e4176ee14a47d79968f58574ee69d"
sourceLine="146"
summary="Configure project for Zesk Build"
summaryComputed=""
usage="buildApplicationConfigure --non-interactive [ --owner ownerName ] [ --name applicationName ] [ --code codeName ] [ --help ]"
