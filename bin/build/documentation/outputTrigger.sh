#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
# shellcheck source=/dev/null
applicationFile="bin/build/tools/debug.sh"
argument="--help - Help"$'\n'"--verbose -  Flag. Optional.Verbose messages when no errors exist."$'\n'"--name name - String. Optional. Name for verbose mode."$'\n'""
base="debug.sh"
description="Check output for content and trigger environment error if found"$'\n'"Usage {fn} [ --help ] [ --verbose ] [ --name name ]"$'\n'"# shellcheck source=/dev/null"$'\n'""
example="    source \"\$include\" > >(outputTrigger source \"\$include\") || return \$?"$'\n'""
file="bin/build/tools/debug.sh"
fn="outputTrigger"
foundNames=([0]="argument" [1]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/debug.sh"
sourceModified="1768687749"
summary="Check output for content and trigger environment error if found"
usage="outputTrigger [ --help ] [ --verbose ] [ --name name ]"
