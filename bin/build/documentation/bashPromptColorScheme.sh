#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument=$'colorScheme - String. Optional. Color scheme to choose: `light`, `dark`, `forest`\n--help - Flag. Optional. Display this help.\n'
base="prompt.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Color schemes for prompts. Use this as an argument to `bashPrompt --colors`.\n\nOptions are:\n\n- forest\n- light (default)\n- dark\n\n'
descriptionLineCount="8"
example=$'    bashPrompt --colors "$(bashPromptColorScheme dark)"\n'
file="bin/build/tools/prompt.sh"
fn="bashPromptColorScheme"
fnMarker="bashpromptcolorscheme"
foundNames=([0]="summary" [1]="example" [2]="argument")
line="174"
rawComment=$'Summary: Color scheme values for prompts\nColor schemes for prompts. Use this as an argument to `bashPrompt --colors`.\nExample:     bashPrompt --colors "$(bashPromptColorScheme dark)"\nOptions are:\n- forest\n- light (default)\n- dark\nArgument: colorScheme - String. Optional. Color scheme to choose: `light`, `dark`, `forest`\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/prompt.sh"
sourceHash="c8be00d8dedfc8df4976cb58038790d9cdce3c69"
sourceLine="174"
summary="Color scheme values for prompts"
summaryComputed=""
usage="bashPromptColorScheme [ colorScheme ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashPromptColorScheme'$'\e''[0m '$'\e''[[(blue)]m[ colorScheme ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mcolorScheme  '$'\e''[[(value)]mString. Optional. Color scheme to choose: '$'\e''[[(code)]mlight'$'\e''[[(reset)]m, '$'\e''[[(code)]mdark'$'\e''[[(reset)]m, '$'\e''[[(code)]mforest'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help       '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Color schemes for prompts. Use this as an argument to '$'\e''[[(code)]mbashPrompt --colors'$'\e''[[(reset)]m.'$'\n'''$'\n''Options are:'$'\n'''$'\n''- forest'$'\n''- light (default)'$'\n''- dark'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Example:'$'\n''    bashPrompt --colors "$(bashPromptColorScheme dark)"'
# shellcheck disable=SC2016
helpPlain='Usage: bashPromptColorScheme [ colorScheme ] [ --help ]'$'\n'''$'\n''    colorScheme  String. Optional. Color scheme to choose: light, dark, forest'$'\n''    --help       Flag. Optional. Display this help.'$'\n'''$'\n''Color schemes for prompts. Use this as an argument to bashPrompt --colors.'$'\n'''$'\n''Options are:'$'\n'''$'\n''- forest'$'\n''- light (default)'$'\n''- dark'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Example:'$'\n''    bashPrompt --colors "$(bashPromptColorScheme dark)"'
documentationPath="documentation/source/tools/prompt.md"
