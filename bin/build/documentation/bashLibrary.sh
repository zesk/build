#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument=$'libraryRelativePath - Path. Required. Path to library source file.\ncommand - Callable. Optional. Command to run after loading the library.\n--help - Flag. Optional. Display this help.\n'
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Run or source one or more bash scripts and load any defined functions into the current context.\nHas security implications - only load trusted code sources and prevent user injection of bash source code into your applications.\n\n'
descriptionLineCount="3"
file="bin/build/tools/bash.sh"
fn="bashLibrary"
fnMarker="bashlibrary"
foundNames=([0]="summary" [1]="security" [2]="argument")
line="161"
rawComment=$'Summary: Run or source a library\nRun or source one or more bash scripts and load any defined functions into the current context.\nSecurity: Loads code\nHas security implications - only load trusted code sources and prevent user injection of bash source code into your applications.\nArgument: libraryRelativePath - Path. Required. Path to library source file.\nArgument: command - Callable. Optional. Command to run after loading the library.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
security=$'Loads code\n'
sourceFile="bin/build/tools/bash.sh"
sourceHash="0bec62237f4e812ee319f8b7f774905396bb742b"
sourceLine="161"
summary="Run or source a library"
summaryComputed=""
usage="bashLibrary libraryRelativePath [ command ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashLibrary'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mlibraryRelativePath'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ command ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mlibraryRelativePath  '$'\e''[[(value)]mPath. Required. Path to library source file.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mcommand              '$'\e''[[(value)]mCallable. Optional. Command to run after loading the library.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help               '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Run or source one or more bash scripts and load any defined functions into the current context.'$'\n''Has security implications - only load trusted code sources and prevent user injection of bash source code into your applications.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: bashLibrary libraryRelativePath [ command ] [ --help ]'$'\n'''$'\n''    libraryRelativePath  Path. Required. Path to library source file.'$'\n''    command              Callable. Optional. Command to run after loading the library.'$'\n''    --help               Flag. Optional. Display this help.'$'\n'''$'\n''Run or source one or more bash scripts and load any defined functions into the current context.'$'\n''Has security implications - only load trusted code sources and prevent user injection of bash source code into your applications.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/bash.md"
