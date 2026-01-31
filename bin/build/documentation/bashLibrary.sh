#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="libraryRelativePath - Path. Required. Path to library source file."$'\n'"command - Callable. Optional. Command to run after loading the library."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Run or source one or more bash scripts and load any defined functions into the current context."$'\n'"Has security implications - only load trusted code sources and prevent user injection of bash source code into your applications."$'\n'""
file="bin/build/tools/bash.sh"
foundNames=([0]="summary" [1]="security" [2]="argument")
rawComment="Summary: Run or source a library"$'\n'"Run or source one or more bash scripts and load any defined functions into the current context."$'\n'"Security: Loads code"$'\n'"Has security implications - only load trusted code sources and prevent user injection of bash source code into your applications."$'\n'"Argument: libraryRelativePath - Path. Required. Path to library source file."$'\n'"Argument: command - Callable. Optional. Command to run after loading the library."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
security="Loads code"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="dbfb96665db1f4eb43c1d8d8c0cd2b8680385220"
summary="Run or source a library"$'\n'""
usage="bashLibrary libraryRelativePath [ command ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashLibrary'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mlibraryRelativePath'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ command ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mlibraryRelativePath  '$'\e''[[(value)]mPath. Required. Path to library source file.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mcommand              '$'\e''[[(value)]mCallable. Optional. Command to run after loading the library.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help               '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Run or source one or more bash scripts and load any defined functions into the current context.'$'\n''Has security implications - only load trusted code sources and prevent user injection of bash source code into your applications.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mbashLibrary [[(magenta)]mlibraryRelativePath [[(blue)]m[ command ] [[(blue)]m[ --help ]'$'\n'''$'\n''    [[(red)]mlibraryRelativePath  [[(value)]mPath. Required. Path to library source file.'$'\n''    [[(blue)]mcommand              [[(value)]mCallable. Optional. Command to run after loading the library.'$'\n''    [[(blue)]m--help               [[(value)]mFlag. Optional. Display this help.'$'\n'''$'\n''Run or source one or more bash scripts and load any defined functions into the current context.'$'\n''Has security implications - only load trusted code sources and prevent user injection of bash source code into your applications.'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0 - Success'$'\n''- [[(code)]m1 - Environment error'$'\n''- [[(code)]m2 - Argument error'$'\n'''
# elapsed 0.754
