#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/test.sh"
apt_get="xxd"$'\n'""
argument="none"
base="test.sh"
depends="xxd"$'\n'""
description="Dumps output as hex"$'\n'""
file="bin/build/tools/test.sh"
foundNames=([0]="depends" [1]="apt_get" [2]="stdin" [3]="stdout")
rawComment="Dumps output as hex"$'\n'"Depends: xxd"$'\n'"apt-get: xxd"$'\n'"stdin: binary"$'\n'"stdout: formatted output set to ideal \`consoleColumns\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/test.sh"
sourceModified="1769063211"
stdin="binary"$'\n'""
stdout="formatted output set to ideal \`consoleColumns\`"$'\n'""
summary="Dumps output as hex"
usage="dumpBinary"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdumpBinary'$'\e''[0m'$'\n'''$'\n''Dumps output as hex'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''binary'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''formatted output set to ideal '$'\e''[[(code)]mconsoleColumns'$'\e''[[(reset)]m'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dumpBinary'$'\n'''$'\n''Dumps output as hex'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''binary'$'\n'''$'\n''Writes to stdout:'$'\n''formatted output set to ideal consoleColumns'$'\n'''
# elapsed 0.406
