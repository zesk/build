#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--underscore - Flag. Include environment variables which begin with underscore \`_\`."$'\n'"--secure - Flag. Include environment variables which are in \`environmentSecureVariables\`"$'\n'"--keep-comments - Flag. Keep all comments in the source"$'\n'"environmentFile - File. Required. Environment file to load, evaluate, and output in raw form (Bash-compatible)."$'\n'""
base="environment.sh"
BASH_LINENO=([0]="129" [1]="963" [2]="226" [3]="237" [4]="82" [5]="65" [6]="75" [7]="22" [8]="54" [9]="129" [10]="115" [11]="65" [12]="75" [13]="16" [14]="37" [15]="978" [16]="51" [17]="129" [18]="37" [19]="226" [20]="237" [21]="358" [22]="173" [23]="123" [24]="150" [25]="154" [26]="0")
description="Load an environment file and evaluate it using bash and output the changed environment variables after running"$'\n'"Do not perform this operation on files which are untrusted."$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentCompile"
foundNames=([0]="argument" [1]="security")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
security="source"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768759812"
summary="Load an environment file and evaluate it using bash and"
usage="environmentCompile [ --underscore ] [ --secure ] [ --keep-comments ] environmentFile"
