#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-08
# shellcheck disable=SC2034
argument="command - Callable. Required. Thing to muzzle."$'\n'"... - Arguments. Optional. Additional arguments."$'\n'""
base="sugar.sh"
description="Suppress return code without piping. Handy when using diff to generate text"$'\n'""
example="    muzzleReturn diff -U0 \"\$buildDir\""$'\n'""
file="bin/build/tools/sugar.sh"
fn="muzzleReturn"
foundNames=([0]="summary" [1]="argument" [2]="example" [3]="return_code")
rawComment="Summary: Suppress return codes"$'\n'"Suppress return code without piping. Handy when using diff to generate text"$'\n'"Argument: command - Callable. Required. Thing to muzzle."$'\n'"Argument: ... - Arguments. Optional. Additional arguments."$'\n'"Example:     {fn} diff -U0 \"\$buildDir\""$'\n'"Return Code: 0 - Always"$'\n'""$'\n'""
return_code="0 - Always"$'\n'""
sourceFile="bin/build/tools/sugar.sh"
sourceHash="6c1b25e84cf38f47c9e5d60da397593419cd5433"
summary="Suppress return codes"$'\n'""
usage="muzzleReturn command [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmuzzleReturn'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mcommand'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mcommand  '$'\e''[[(value)]mCallable. Required. Thing to muzzle.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m...      '$'\e''[[(value)]mArguments. Optional. Additional arguments.'$'\e''[[(reset)]m'$'\n'''$'\n''Suppress return code without piping. Handy when using diff to generate text'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Always'$'\n'''$'\n''Example:'$'\n''    muzzleReturn diff -U0 "$buildDir"'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: muzzleReturn command [ ... ]'$'\n'''$'\n''    command  Callable. Required. Thing to muzzle.'$'\n''    ...      Arguments. Optional. Additional arguments.'$'\n'''$'\n''Suppress return code without piping. Handy when using diff to generate text'$'\n'''$'\n''Return codes:'$'\n''- 0 - Always'$'\n'''$'\n''Example:'$'\n''    muzzleReturn diff -U0 "$buildDir"'$'\n'''
