#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-02-10
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"characterWidth - UnsignedInteger. Required. Number of characters to align left"$'\n'"text ... - Text to align left."$'\n'""
base="text.sh"
description="Format text and align it left using spaces."$'\n'""
example="    printf \"%s: %s\\n\" \"\$(textAlignLeft 14 Name)\" \"\$name\""$'\n'"    printf \"%s: %s\\n\" \"\$(textAlignLeft 14 Profession)\" \"\$occupation\""$'\n'"    Name          : Tyrone"$'\n'"    Profession    : Engineer"$'\n'""
file="bin/build/tools/text.sh"
foundNames=([0]="summary" [1]="argument" [2]="example")
rawComment="Summary: align text left"$'\n'"Format text and align it left using spaces."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: characterWidth - UnsignedInteger. Required. Number of characters to align left"$'\n'"Argument: text ... - Text to align left."$'\n'"Example:     printf \"%s: %s\\n\" \"\$(textAlignLeft 14 Name)\" \"\$name\""$'\n'"Example:     printf \"%s: %s\\n\" \"\$(textAlignLeft 14 Profession)\" \"\$occupation\""$'\n'"Example:     Name          : Tyrone"$'\n'"Example:     Profession    : Engineer"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="fe3f136d59f335809673a5a3a78c67c1bf585bf4"
summary="align text left"$'\n'""
usage="textAlignLeft [ --help ] characterWidth [ text ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtextAlignLeft'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcharacterWidth'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ text ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help          '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mcharacterWidth  '$'\e''[[(value)]mUnsignedInteger. Required. Number of characters to align left'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtext ...        '$'\e''[[(value)]mText to align left.'$'\e''[[(reset)]m'$'\n'''$'\n''Format text and align it left using spaces.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    printf "%s: %s\n" "$(textAlignLeft 14 Name)" "$name"'$'\n''    printf "%s: %s\n" "$(textAlignLeft 14 Profession)" "$occupation"'$'\n''    Name          : Tyrone'$'\n''    Profession    : Engineer'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: textAlignLeft [ --help ] characterWidth [ text ... ]'$'\n'''$'\n''    --help          Flag. Optional. Display this help.'$'\n''    characterWidth  UnsignedInteger. Required. Number of characters to align left'$'\n''    text ...        Text to align left.'$'\n'''$'\n''Format text and align it left using spaces.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    printf "%s: %s\n" "$(textAlignLeft 14 Name)" "$name"'$'\n''    printf "%s: %s\n" "$(textAlignLeft 14 Profession)" "$occupation"'$'\n''    Name          : Tyrone'$'\n''    Profession    : Engineer'$'\n'''
