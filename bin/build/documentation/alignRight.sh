#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decoration.sh"
argument="characterWidth - Characters to align right"$'\n'"text ... - Text to align right"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="decoration.sh"
description="Format text and align it right using spaces."$'\n'""$'\n'""
example="    printf \"%s: %s\\n\" \"\$(alignRight 20 Name)\" \"\$name\""$'\n'"    printf \"%s: %s\\n\" \"\$(alignRight 20 Profession)\" \"\$occupation\""$'\n'"                Name: Juanita"$'\n'"          Profession: Engineer"$'\n'""
file="bin/build/tools/decoration.sh"
fn="alignRight"
foundNames=([0]="summary" [1]="argument" [2]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/decoration.sh"
sourceModified="1768721469"
summary="align text right"$'\n'""
usage="alignRight [ characterWidth ] [ text ... ] [ --help ]"
