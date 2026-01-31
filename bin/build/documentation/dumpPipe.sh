#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="dump.sh"
description="Dump a pipe with a title and stats"$'\n'"Argument: --symbol symbol - String. Optional. Symbol to place before each line. (Blank is ok)."$'\n'"Argument: --tail - Flag. Optional. Show the tail of the file and not the head when not enough can be shown."$'\n'"Argument: --head - Flag. Optional. Show the head of the file when not enough can be shown. (default)"$'\n'"Argument: --lines - UnsignedInteger. Optional. Number of lines to show."$'\n'"Argument: --vanish file - UnsignedInteger. Optional. Number of lines to show."$'\n'"Argument: name - String. Optional. The item name or title of this output."$'\n'"stdin: text"$'\n'"stdout: formatted text for debugging"$'\n'""
file="bin/build/tools/dump.sh"
foundNames=()
rawComment="Dump a pipe with a title and stats"$'\n'"Argument: --symbol symbol - String. Optional. Symbol to place before each line. (Blank is ok)."$'\n'"Argument: --tail - Flag. Optional. Show the tail of the file and not the head when not enough can be shown."$'\n'"Argument: --head - Flag. Optional. Show the head of the file when not enough can be shown. (default)"$'\n'"Argument: --lines - UnsignedInteger. Optional. Number of lines to show."$'\n'"Argument: --vanish file - UnsignedInteger. Optional. Number of lines to show."$'\n'"Argument: name - String. Optional. The item name or title of this output."$'\n'"stdin: text"$'\n'"stdout: formatted text for debugging"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/dump.sh"
sourceHash="6a45ba93dc346627d009bc14e9582d9ccda6e36e"
summary="Dump a pipe with a title and stats"
usage="dumpPipe"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdumpPipe'$'\e''[0m'$'\n'''$'\n''Dump a pipe with a title and stats'$'\n''Argument: --symbol symbol - String. Optional. Symbol to place before each line. (Blank is ok).'$'\n''Argument: --tail - Flag. Optional. Show the tail of the file and not the head when not enough can be shown.'$'\n''Argument: --head - Flag. Optional. Show the head of the file when not enough can be shown. (default)'$'\n''Argument: --lines - UnsignedInteger. Optional. Number of lines to show.'$'\n''Argument: --vanish file - UnsignedInteger. Optional. Number of lines to show.'$'\n''Argument: name - String. Optional. The item name or title of this output.'$'\n''stdin: text'$'\n''stdout: formatted text for debugging'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dumpPipe'$'\n'''$'\n''Dump a pipe with a title and stats'$'\n''Argument: --symbol symbol - String. Optional. Symbol to place before each line. (Blank is ok).'$'\n''Argument: --tail - Flag. Optional. Show the tail of the file and not the head when not enough can be shown.'$'\n''Argument: --head - Flag. Optional. Show the head of the file when not enough can be shown. (default)'$'\n''Argument: --lines - UnsignedInteger. Optional. Number of lines to show.'$'\n''Argument: --vanish file - UnsignedInteger. Optional. Number of lines to show.'$'\n''Argument: name - String. Optional. The item name or title of this output.'$'\n''stdin: text'$'\n''stdout: formatted text for debugging'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.453
