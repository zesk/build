#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="bash.sh"
description="Summary: Run or source a library"$'\n'"Run or source one or more bash scripts and load any defined functions into the current context."$'\n'"Security: Loads code"$'\n'"Has security implications - only load trusted code sources and prevent user injection of bash source code into your applications."$'\n'"Argument: libraryRelativePath - Path. Required. Path to library source file."$'\n'"Argument: command - Callable. Optional. Command to run after loading the library."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""
file="bin/build/tools/bash.sh"
foundNames=()
rawComment="Summary: Run or source a library"$'\n'"Run or source one or more bash scripts and load any defined functions into the current context."$'\n'"Security: Loads code"$'\n'"Has security implications - only load trusted code sources and prevent user injection of bash source code into your applications."$'\n'"Argument: libraryRelativePath - Path. Required. Path to library source file."$'\n'"Argument: command - Callable. Optional. Command to run after loading the library."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="c27f4788f9122cfbb778e66b32894938a8ca0ace"
summary="Summary: Run or source a library"
usage="bashLibrary"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashLibrary'$'\e''[0m'$'\n'''$'\n''Summary: Run or source a library'$'\n''Run or source one or more bash scripts and load any defined functions into the current context.'$'\n''Security: Loads code'$'\n''Has security implications - only load trusted code sources and prevent user injection of bash source code into your applications.'$'\n''Argument: libraryRelativePath - Path. Required. Path to library source file.'$'\n''Argument: command - Callable. Optional. Command to run after loading the library.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashLibrary'$'\n'''$'\n''Summary: Run or source a library'$'\n''Run or source one or more bash scripts and load any defined functions into the current context.'$'\n''Security: Loads code'$'\n''Has security implications - only load trusted code sources and prevent user injection of bash source code into your applications.'$'\n''Argument: libraryRelativePath - Path. Required. Path to library source file.'$'\n''Argument: command - Callable. Optional. Command to run after loading the library.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.45
