#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="none"
base="host.sh"
description="Get the full hostname on the current platform."$'\n'"Formerly \`hostname\`\`Full\`."$'\n'""
file="bin/build/tools/host.sh"
fn="networkNameFull"
foundNames=([0]="summary" [1]="requires")
line="13"
lowerFn="networknamefull"
rawComment="Summary: Platform-agnostic host name"$'\n'"Get the full hostname on the current platform."$'\n'"Formerly \`hostname\`\`Full\`."$'\n'"Requires: helpArgument __hostname executableRequire catchEnvironment"$'\n'""$'\n'""
requires="helpArgument __hostname executableRequire catchEnvironment"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/host.sh"
sourceHash="c4d99e3fa9a061641119ff582f5b8c9de0ed6f31"
sourceLine="13"
summary="Platform-agnostic host name"$'\n'""
usage="networkNameFull"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mnetworkNameFull'$'\e''[0m'$'\n'''$'\n''Get the full hostname on the current platform.'$'\n''Formerly '$'\e''[[(code)]mhostname'$'\e''[[(reset)]m'$'\e''[[(code)]mFull'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: networkNameFull'$'\n'''$'\n''Get the full hostname on the current platform.'$'\n''Formerly hostnameFull.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/network.md"
