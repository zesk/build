#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"packageManager - String. Manager to check."$'\n'""
base="package.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Is the package manager supported?"$'\n'"Checks the package manager to be a valid, supported one."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/package.sh"
fn="packageManagerValid"
fnMarker="packagemanagervalid"
foundNames=([0]="argument" [1]="return_code")
line="597"
rawComment="Is the package manager supported?"$'\n'"Checks the package manager to be a valid, supported one."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: packageManager - String. Manager to check."$'\n'"Return Code: 0 - The package manager is valid."$'\n'"Return Code: 1 - The package manager is not valid."$'\n'""$'\n'""
return_code="0 - The package manager is valid."$'\n'"1 - The package manager is not valid."$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceHash="a864f8a04df8d4125b28600b085b2148235205d2"
sourceLine="597"
summary="Is the package manager supported?"
summaryComputed="true"
usage="packageManagerValid [ --help ] [ packageManager ]"
