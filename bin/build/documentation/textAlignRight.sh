#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Format text and align it right using spaces."$'\n'"Summary: align text right"$'\n'"Argument: characterWidth - Characters to align right"$'\n'"Argument: text ... - Text to align right"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     printf \"%s: %s\\n\" \"\$(textAlignRight 20 Name)\" \"\$name\""$'\n'"Example:     printf \"%s: %s\\n\" \"\$(textAlignRight 20 Profession)\" \"\$occupation\""$'\n'"Example:                 Name: Juanita"$'\n'"Example:           Profession: Engineer"$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="Format text and align it right using spaces."$'\n'"Summary: align text right"$'\n'"Argument: characterWidth - Characters to align right"$'\n'"Argument: text ... - Text to align right"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     printf \"%s: %s\\n\" \"\$(textAlignRight 20 Name)\" \"\$name\""$'\n'"Example:     printf \"%s: %s\\n\" \"\$(textAlignRight 20 Profession)\" \"\$occupation\""$'\n'"Example:                 Name: Juanita"$'\n'"Example:           Profession: Engineer"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Format text and align it right using spaces."
usage="textAlignRight"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mtextAlignRight'$'\e''[0m'$'\n'''$'\n''Format text and align it right using spaces.'$'\n''Summary: align text right'$'\n''Argument: characterWidth - Characters to align right'$'\n''Argument: text ... - Text to align right'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Example:     printf "%s: %s\n" "$(textAlignRight 20 Name)" "$name"'$'\n''Example:     printf "%s: %s\n" "$(textAlignRight 20 Profession)" "$occupation"'$'\n''Example:                 Name: Juanita'$'\n''Example:           Profession: Engineer'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: textAlignRight'$'\n'''$'\n''Format text and align it right using spaces.'$'\n''Summary: align text right'$'\n''Argument: characterWidth - Characters to align right'$'\n''Argument: text ... - Text to align right'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Example:     printf "%s: %s\n" "$(textAlignRight 20 Name)" "$name"'$'\n''Example:     printf "%s: %s\n" "$(textAlignRight 20 Profession)" "$occupation"'$'\n''Example:                 Name: Juanita'$'\n''Example:           Profession: Engineer'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.511
