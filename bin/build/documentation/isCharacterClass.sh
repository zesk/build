#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/character.sh"
argument="className - String. Required. Class to check."$'\n'"character ... - String. Optional. Characters to test."$'\n'"--help - Flag. Optional.Display this help."$'\n'""
base="character.sh"
description="Poor-man's bash character class matching"$'\n'""$'\n'"Returns true if all \`characters\` are of \`className\`"$'\n'""$'\n'"\`className\` can be one of:"$'\n'"    alnum   alpha   ascii   blank   cntrl   digit   graph   lower"$'\n'"    print   punct   space   upper   word    xdigit"$'\n'""$'\n'""
file="bin/build/tools/character.sh"
fn="isCharacterClass"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/character.sh"
sourceModified="1768695708"
summary="Poor-man's bash character class matching"
usage="isCharacterClass className [ character ... ] [ --help ]"
