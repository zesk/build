#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--help -  Flag. Optional.Display this help."$'\n'"requiredEnvironment ... -  EnvironmentName. Optional.One or more environment variables which should be non-blank and included in the \`.env\` file."$'\n'"-- -  Divider. Optional.Divides the requiredEnvironment values from the optionalEnvironment"$'\n'"optionalEnvironment ... - EnvironmentName. Optional. One or more environment variables which are included if blank or not"$'\n'""
base="environment.sh"
description="Check application environment is populated correctly."$'\n'"Also verifies that \`environmentApplicationVariables\` and \`environmentApplicationLoad\` are defined."$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentFileApplicationVerify"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768683999"
summary="Check application environment is populated correctly."
usage="environmentFileApplicationVerify [ --help ] [ requiredEnvironment ... ] [ -- ] [ optionalEnvironment ... ]"
