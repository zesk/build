#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
##
applicationFile="bin/build/tools/documentation.sh"
argument="--settings - Flag. Optional. \`matchText\` is a function name. Outputs a file name containing function settings"$'\n'"--comment - Flag. Optional. \`matchText\` is a function name. Outputs a file name containing function settings"$'\n'"--source - Flag. Optional. \`matchText\` is a function name. Outputs the source code path to where the function is defined"$'\n'"--line - Flag. Optional. \`matchText\` is a function name. Outputs the source code line where the function is defined"$'\n'"--combined - Flag. Optional. \`matchText\` is a function name. Outputs the source code path and line where the function is defined as \`path:line\`"$'\n'"--file - Flag. Optional. \`matchText\` is a file name. Find files which match this base file name."$'\n'"matchText - String. Token to look up in the index."$'\n'""
base="documentation.sh"
description="Looks up information in the function index"$'\n'"##"$'\n'""
file="bin/build/tools/documentation.sh"
fn="documentationIndexLookup"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/documentation.sh"
sourceModified="1768710514"
summary="Looks up information in the function index"
usage="documentationIndexLookup [ --settings ] [ --comment ] [ --source ] [ --line ] [ --combined ] [ --file ] [ matchText ]"
