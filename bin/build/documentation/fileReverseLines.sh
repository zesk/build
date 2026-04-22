#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="none"
base="platform.sh"
credits="Eric Pement"$'\n'""
depends="awk"$'\n'""
description="Reverses a pipe's input lines to output using an awk trick."$'\n'"Not recommended on big files."$'\n'""
file="bin/build/tools/platform.sh"
fn="fileReverseLines"
foundNames=([0]="summary" [1]="source" [2]="credits" [3]="depends")
line="106"
lowerFn="filereverselines"
rawComment="Reverses a pipe's input lines to output using an awk trick."$'\n'"Not recommended on big files."$'\n'"Summary: Reverse output lines"$'\n'"Source: https://web.archive.org/web/20090208232311/http://student.northpark.edu/pemente/awk/awk1line.txt"$'\n'"Credits: Eric Pement"$'\n'"Depends: awk"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="https://web.archive.org/web/20090208232311/http://student.northpark.edu/pemente/awk/awk1line.txt"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceHash="097e41ee15602cdab3bc28d8a420362c8b93b425"
sourceLine="106"
summary="Reverse output lines"$'\n'""
usage="fileReverseLines"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mfileReverseLines'$'\e''[0m'$'\n'''$'\n''Reverses a pipe'\''s input lines to output using an awk trick.'$'\n''Not recommended on big files.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: fileReverseLines'$'\n'''$'\n''Reverses a pipe'\''s input lines to output using an awk trick.'$'\n''Not recommended on big files.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
documentationPath="documentation/source/tools/file.md"
