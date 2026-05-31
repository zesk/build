#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-31
# shellcheck disable=SC2034
argument=$'pathSegment - One or more directory or file path, concatenated as path segments using `/`\n--help - Flag. Optional. Display this help.\n'
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Path to cache directory for build system.\n\nDefaults to `$XDG_CACHE_HOME/.build` unless `$XDG_CACHE_HOME` is not a directory.\n\nAppends any passed in arguments as path segments.\n\n'
descriptionLineCount="6"
environment=$'XDG_CACHE_HOME\n'
example=$'    logFile=$(buildCacheDirectory test.log)\n'
file="bin/build/tools/build.sh"
fn="buildCacheDirectory"
fnMarker="buildcachedirectory"
foundNames=([0]="example" [1]="argument" [2]="environment")
line="154"
logFile=""
rawComment=$'Path to cache directory for build system.\nDefaults to `$XDG_CACHE_HOME/.build` unless `$XDG_CACHE_HOME` is not a directory.\nAppends any passed in arguments as path segments.\nExample:     logFile=$({fn} test.log)\nArgument: pathSegment - One or more directory or file path, concatenated as path segments using `/`\nEnvironment: XDG_CACHE_HOME\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/build.sh"
sourceHash="7c3aa107c357db74a0d854defdaf7f2b17361d34"
sourceLine="154"
summary="Path to cache directory for build system."
summaryComputed="true"
usage="buildCacheDirectory [ pathSegment ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbuildCacheDirectory'$'\e''[0m '$'\e''[[(blue)]m[ pathSegment ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpathSegment  '$'\e''[[(value)]mOne or more directory or file path, concatenated as path segments using '$'\e''[[(code)]m/'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help       '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Path to cache directory for build system.'$'\n'''$'\n''Defaults to '$'\e''[[(code)]m$XDG_CACHE_HOME/.build'$'\e''[[(reset)]m unless '$'\e''[[(code)]m$XDG_CACHE_HOME'$'\e''[[(reset)]m is not a directory.'$'\n'''$'\n''Appends any passed in arguments as path segments.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- XDG_CACHE_HOME'$'\n'''$'\n''Example:'$'\n''    logFile=$(buildCacheDirectory test.log)'
# shellcheck disable=SC2016
helpPlain='Usage: buildCacheDirectory [ pathSegment ] [ --help ]'$'\n'''$'\n''    pathSegment  One or more directory or file path, concatenated as path segments using /'$'\n''    --help       Flag. Optional. Display this help.'$'\n'''$'\n''Path to cache directory for build system.'$'\n'''$'\n''Defaults to $XDG_CACHE_HOME/.build unless $XDG_CACHE_HOME is not a directory.'$'\n'''$'\n''Appends any passed in arguments as path segments.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- XDG_CACHE_HOME'$'\n'''$'\n''Example:'$'\n''    logFile=$(buildCacheDirectory test.log)'
documentationPath="documentation/source/tools/build.md"
