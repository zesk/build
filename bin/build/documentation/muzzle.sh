#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="sugar.sh"
description="Suppress stdout without piping. Handy when you just want a behavior not the output."$'\n'"Argument: command - Callable. Required. Thing to muzzle."$'\n'"Argument: ... - Arguments. Optional. Additional arguments."$'\n'"Example:     {fn} pushd \"\$buildDir\""$'\n'"Example:     catchEnvironment \"\$handler\" phpBuild || returnUndo \$? {fn} popd || return \$?"$'\n'"stdout: - No output from stdout ever from this function"$'\n'""
file="bin/build/tools/sugar.sh"
foundNames=()
rawComment="Suppress stdout without piping. Handy when you just want a behavior not the output."$'\n'"Argument: command - Callable. Required. Thing to muzzle."$'\n'"Argument: ... - Arguments. Optional. Additional arguments."$'\n'"Example:     {fn} pushd \"\$buildDir\""$'\n'"Example:     catchEnvironment \"\$handler\" phpBuild || returnUndo \$? {fn} popd || return \$?"$'\n'"stdout: - No output from stdout ever from this function"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sugar.sh"
sourceHash="661eda875f626c8591389d4c5e16fe409793c6ba"
summary="Suppress stdout without piping. Handy when you just want a"
usage="muzzle"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mmuzzle'$'\e''[0m'$'\n'''$'\n''Suppress stdout without piping. Handy when you just want a behavior not the output.'$'\n''Argument: command - Callable. Required. Thing to muzzle.'$'\n''Argument: ... - Arguments. Optional. Additional arguments.'$'\n''Example:     muzzle pushd "$buildDir"'$'\n''Example:     catchEnvironment "$handler" phpBuild || returnUndo $? muzzle popd || return $?'$'\n''stdout: - No output from stdout ever from this function'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: muzzle'$'\n'''$'\n''Suppress stdout without piping. Handy when you just want a behavior not the output.'$'\n''Argument: command - Callable. Required. Thing to muzzle.'$'\n''Argument: ... - Arguments. Optional. Additional arguments.'$'\n''Example:     muzzle pushd "$buildDir"'$'\n''Example:     catchEnvironment "$handler" phpBuild || returnUndo $? muzzle popd || return $?'$'\n''stdout: - No output from stdout ever from this function'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.431
