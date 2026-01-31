#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="vendor.sh"
description="Show the current editor being used as a text string"$'\n'"Return Code: 1 - If no editor or running program can be determined"$'\n'"Environment: EDITOR - Used as a default editor (first)"$'\n'"Environment: VISUAL - Used as another default editor (last)"$'\n'""
file="bin/build/tools/vendor.sh"
foundNames=()
rawComment="Show the current editor being used as a text string"$'\n'"Return Code: 1 - If no editor or running program can be determined"$'\n'"Environment: EDITOR - Used as a default editor (first)"$'\n'"Environment: VISUAL - Used as another default editor (last)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/vendor.sh"
sourceHash="a00ec5f768f6e94f4baef8adcc9e53d11158fb5a"
summary="Show the current editor being used as a text string"
usage="contextShow"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mcontextShow'$'\e''[0m'$'\n'''$'\n''Show the current editor being used as a text string'$'\n''Return Code: 1 - If no editor or running program can be determined'$'\n''Environment: EDITOR - Used as a default editor (first)'$'\n''Environment: VISUAL - Used as another default editor (last)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: contextShow'$'\n'''$'\n''Show the current editor being used as a text string'$'\n''Return Code: 1 - If no editor or running program can be determined'$'\n''Environment: EDITOR - Used as a default editor (first)'$'\n''Environment: VISUAL - Used as another default editor (last)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.495
