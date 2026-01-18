#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="needle - String. Required."$'\n'"haystack - String. Required."$'\n'""
base="text.sh"
description="Outputs the integer offset of \`needle\` if found as substring in \`haystack\` (case-insensitive)"$'\n'"If \`haystack\` is not found, -1 is output"$'\n'""
file="bin/build/tools/text.sh"
fn="stringOffsetInsensitive"
foundNames=([0]="argument" [1]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768721469"
stdout="\`Integer\`. The offset at which the \`needle\` was found in \`haystack\`. Outputs -1 if not found."$'\n'""
summary="Outputs the integer offset of \`needle\` if found as substring"
usage="stringOffsetInsensitive needle haystack"
