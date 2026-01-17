#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="needle - String. Required. String to replace."$'\n'"replacement - EmptyString.  String to replace needle with."$'\n'"haystack - EmptyString. Optional. String to modify. If not supplied, reads from standard input."$'\n'""
base="text.sh"
description="Replace all occurrences of a string within another string"$'\n'""
file="bin/build/tools/text.sh"
fn="stringReplace"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768686587"
stdin="If no haystack supplied reads from standard input and replaces the string on each line read."$'\n'""
stdout="New string with needle replaced"$'\n'""
summary="Replace all occurrences of a string within another string"
usage="stringReplace needle [ replacement ] [ haystack ]"
