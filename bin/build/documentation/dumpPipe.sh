#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/dump.sh"
argument="--symbol symbol - String. Optional. Symbol to place before each line. (Blank is ok)."$'\n'"--tail - Flag. Optional. Show the tail of the file and not the head when not enough can be shown."$'\n'"--head - Flag. Optional. Show the head of the file when not enough can be shown. (default)"$'\n'"--lines - UnsignedInteger. Optional. Number of lines to show."$'\n'"--vanish file - UnsignedInteger. Optional. Number of lines to show."$'\n'"name - String. Optional. The item name or title of this output."$'\n'""
base="dump.sh"
description="Dump a pipe with a title and stats"$'\n'""
exitCode="0"
file="bin/build/tools/dump.sh"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
rawComment="Dump a pipe with a title and stats"$'\n'"Argument: --symbol symbol - String. Optional. Symbol to place before each line. (Blank is ok)."$'\n'"Argument: --tail - Flag. Optional. Show the tail of the file and not the head when not enough can be shown."$'\n'"Argument: --head - Flag. Optional. Show the head of the file when not enough can be shown. (default)"$'\n'"Argument: --lines - UnsignedInteger. Optional. Number of lines to show."$'\n'"Argument: --vanish file - UnsignedInteger. Optional. Number of lines to show."$'\n'"Argument: name - String. Optional. The item name or title of this output."$'\n'"stdin: text"$'\n'"stdout: formatted text for debugging"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/dump.sh"
sourceModified="1769184734"
stdin="text"$'\n'""
stdout="formatted text for debugging"$'\n'""
summary="Dump a pipe with a title and stats"
usage="dumpPipe [ --symbol symbol ] [ --tail ] [ --head ] [ --lines ] [ --vanish file ] [ name ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mdumpPipe'$'\e''[0m '$'\e''[[blue]m[ --symbol symbol ]'$'\e''[0m '$'\e''[[blue]m[ --tail ]'$'\e''[0m '$'\e''[[blue]m[ --head ]'$'\e''[0m '$'\e''[[blue]m[ --lines ]'$'\e''[0m '$'\e''[[blue]m[ --vanish file ]'$'\e''[0m '$'\e''[[blue]m[ name ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]m--symbol symbol  '$'\e''[[value]mString. Optional. Symbol to place before each line. (Blank is ok).'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--tail           '$'\e''[[value]mFlag. Optional. Show the tail of the file and not the head when not enough can be shown.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--head           '$'\e''[[value]mFlag. Optional. Show the head of the file when not enough can be shown. (default)'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--lines          '$'\e''[[value]mUnsignedInteger. Optional. Number of lines to show.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--vanish file    '$'\e''[[value]mUnsignedInteger. Optional. Number of lines to show.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]mname             '$'\e''[[value]mString. Optional. The item name or title of this output.'$'\e''[[reset]m'$'\n'''$'\n''Dump a pipe with a title and stats'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[code]mstdin'$'\e''[[reset]m:'$'\n''text'$'\n'''$'\n''Writes to '$'\e''[[code]mstdout'$'\e''[[reset]m:'$'\n''formatted text for debugging'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dumpPipe [ --symbol symbol ] [ --tail ] [ --head ] [ --lines ] [ --vanish file ] [ name ]'$'\n'''$'\n''    --symbol symbol  String. Optional. Symbol to place before each line. (Blank is ok).'$'\n''    --tail           Flag. Optional. Show the tail of the file and not the head when not enough can be shown.'$'\n''    --head           Flag. Optional. Show the head of the file when not enough can be shown. (default)'$'\n''    --lines          UnsignedInteger. Optional. Number of lines to show.'$'\n''    --vanish file    UnsignedInteger. Optional. Number of lines to show.'$'\n''    name             String. Optional. The item name or title of this output.'$'\n'''$'\n''Dump a pipe with a title and stats'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''text'$'\n'''$'\n''Writes to stdout:'$'\n''formatted text for debugging'$'\n'''
