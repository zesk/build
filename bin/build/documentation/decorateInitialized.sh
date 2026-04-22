#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="core.sh"
description="Is the decorate color system initialized yet?"$'\n'"Useful to set our global color environment at the top level of a script if it hasn't been initialized already."$'\n'""
file="bin/build/tools/decorate/core.sh"
fn="decorateInitialized"
foundNames=([0]="argument" [1]="requires")
line="124"
lowerFn="decorateinitialized"
rawComment="Is the decorate color system initialized yet?"$'\n'"Useful to set our global color environment at the top level of a script if it hasn't been initialized already."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: helpArgument"$'\n'""$'\n'""
requires="helpArgument"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decorate/core.sh"
sourceHash="4288b1b5dd74b1f4240bb03c3728be0a51c51aa6"
sourceLine="124"
summary="Is the decorate color system initialized yet?"
summaryComputed="true"
usage="decorateInitialized [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdecorateInitialized'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Is the decorate color system initialized yet?'$'\n''Useful to set our global color environment at the top level of a script if it hasn'\''t been initialized already.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: decorateInitialized [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Is the decorate color system initialized yet?'$'\n''Useful to set our global color environment at the top level of a script if it hasn'\''t been initialized already.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/decorate.md"
