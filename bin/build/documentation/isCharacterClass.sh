#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="className - String. Required. Class to check."$'\n'"character ... - String. Optional. Characters to test."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="character.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Poor-man's bash character class matching"$'\n'""$'\n'"Returns true if all \`characters\` are of \`className\`"$'\n'""$'\n'"\`className\` can be one of:"$'\n'"    alnum   alpha   ascii   blank   cntrl   digit   graph   lower"$'\n'"    print   punct   space   upper   word    xdigit"$'\n'""$'\n'""
descriptionLineCount="8"
file="bin/build/tools/character.sh"
fn="isCharacterClass"
fnMarker="ischaracterclass"
foundNames=([0]="argument")
line="200"
rawComment="Poor-man's bash character class matching"$'\n'"Returns true if all \`characters\` are of \`className\`"$'\n'"\`className\` can be one of:"$'\n'"    alnum   alpha   ascii   blank   cntrl   digit   graph   lower"$'\n'"    print   punct   space   upper   word    xdigit"$'\n'"Argument: className - String. Required. Class to check."$'\n'"Argument: character ... - String. Optional. Characters to test."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/character.sh"
sourceHash="5a2e05ecbe74faca818a547fd009b4342c8f9e78"
sourceLine="200"
summary="Poor-man's bash character class matching"
summaryComputed="true"
usage="isCharacterClass className [ character ... ] [ --help ]"
