#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'-n - Flag. Optional. Numeric sort.\n--verbose - Flag. Optional. Be exceptionally wordy.\nfile - File. Required. File to modify in-place.\n--help - Flag. Optional. Display this help.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Remove duplicate lines from an input stream and sort.\n\n'
descriptionLineCount="2"
file="bin/build/tools/text.sh"
fn="fileUniqueLines"
fnMarker="fileuniquelines"
foundNames=([0]="summary" [1]="argument")
line="611"
rawComment=$'Summary: Sorts and makes all file lines unique\nRemove duplicate lines from an input stream and sort.\nArgument: -n - Flag. Optional. Numeric sort.\nArgument: --verbose - Flag. Optional. Be exceptionally wordy.\nArgument: file - File. Required. File to modify in-place.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="6d769d6727070a6dc8632961d7250fe1f73eea0f"
sourceLine="611"
summary="Sorts and makes all file lines unique"
summaryComputed=""
usage="fileUniqueLines [ -n ] [ --verbose ] file [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileUniqueLines'$'\e''[0m '$'\e''[[(blue)]m[ -n ]'$'\e''[0m '$'\e''[[(blue)]m[ --verbose ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfile'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m-n         '$'\e''[[(value)]mFlag. Optional. Numeric sort.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--verbose  '$'\e''[[(value)]mFlag. Optional. Be exceptionally wordy.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfile       '$'\e''[[(value)]mFile. Required. File to modify in-place.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Remove duplicate lines from an input stream and sort.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: fileUniqueLines [ -n ] [ --verbose ] file [ --help ]'$'\n'''$'\n''    -n         Flag. Optional. Numeric sort.'$'\n''    --verbose  Flag. Optional. Be exceptionally wordy.'$'\n''    file       File. Required. File to modify in-place.'$'\n''    --help     Flag. Optional. Display this help.'$'\n'''$'\n''Remove duplicate lines from an input stream and sort.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/text.md"
