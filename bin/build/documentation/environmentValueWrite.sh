#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="name - String. Required. Name to write."$'\n'"value - EmptyString. Optional. Value to write."$'\n'"... - EmptyString. Optional. Additional values, when supplied, write this value as an array."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="environment.sh"
description="Write a value to a state file as NAME=\"value\""$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentValueWrite"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768759812"
summary="Write a value to a state file as NAME=\"value\""
usage="environmentValueWrite name [ value ] [ ... ] [ --help ]"
