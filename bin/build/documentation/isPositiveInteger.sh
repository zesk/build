#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/type.sh"
argument="value - EmptyString. Required. Value to check if it is an unsigned integer"$'\n'""
base="type.sh"
description="Test if an argument is a positive integer (non-zero)"$'\n'"Takes one argument only."$'\n'"Return Code: 0 - if it is a positive integer"$'\n'"Return Code: 1 - if it is not a positive integer"$'\n'""
file="bin/build/tools/type.sh"
fn="isPositiveInteger"
foundNames=([0]="argument" [1]="requires")
requires="catchArgument isUnsignedInteger usageDocument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/type.sh"
sourceModified="1768695708"
summary="Test if an argument is a positive integer (non-zero)"
usage="isPositiveInteger value"
