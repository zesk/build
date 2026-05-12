#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'suffix - String. Optional. Directory suffix - created if does not exist.\n--help - Flag. Optional. Display this help.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Get the default cache directory for the documentation\n\n'
descriptionLineCount="2"
file="bin/build/tools/documentation.sh"
fn="documentationCache"
fnMarker="documentationcache"
foundNames=([0]="argument")
line="199"
rawComment=$'Get the default cache directory for the documentation\nArgument: suffix - String. Optional. Directory suffix - created if does not exist.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="0134555ea1c32d02fdc40fd9058827a280501390"
sourceLine="199"
summary="Get the default cache directory for the documentation"
summaryComputed="true"
usage="documentationCache [ suffix ] [ --help ]"
