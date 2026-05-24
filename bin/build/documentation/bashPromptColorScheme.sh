#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'colorScheme - String. Optional. Color scheme to choose: `light`, `dark`, `forest`\n--help - Flag. Optional. Display this help.\n'
base="prompt.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Color schemes for prompts\nOptions are:\n- forest\n- light (default)\n- dark\n\n'
descriptionLineCount="6"
file="bin/build/tools/prompt.sh"
fn="bashPromptColorScheme"
fnMarker="bashpromptcolorscheme"
foundNames=([0]="argument")
line="166"
rawComment=$'Color schemes for prompts\nOptions are:\n- forest\n- light (default)\n- dark\nArgument: colorScheme - String. Optional. Color scheme to choose: `light`, `dark`, `forest`\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/prompt.sh"
sourceHash="b61c792ae723865297730f9775c4f0b5fcba937d"
sourceLine="166"
summary="Color schemes for prompts"
summaryComputed="true"
usage="bashPromptColorScheme [ colorScheme ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashPromptColorScheme'$'\e''[0m '$'\e''[[(blue)]m[ colorScheme ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mcolorScheme  '$'\e''[[(value)]mString. Optional. Color scheme to choose: '$'\e''[[(code)]mlight'$'\e''[[(reset)]m, '$'\e''[[(code)]mdark'$'\e''[[(reset)]m, '$'\e''[[(code)]mforest'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help       '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Color schemes for prompts'$'\n''Options are:'$'\n''- forest'$'\n''- light (default)'$'\n''- dark'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashPromptColorScheme [ colorScheme ] [ --help ]'$'\n'''$'\n''    colorScheme  String. Optional. Color scheme to choose: light, dark, forest'$'\n''    --help       Flag. Optional. Display this help.'$'\n'''$'\n''Color schemes for prompts'$'\n''Options are:'$'\n''- forest'$'\n''- light (default)'$'\n''- dark'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/prompt.md"
