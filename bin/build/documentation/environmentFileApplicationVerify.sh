#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"requiredEnvironment ... - EnvironmentName. Optional. One or more environment variables which should be non-blank and included in the \`.env\` file."$'\n'"-- - Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment"$'\n'"optionalEnvironment ... - EnvironmentName. Optional. One or more environment variables which are included if blank or not"$'\n'""
base="application.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Check application environment is populated correctly."$'\n'"Also verifies that \`environmentApplicationVariables\` and \`environmentApplicationLoad\` are defined."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/environment/application.sh"
fn="environmentFileApplicationVerify"
fnMarker="environmentfileapplicationverify"
foundNames=([0]="argument")
line="140"
rawComment="Check application environment is populated correctly."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: requiredEnvironment ... - EnvironmentName. Optional. One or more environment variables which should be non-blank and included in the \`.env\` file."$'\n'"Argument: -- - Divider. Optional. Divides the requiredEnvironment values from the optionalEnvironment"$'\n'"Argument: optionalEnvironment ... - EnvironmentName. Optional. One or more environment variables which are included if blank or not"$'\n'"Also verifies that \`environmentApplicationVariables\` and \`environmentApplicationLoad\` are defined."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/environment/application.sh"
sourceHash="f877edc58732d2fd005da84e8d7e7ad755c6ef72"
sourceLine="140"
summary="Check application environment is populated correctly."
summaryComputed="true"
usage="environmentFileApplicationVerify [ --help ] [ requiredEnvironment ... ] [ -- ] [ optionalEnvironment ... ]"
