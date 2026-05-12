#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\ncharacterWidth - UnsignedInteger. Required. Number of characters to align left\ntext ... - Text to align left.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Format text and align it left using spaces.\n\n'
descriptionLineCount="2"
example=$'    printf "%s: %s\\n" "$(textAlignLeft 14 Name)" "$name"\n    printf "%s: %s\\n" "$(textAlignLeft 14 Profession)" "$occupation"\n    Name          : Tyrone\n    Profession    : Engineer\n'
file="bin/build/tools/text.sh"
fn="textAlignLeft"
fnMarker="textalignleft"
foundNames=([0]="summary" [1]="argument" [2]="example")
line="1288"
rawComment=$'Summary: align text left\nFormat text and align it left using spaces.\nArgument: --help - Flag. Optional. Display this help.\nArgument: characterWidth - UnsignedInteger. Required. Number of characters to align left\nArgument: text ... - Text to align left.\nExample:     printf "%s: %s\\n" "$(textAlignLeft 14 Name)" "$name"\nExample:     printf "%s: %s\\n" "$(textAlignLeft 14 Profession)" "$occupation"\nExample:     Name          : Tyrone\nExample:     Profession    : Engineer\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="1288"
summary="align text left"
summaryComputed=""
usage="textAlignLeft [ --help ] characterWidth [ text ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtextAlignLeft'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcharacterWidth'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ text ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help          '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mcharacterWidth  '$'\e''[[(value)]mUnsignedInteger. Required. Number of characters to align left'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtext ...        '$'\e''[[(value)]mText to align left.'$'\e''[[(reset)]m'$'\n'''$'\n''Format text and align it left using spaces.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    printf "%s: %s\n" "$(textAlignLeft 14 Name)" "$name"'$'\n''    printf "%s: %s\n" "$(textAlignLeft 14 Profession)" "$occupation"'$'\n''    Name          : Tyrone'$'\n''    Profession    : Engineer'
# shellcheck disable=SC2016
helpPlain='Usage: textAlignLeft [ --help ] characterWidth [ text ... ]'$'\n'''$'\n''    --help          Flag. Optional. Display this help.'$'\n''    characterWidth  UnsignedInteger. Required. Number of characters to align left'$'\n''    text ...        Text to align left.'$'\n'''$'\n''Format text and align it left using spaces.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    printf "%s: %s\n" "$(textAlignLeft 14 Name)" "$name"'$'\n''    printf "%s: %s\n" "$(textAlignLeft 14 Profession)" "$occupation"'$'\n''    Name          : Tyrone'$'\n''    Profession    : Engineer'
documentationPath="documentation/source/tools/decoration.md"
