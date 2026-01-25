#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/platform.sh"
argument="none"
base="platform.sh"
credits="Eric Pement"$'\n'""
depends="awk"$'\n'""
description="Reverses a pipe's input lines to output using an awk trick."$'\n'"Not recommended on big files."$'\n'""
exitCode="0"
file="bin/build/tools/platform.sh"
foundNames=([0]="summary" [1]="source" [2]="credits" [3]="depends")
rawComment="Reverses a pipe's input lines to output using an awk trick."$'\n'"Not recommended on big files."$'\n'"Summary: Reverse output lines"$'\n'"Source: https://web.archive.org/web/20090208232311/http://student.northpark.edu/pemente/awk/awk1line.txt"$'\n'"Credits: Eric Pement"$'\n'"Depends: awk"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="https://web.archive.org/web/20090208232311/http://student.northpark.edu/pemente/awk/awk1line.txt"$'\n'""
sourceModified="1769184734"
summary="Reverse output lines"$'\n'""
usage="fileReverseLines"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mfileReverseLines'$'\e''[0m'$'\n'''$'\n''Reverses a pipe'\''s input lines to output using an awk trick.'$'\n''Not recommended on big files.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileReverseLines'$'\n'''$'\n''Reverses a pipe'\''s input lines to output using an awk trick.'$'\n''Not recommended on big files.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
