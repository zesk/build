#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decoration.sh"
argument="--help - Flag. Optional.Display this help."$'\n'"characterWidth - Characters to align left"$'\n'"text ... - Text to align left"$'\n'""
base="decoration.sh"
description="Format text and align it left using spaces."$'\n'""$'\n'""$'\n'""
example="    printf \"%s: %s\\n\" \"\$(alignLeft 14 Name)\" \"\$name\""$'\n'"    printf \"%s: %s\\n\" \"\$(alignLeft 14 Profession)\" \"\$occupation\""$'\n'"    Name          : Tyrone"$'\n'"    Profession    : Engineer"$'\n'""
file="bin/build/tools/decoration.sh"
fn="alignLeft"
foundNames=([0]="summary" [1]="argument" [2]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/decoration.sh"
sourceModified="1768695708"
summary="align text left"$'\n'""
usage="alignLeft [ --help ] [ characterWidth ] [ text ... ]"
