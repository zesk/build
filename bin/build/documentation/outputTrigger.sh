#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
# shellcheck source=/dev/null
# shellcheck source=/dev/null
argument="--help - Help"$'\n'"--verbose - Flag. Optional. Verbose messages when no errors exist."$'\n'"--name name - String. Optional. Name for verbose mode."$'\n'""
base="debug.sh"
description="Check output for content and trigger environment error if found"$'\n'"Usage {fn} [ --help ] [ --verbose ] [ --name name ]"$'\n'"# shellcheck source=/dev/null"$'\n'""
example="    source \"\$include\" > >(outputTrigger source \"\$include\") || return \$?"$'\n'""
file="bin/build/tools/debug.sh"
foundNames=([0]="argument" [1]="example")
rawComment="Check output for content and trigger environment error if found"$'\n'"Usage {fn} [ --help ] [ --verbose ] [ --name name ]"$'\n'"Argument: --help - Help"$'\n'"Argument: --verbose - Flag. Optional. Verbose messages when no errors exist."$'\n'"Argument: --name name - String. Optional. Name for verbose mode."$'\n'"# shellcheck source=/dev/null"$'\n'"Example:     source \"\$include\" > >(outputTrigger source \"\$include\") || return \$?"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="f288b9b3b91991d05bd6676a6b9ef73b9e0296b8"
summary="Check output for content and trigger environment error if found"
usage="outputTrigger [ --help ] [ --verbose ] [ --name name ]"
