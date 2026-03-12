#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="libraryRelativePath - Path. Required. Path to library source file."$'\n'"command - Callable. Optional. Command to run after loading the library."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Run or source one or more bash scripts and load any defined functions into the current context."$'\n'"Has security implications - only load trusted code sources and prevent user injection of bash source code into your applications."$'\n'""
file="bin/build/tools/bash.sh"
fn="bashLibrary"
foundNames=([0]="summary" [1]="security" [2]="argument")
rawComment="Summary: Run or source a library"$'\n'"Run or source one or more bash scripts and load any defined functions into the current context."$'\n'"Security: Loads code"$'\n'"Has security implications - only load trusted code sources and prevent user injection of bash source code into your applications."$'\n'"Argument: libraryRelativePath - Path. Required. Path to library source file."$'\n'"Argument: command - Callable. Optional. Command to run after loading the library."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
security="Loads code"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="f595398f728c584ee7c7e2255d6ece3e08b0d67d"
summary="Run or source a library"$'\n'""
usage="bashLibrary libraryRelativePath [ command ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
