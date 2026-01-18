#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/character.sh"
argument="text - Text to validate"$'\n'"class0 ... - One or more character classes that the characters in string should match"$'\n'"--help - Flag. Optional.Display this help."$'\n'""
base="character.sh"
description="Ensure that every character in a text string passes all character class tests"$'\n'""
file="bin/build/tools/character.sh"
fn="stringValidate"
foundNames=([0]="argument" [1]="note")
note="This is slow."$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/character.sh"
sourceModified="1768695708"
summary="Ensure that every character in a text string passes all"
usage="stringValidate [ text ] [ class0 ... ] [ --help ]"
