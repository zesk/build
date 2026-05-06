#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="string - String. Required. Path to binary to test if it is executable."$'\n'""
base="type.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Test if all arguments are executable binaries"$'\n'"If no arguments are passed, returns exit code 1."$'\n'""$'\n'""
descriptionLineCount="3"
environment="PATH"$'\n'""
file="bin/build/tools/type.sh"
fn="isExecutable"
fnMarker="isexecutable"
foundNames=([0]="argument" [1]="return_code" [2]="requires" [3]="environment")
line="219"
rawComment="Test if all arguments are executable binaries"$'\n'"Argument: string - String. Required. Path to binary to test if it is executable."$'\n'"If no arguments are passed, returns exit code 1."$'\n'"Return Code: 0 - All arguments are executable binaries"$'\n'"Return Code: 1 - One or or more arguments are not executable binaries"$'\n'"Requires: throwArgument  helpArgument type"$'\n'"Environment: PATH"$'\n'""$'\n'""
requires="throwArgument  helpArgument type"$'\n'""
return_code="0 - All arguments are executable binaries"$'\n'"1 - One or or more arguments are not executable binaries"$'\n'""
sourceFile="bin/build/tools/type.sh"
sourceHash="3df0d84917e775e2aba0d9280d56eb8d73b4a8c3"
sourceLine="219"
summary="Test if all arguments are executable binaries"
summaryComputed="true"
usage="isExecutable string"
