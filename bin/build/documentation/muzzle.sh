#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sugar.sh"
argument="command - Callable. Required. Thing to muzzle."$'\n'"... - Arguments. Optional. Additional arguments."$'\n'""
base="sugar.sh"
description="Suppress stdout without piping. Handy when you just want a behavior not the output."$'\n'""
example="    muzzle pushd \"\$buildDir\""$'\n'"    catchEnvironment \"\$handler\" phpBuild || returnUndo \$? muzzle popd || return \$?"$'\n'""
exitCode="0"
file="bin/build/tools/sugar.sh"
foundNames=([0]="argument" [1]="example" [2]="stdout")
rawComment="Suppress stdout without piping. Handy when you just want a behavior not the output."$'\n'"Argument: command - Callable. Required. Thing to muzzle."$'\n'"Argument: ... - Arguments. Optional. Additional arguments."$'\n'"Example:     {fn} pushd \"\$buildDir\""$'\n'"Example:     catchEnvironment \"\$handler\" phpBuild || returnUndo \$? {fn} popd || return \$?"$'\n'"stdout: - No output from stdout ever from this function"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sugar.sh"
sourceModified="1769063211"
stdout="- No output from stdout ever from this function"$'\n'""
summary="Suppress stdout without piping. Handy when you just want a"
usage="muzzle command [ ... ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mmuzzle'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mcommand'$'\e''[0m'$'\e''[0m '$'\e''[[blue]m[ ... ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]mcommand  '$'\e''[[value]mCallable. Required. Thing to muzzle.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m...      '$'\e''[[value]mArguments. Optional. Additional arguments.'$'\e''[[reset]m'$'\n'''$'\n''Suppress stdout without piping. Handy when you just want a behavior not the output.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[code]mstdout'$'\e''[[reset]m:'$'\n''- No output from stdout ever from this function'$'\n'''$'\n''Example:'$'\n''    muzzle pushd "$buildDir"'$'\n''    catchEnvironment "$handler" phpBuild || returnUndo $? muzzle popd || return $?'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: muzzle command [ ... ]'$'\n'''$'\n''    command  Callable. Required. Thing to muzzle.'$'\n''    ...      Arguments. Optional. Additional arguments.'$'\n'''$'\n''Suppress stdout without piping. Handy when you just want a behavior not the output.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''- No output from stdout ever from this function'$'\n'''$'\n''Example:'$'\n''    muzzle pushd "$buildDir"'$'\n''    catchEnvironment "$handler" phpBuild || returnUndo $? muzzle popd || return $?'$'\n'''
