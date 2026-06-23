#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-23
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--fill fillCharacter - Character. Optional. Fill entire line with this character.\n--width fillWidth - UnsignedInteger. Optional. Line width to fill with `fillCharacter`.\nprefix - EmptyString. Required. Prefix each line with this text\nsuffix ... - String. Optional. Prefix each line with this text\n'
base="wrap.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Wrap lines with a string, useful to format output or add color codes to\nconsoles which do not honor colors line-by-line. Intended to be used as a pipe.\n\n'
descriptionLineCount="3"
example=$'    cat "$file" | decorate wrap "CODE> " " <EOL>"\n    cat "$errors" | decorate wrap "    ERROR: [" "]"\n'
file="bin/build/tools/decorate/wrap.sh"
fn="decorate wrap"
fnMarker="__decorateextensionwrap"
foundNames=([0]="fn" [1]="summary" [2]="return_code" [3]="argument" [4]="example")
line="22"
original="__decorateExtensionWrap"
rawComment=$'fn: decorate wrap\nWrap lines with a string, useful to format output or add color codes to\nconsoles which do not honor colors line-by-line. Intended to be used as a pipe.\nSummary: Prefix output lines with a string\nReturn Code: 0 - stdout contains input wrapped with text\nReturn Code: 1 - Environment error\nReturn Code: 2 - Argument error\nArgument: --help - Flag. Optional. Display this help.\nArgument: --fill fillCharacter - Character. Optional. Fill entire line with this character.\nArgument: --width fillWidth - UnsignedInteger. Optional. Line width to fill with `fillCharacter`.\nArgument: prefix - EmptyString. Required. Prefix each line with this text\nArgument: suffix ... - String. Optional. Prefix each line with this text\nExample:     cat "$file" | decorate wrap "CODE> " " <EOL>"\nExample:     cat "$errors" | decorate wrap "    ERROR: [" "]"\n\n'
return_code=$'0 - stdout contains input wrapped with text\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/decorate/wrap.sh"
sourceHash="809d8ffbf741c0a04293adf3728ef70821f99be2"
sourceLine="22"
summary="Prefix output lines with a string"
summaryComputed=""
usage="decorate wrap [ --help ] [ --fill fillCharacter ] [ --width fillWidth ] prefix [ suffix ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdecorate wrap'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --fill fillCharacter ]'$'\e''[0m '$'\e''[[(blue)]m[ --width fillWidth ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mprefix'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ suffix ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help                '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--fill fillCharacter  '$'\e''[[(value)]mCharacter. Optional. Fill entire line with this character.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--width fillWidth     '$'\e''[[(value)]mUnsignedInteger. Optional. Line width to fill with '$'\e''[[(code)]mfillCharacter'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mprefix                '$'\e''[[(value)]mEmptyString. Required. Prefix each line with this text'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]msuffix ...            '$'\e''[[(value)]mString. Optional. Prefix each line with this text'$'\e''[[(reset)]m'$'\n'''$'\n''Wrap lines with a string, useful to format output or add color codes to'$'\n''consoles which do not honor colors line-by-line. Intended to be used as a pipe.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - stdout contains input wrapped with text'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    cat "$file" | decorate wrap "CODE> " " <EOL>"'$'\n''    cat "$errors" | decorate wrap "    ERROR: [" "]"'
# shellcheck disable=SC2016
helpPlain='Usage: decorate wrap [ --help ] [ --fill fillCharacter ] [ --width fillWidth ] prefix [ suffix ... ]'$'\n'''$'\n''    --help                Flag. Optional. Display this help.'$'\n''    --fill fillCharacter  Character. Optional. Fill entire line with this character.'$'\n''    --width fillWidth     UnsignedInteger. Optional. Line width to fill with fillCharacter.'$'\n''    prefix                EmptyString. Required. Prefix each line with this text'$'\n''    suffix ...            String. Optional. Prefix each line with this text'$'\n'''$'\n''Wrap lines with a string, useful to format output or add color codes to'$'\n''consoles which do not honor colors line-by-line. Intended to be used as a pipe.'$'\n'''$'\n''Return codes:'$'\n''- 0 - stdout contains input wrapped with text'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    cat "$file" | decorate wrap "CODE> " " <EOL>"'$'\n''    cat "$errors" | decorate wrap "    ERROR: [" "]"'
documentationPath="documentation/source/tools/decorate.md"
