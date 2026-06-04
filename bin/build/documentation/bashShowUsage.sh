#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument=$'functionName - String. Required. Function which should be called somewhere within a file.\nfile - File. Required. File to search for function handler.\n--help - Flag. Optional. Display this help.\n'
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Show function handler in files\nThis check is simplistic and does not verify actual coverage or code paths.\n\n'
descriptionLineCount="3"
file="bin/build/tools/bash.sh"
fn="bashShowUsage"
fnMarker="bashshowusage"
foundNames=([0]="argument" [1]="return_code" [2]="requires")
line="316"
rawComment=$'Show function handler in files\nArgument: functionName - String. Required. Function which should be called somewhere within a file.\nArgument: file - File. Required. File to search for function handler.\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 0 - Function is used within the file\nReturn Code: 1 - Function is *not* used within the file\nThis check is simplistic and does not verify actual coverage or code paths.\nRequires: throwArgument decorate validate quoteGrepPattern bashStripComments cat grep\n\n'
requires=$'throwArgument decorate validate quoteGrepPattern bashStripComments cat grep\n'
return_code=$'0 - Function is used within the file\n1 - Function is *not* used within the file\n'
sourceFile="bin/build/tools/bash.sh"
sourceHash="112376f9f627c10da9943f372ddc2bf96eecf81e"
sourceLine="316"
summary="Show function handler in files"
summaryComputed="true"
usage="bashShowUsage functionName file [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashShowUsage'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfunctionName'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfile'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mfunctionName  '$'\e''[[(value)]mString. Required. Function which should be called somewhere within a file.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfile          '$'\e''[[(value)]mFile. Required. File to search for function handler.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help        '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Show function handler in files'$'\n''This check is simplistic and does not verify actual coverage or code paths.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Function is used within the file'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Function is '$'\e''[[(cyan)]mnot'$'\e''[[(reset)]m used within the file'
# shellcheck disable=SC2016
helpPlain='Usage: bashShowUsage functionName file [ --help ]'$'\n'''$'\n''    functionName  String. Required. Function which should be called somewhere within a file.'$'\n''    file          File. Required. File to search for function handler.'$'\n''    --help        Flag. Optional. Display this help.'$'\n'''$'\n''Show function handler in files'$'\n''This check is simplistic and does not verify actual coverage or code paths.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Function is used within the file'$'\n''- 1 - Function is not used within the file'
documentationPath="documentation/source/tools/bash.md"
