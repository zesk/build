#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/prompt.sh"
argument="colorScheme - String. Optional. Color scheme to choose: \`light\`, \`dark\`, \`forest\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="prompt.sh"
description="Color schemes for prompts"$'\n'"Options are:"$'\n'"- forest"$'\n'"- light (default)"$'\n'"- dark"$'\n'""
exitCode="0"
file="bin/build/tools/prompt.sh"
foundNames=([0]="argument")
rawComment="Color schemes for prompts"$'\n'"Options are:"$'\n'"- forest"$'\n'"- light (default)"$'\n'"- dark"$'\n'"Argument: colorScheme - String. Optional. Color scheme to choose: \`light\`, \`dark\`, \`forest\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769063211"
summary="Color schemes for prompts"
usage="bashPromptColorScheme [ colorScheme ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mbashPromptColorScheme'$'\e''[0m '$'\e''[[blue]m[ colorScheme ]'$'\e''[0m '$'\e''[[blue]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]mcolorScheme  '$'\e''[[value]mString. Optional. Color scheme to choose: '$'\e''[[code]mlight'$'\e''[[reset]m, '$'\e''[[code]mdark'$'\e''[[reset]m, '$'\e''[[code]mforest'$'\e''[[reset]m'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--help       '$'\e''[[value]mFlag. Optional. Display this help.'$'\e''[[reset]m'$'\n'''$'\n''Color schemes for prompts'$'\n''Options are:'$'\n''- forest'$'\n''- light (default)'$'\n''- dark'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashPromptColorScheme [ colorScheme ] [ --help ]'$'\n'''$'\n''    colorScheme  String. Optional. Color scheme to choose: light, dark, forest'$'\n''    --help       Flag. Optional. Display this help.'$'\n'''$'\n''Color schemes for prompts'$'\n''Options are:'$'\n''- forest'$'\n''- light (default)'$'\n''- dark'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
