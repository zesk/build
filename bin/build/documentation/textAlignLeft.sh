#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"characterWidth - UnsignedInteger. Required. Number of characters to align left"$'\n'"text ... - Text to align left."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Format text and align it left using spaces."$'\n'""$'\n'""
descriptionLineCount="2"
example="    printf \"%s: %s\\n\" \"\$(textAlignLeft 14 Name)\" \"\$name\""$'\n'"    printf \"%s: %s\\n\" \"\$(textAlignLeft 14 Profession)\" \"\$occupation\""$'\n'"    Name          : Tyrone"$'\n'"    Profession    : Engineer"$'\n'""
file="bin/build/tools/text.sh"
fn="textAlignLeft"
fnMarker="textalignleft"
foundNames=([0]="summary" [1]="argument" [2]="example")
line="1281"
rawComment="Summary: align text left"$'\n'"Format text and align it left using spaces."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: characterWidth - UnsignedInteger. Required. Number of characters to align left"$'\n'"Argument: text ... - Text to align left."$'\n'"Example:     printf \"%s: %s\\n\" \"\$(textAlignLeft 14 Name)\" \"\$name\""$'\n'"Example:     printf \"%s: %s\\n\" \"\$(textAlignLeft 14 Profession)\" \"\$occupation\""$'\n'"Example:     Name          : Tyrone"$'\n'"Example:     Profession    : Engineer"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="1281"
summary="align text left"
summaryComputed=""
usage="textAlignLeft [ --help ] characterWidth [ text ... ]"
