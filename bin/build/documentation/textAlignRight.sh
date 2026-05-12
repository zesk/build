#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="characterWidth - Characters to align right"$'\n'"text ... - Text to align right"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Format text and align it right using spaces."$'\n'""$'\n'""
descriptionLineCount="2"
example="    printf \"%s: %s\\n\" \"\$(textAlignRight 20 Name)\" \"\$name\""$'\n'"    printf \"%s: %s\\n\" \"\$(textAlignRight 20 Profession)\" \"\$occupation\""$'\n'"                Name: Juanita"$'\n'"          Profession: Engineer"$'\n'""
file="bin/build/tools/text.sh"
fn="textAlignRight"
fnMarker="textalignright"
foundNames=([0]="summary" [1]="argument" [2]="example")
line="1257"
rawComment="Format text and align it right using spaces."$'\n'"Summary: align text right"$'\n'"Argument: characterWidth - Characters to align right"$'\n'"Argument: text ... - Text to align right"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     printf \"%s: %s\\n\" \"\$(textAlignRight 20 Name)\" \"\$name\""$'\n'"Example:     printf \"%s: %s\\n\" \"\$(textAlignRight 20 Profession)\" \"\$occupation\""$'\n'"Example:                 Name: Juanita"$'\n'"Example:           Profession: Engineer"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="b913e34543d2ae704942cadce5473f26955cd42e"
sourceLine="1257"
summary="align text right"
summaryComputed=""
usage="textAlignRight [ characterWidth ] [ text ... ] [ --help ]"
