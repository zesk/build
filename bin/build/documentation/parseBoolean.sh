#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="none"
base="text.sh"
description="Parses text and determines if it's true-ish"$'\n'""$'\n'"Return Code: 0 - true"$'\n'"Return Code: 1 - false"$'\n'"Return Code: 2 - Neither"$'\n'"Without arguments, displays help."$'\n'"Return code: - \`0\` - Text is plain"$'\n'"Return code: - \`1\` - Text contains non-plain characters"$'\n'""
file="bin/build/tools/text.sh"
fn="parseBoolean"
foundNames=([0]="requires")
requires="lowercase __help"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768759798"
summary="Parses text and determines if it's true-ish"
usage="parseBoolean"
