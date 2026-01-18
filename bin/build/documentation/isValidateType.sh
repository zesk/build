#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/validate.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"type - String. Optional. Type to validate as \`validate\` type."$'\n'""
base="validate.sh"
description="Are all arguments passed a valid validate type?"$'\n'""
example="    isValidateType string || returnMessage 1 \"string is not a type.\""$'\n'""
file="bin/build/tools/validate.sh"
fn="isValidateType"
foundNames=([0]="argument" [1]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/validate.sh"
sourceModified="1768721469"
summary="Are all arguments passed a valid validate type?"
usage="isValidateType [ --help ] [ type ]"
