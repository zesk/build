#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="stateFile - EnvironmentFile. Required. File to read a value from."$'\n'"name - EnvironmentVariable. Required. Variable to read."$'\n'"default - EmptyString. Optional. Default value of the environment variable if it does not exist."$'\n'"--help -  Flag. Optional.Display this help."$'\n'""
base="environment.sh"
description="Return Code: 1 - If value is not found and no default argument is supplied (2 arguments)"$'\n'"Return Code: 0 - If value"$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentValueRead"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768683999"
summary="Return Code: 1 - If value is not found and"
usage="environmentValueRead stateFile name [ default ] [ --help ]"
