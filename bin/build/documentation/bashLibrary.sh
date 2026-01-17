#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="libraryRelativePath - Path. Required. Path to library source file."$'\n'"command - Callable. Optional. Command to run after loading the library."$'\n'"--help -  Flag. Optional.Display this help."$'\n'""
base="bash.sh"
description="Run or source one or more bash scripts and load any defined functions into the current context."$'\n'"Has security implications - only load trusted code sources and prevent user injection of bash source code into your applications."$'\n'""
file="bin/build/tools/bash.sh"
fn="bashLibrary"
foundNames=([0]="summary" [1]="security" [2]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
security="Loads code"$'\n'""
source="bin/build/tools/bash.sh"
sourceModified="1768687447"
summary="Run or source a library"$'\n'""
usage="bashLibrary libraryRelativePath [ command ] [ --help ]"
