#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="vendor.sh"
description="Open a file in a shell using the program we are using. Supports VSCode and PHPStorm."$'\n'"Environment: EDITOR - Used as a default editor (first)"$'\n'"Environment: VISUAL - Used as another default editor (last)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""
file="bin/build/tools/vendor.sh"
foundNames=()
rawComment="Open a file in a shell using the program we are using. Supports VSCode and PHPStorm."$'\n'"Environment: EDITOR - Used as a default editor (first)"$'\n'"Environment: VISUAL - Used as another default editor (last)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/vendor.sh"
sourceHash="a00ec5f768f6e94f4baef8adcc9e53d11158fb5a"
summary="Open a file in a shell using the program we"
usage="contextOpen"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcontextOpen'$'\e''[0m'$'\n'''$'\n''Open a file in a shell using the program we are using. Supports VSCode and PHPStorm.'$'\n''Environment: EDITOR - Used as a default editor (first)'$'\n''Environment: VISUAL - Used as another default editor (last)'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: contextOpen'$'\n'''$'\n''Open a file in a shell using the program we are using. Supports VSCode and PHPStorm.'$'\n''Environment: EDITOR - Used as a default editor (first)'$'\n''Environment: VISUAL - Used as another default editor (last)'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.47
