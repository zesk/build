#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="vendor.sh"
description="Are we within the JetBrains PHPStorm terminal?"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - within the PhpStorm terminal"$'\n'"Return Code: 1 - not within the PhpStorm terminal AFAIK"$'\n'"See: contextOpen"$'\n'""
file="bin/build/tools/vendor.sh"
foundNames=()
rawComment="Are we within the JetBrains PHPStorm terminal?"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - within the PhpStorm terminal"$'\n'"Return Code: 1 - not within the PhpStorm terminal AFAIK"$'\n'"See: contextOpen"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/vendor.sh"
sourceHash="a00ec5f768f6e94f4baef8adcc9e53d11158fb5a"
summary="Are we within the JetBrains PHPStorm terminal?"
usage="isPHPStorm"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misPHPStorm'$'\e''[0m'$'\n'''$'\n''Are we within the JetBrains PHPStorm terminal?'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 0 - within the PhpStorm terminal'$'\n''Return Code: 1 - not within the PhpStorm terminal AFAIK'$'\n''See: contextOpen'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isPHPStorm'$'\n'''$'\n''Are we within the JetBrains PHPStorm terminal?'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 0 - within the PhpStorm terminal'$'\n''Return Code: 1 - not within the PhpStorm terminal AFAIK'$'\n''See: contextOpen'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.498
