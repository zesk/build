#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/directory.sh"
argument="directoryPath ... - One or more directories to create"$'\n'"--help - Flag. Optional. Display this help."$'\n'"--mode fileMode - String. Optional. Enforce the directory mode for \`mkdir --mode\` and \`chmod\`. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to \`-\` to reset to no value."$'\n'"--owner ownerName - String. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to \`-\` to reset to no value."$'\n'""
base="directory.sh"
BASH_LINENO=([0]="129" [1]="963" [2]="226" [3]="237" [4]="82" [5]="65" [6]="75" [7]="22" [8]="54" [9]="129" [10]="115" [11]="65" [12]="75" [13]="16" [14]="37" [15]="244" [16]="51" [17]="129" [18]="37" [19]="357" [20]="142" [21]="115" [22]="150" [23]="154" [24]="0")
description="Given a list of directories, ensure they exist and create them if they do not."$'\n'""$'\n'""
example="    directoryRequire \"\$cachePath\""$'\n'""
file="bin/build/tools/directory.sh"
fn="directoryRequire"
foundNames=([0]="argument" [1]="example" [2]="requires")
requires="throwArgument usageArgumentFunction usageArgumentString decorate catchEnvironment dirname"$'\n'"chmod chown"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/directory.sh"
sourceModified="1768756695"
summary="Given a list of directories, ensure they exist and create"
usage="directoryRequire [ directoryPath ... ] [ --help ] [ --mode fileMode ] [ --owner ownerName ]"
