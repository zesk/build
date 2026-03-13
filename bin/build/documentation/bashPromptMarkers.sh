#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"prefix - EmptyString. Optional. Prefix for all prompts."$'\n'"suffix - EmptyString. Optional. Suffix for all prompts."$'\n'""
base="prompt.sh"
description="Set markers for terminal integration"$'\n'"Outputs the current marker settings, one per line (0, 1, or 2 lines will be output)."$'\n'""
file="bin/build/tools/prompt.sh"
fn="bashPromptMarkers"
foundNames=([0]="argument")
rawComment="Set markers for terminal integration"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: prefix - EmptyString. Optional. Prefix for all prompts."$'\n'"Argument: suffix - EmptyString. Optional. Suffix for all prompts."$'\n'"Outputs the current marker settings, one per line (0, 1, or 2 lines will be output)."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/prompt.sh"
sourceHash="60ddb2349a8bd4812bf32e6721494912b17756ac"
summary="Set markers for terminal integration"
summaryComputed="true"
usage="bashPromptMarkers [ --help ] [ prefix ] [ suffix ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashPromptMarkers'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ prefix ]'$'\e''[0m '$'\e''[[(blue)]m[ suffix ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mprefix  '$'\e''[[(value)]mEmptyString. Optional. Prefix for all prompts.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]msuffix  '$'\e''[[(value)]mEmptyString. Optional. Suffix for all prompts.'$'\e''[[(reset)]m'$'\n'''$'\n''Set markers for terminal integration'$'\n''Outputs the current marker settings, one per line (0, 1, or 2 lines will be output).'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashPromptMarkers [ --help ] [ prefix ] [ suffix ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    prefix  EmptyString. Optional. Prefix for all prompts.'$'\n''    suffix  EmptyString. Optional. Suffix for all prompts.'$'\n'''$'\n''Set markers for terminal integration'$'\n''Outputs the current marker settings, one per line (0, 1, or 2 lines will be output).'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
