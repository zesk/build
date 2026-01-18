#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/dump.sh"
argument="--symbol symbol - String. Optional. Symbol to place before each line. (Blank is ok)."$'\n'"--tail - Flag. Optional.Show the tail of the file and not the head when not enough can be shown."$'\n'"--head - Flag. Optional.Show the head of the file when not enough can be shown. (default)"$'\n'"--lines - UnsignedInteger. Optional.Number of lines to show."$'\n'"--vanish file - UnsignedInteger. Optional.Number of lines to show."$'\n'"name - String. Optional. The item name or title of this output."$'\n'""
base="dump.sh"
description="Dump a pipe with a title and stats"$'\n'""
file="bin/build/tools/dump.sh"
fn="dumpPipe"
foundNames=([0]="argument" [1]="stdin" [2]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/dump.sh"
sourceModified="1768695708"
stdin="text"$'\n'""
stdout="formatted text for debugging"$'\n'""
summary="Dump a pipe with a title and stats"
usage="dumpPipe [ --symbol symbol ] [ --tail ] [ --head ] [ --lines ] [ --vanish file ] [ name ]"
