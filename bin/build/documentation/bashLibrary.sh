#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="libraryRelativePath - Path. Required. Path to library source file."$'\n'"command - Callable. Optional. Command to run after loading the library."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="Run or source one or more bash scripts and load any defined functions into the current context."$'\n'"Has security implications - only load trusted code sources and prevent user injection of bash source code into your applications."$'\n'""
file="bin/build/tools/bash.sh"
fn="bashLibrary"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
security="Loads code"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceModified="1768776883"
summary="Run or source a library"$'\n'""
usage="bashLibrary libraryRelativePath [ command ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashLibrary[0m [38;2;255;255;0m[35;48;2;0;0;0mlibraryRelativePath[0m[0m [94m[ command ][0m [94m[ --help ][0m

    [31mlibraryRelativePath  [1;97mPath. Required. Path to library source file.[0m
    [94mcommand              [1;97mCallable. Optional. Command to run after loading the library.[0m
    [94m--help               [1;97mFlag. Optional. Display this help.[0m

Run or source one or more bash scripts and load any defined functions into the current context.
Has security implications - only load trusted code sources and prevent user injection of bash source code into your applications.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashLibrary libraryRelativePath [ command ] [ --help ]

    libraryRelativePath  Path. Required. Path to library source file.
    command              Callable. Optional. Command to run after loading the library.
    --help               Flag. Optional. Display this help.

Run or source one or more bash scripts and load any defined functions into the current context.
Has security implications - only load trusted code sources and prevent user injection of bash source code into your applications.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
