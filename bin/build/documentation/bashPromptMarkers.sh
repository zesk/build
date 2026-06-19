#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\nprefix - EmptyString. Optional. Prefix for all prompts.\nsuffix - EmptyString. Optional. Suffix for all prompts.\n'
base="prompt.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Set markers for terminal integration; these markers are terminal commands which mark the start and finish of the bash prompt for easier text selection by\nsome terminals.\nOutputs the current marker settings, one per line (0, 1, or 2 lines will be output).\n\n'
descriptionLineCount="4"
file="bin/build/tools/prompt.sh"
fn="bashPromptMarkers"
fnMarker="bashpromptmarkers"
foundNames=([0]="summary" [1]="argument")
line="129"
rawComment=$'Summary: Set markers for terminal integration\nSet markers for terminal integration; these markers are terminal commands which mark the start and finish of the bash prompt for easier text selection by\nsome terminals.\nArgument: --help - Flag. Optional. Display this help.\nArgument: prefix - EmptyString. Optional. Prefix for all prompts.\nArgument: suffix - EmptyString. Optional. Suffix for all prompts.\nOutputs the current marker settings, one per line (0, 1, or 2 lines will be output).\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/prompt.sh"
sourceHash="327354bff34979cd168a58de2b82b2b19b4cf694"
sourceLine="129"
summary="Set markers for terminal integration"
summaryComputed=""
usage="bashPromptMarkers [ --help ] [ prefix ] [ suffix ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashPromptMarkers'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ prefix ]'$'\e''[0m '$'\e''[[(blue)]m[ suffix ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mprefix  '$'\e''[[(value)]mEmptyString. Optional. Prefix for all prompts.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]msuffix  '$'\e''[[(value)]mEmptyString. Optional. Suffix for all prompts.'$'\e''[[(reset)]m'$'\n'''$'\n''Set markers for terminal integration; these markers are terminal commands which mark the start and finish of the bash prompt for easier text selection by'$'\n''some terminals.'$'\n''Outputs the current marker settings, one per line (0, 1, or 2 lines will be output).'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashPromptMarkers [ --help ] [ prefix ] [ suffix ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    prefix  EmptyString. Optional. Prefix for all prompts.'$'\n''    suffix  EmptyString. Optional. Suffix for all prompts.'$'\n'''$'\n''Set markers for terminal integration; these markers are terminal commands which mark the start and finish of the bash prompt for easier text selection by'$'\n''some terminals.'$'\n''Outputs the current marker settings, one per line (0, 1, or 2 lines will be output).'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/prompt.md"
