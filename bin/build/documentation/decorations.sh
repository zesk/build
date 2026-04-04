#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-04
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="core.sh"
description="Output a list of build-in decoration styles, one per line"$'\n'""
file="bin/build/tools/decorate/core.sh"
fn="decorations"
foundNames=([0]="argument" [1]="requires")
rawComment="Output a list of build-in decoration styles, one per line"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Requires: __help convertValue"$'\n'""$'\n'""
requires="__help convertValue"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decorate/core.sh"
sourceHash="731c17d638fbcc1823d61f677aa38d3b0fded897"
summary="Output a list of build-in decoration styles, one per line"
summaryComputed="true"
usage="decorations [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdecorations'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Output a list of build-in decoration styles, one per line'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: decorations [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Output a list of build-in decoration styles, one per line'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
