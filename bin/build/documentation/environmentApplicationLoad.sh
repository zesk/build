#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="application.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values."$'\n'""$'\n'""
descriptionLineCount="2"
environment="BUILD_TIMESTAMP"$'\n'"APPLICATION_BUILD_DATE"$'\n'"APPLICATION_VERSION"$'\n'"APPLICATION_ID"$'\n'"APPLICATION_TAG"$'\n'""
file="bin/build/tools/environment/application.sh"
fn="environmentApplicationLoad"
fnMarker="environmentapplicationload"
foundNames=([0]="environment" [1]="argument")
line="27"
rawComment="Loads application environment variables, set them to their default values if needed, and outputs the list of variables and values."$'\n'"Environment: BUILD_TIMESTAMP"$'\n'"Environment: APPLICATION_BUILD_DATE"$'\n'"Environment: APPLICATION_VERSION"$'\n'"Environment: APPLICATION_ID"$'\n'"Environment: APPLICATION_TAG"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/application.sh"
sourceHash="f877edc58732d2fd005da84e8d7e7ad755c6ef72"
sourceLine="27"
summary="Loads application environment variables, set them to their default values"
summaryComputed="true"
usage="environmentApplicationLoad [ --help ]"
