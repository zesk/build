#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="directoryPath ... - One or more directories to create"$'\n'"--help - Flag. Optional. Display this help."$'\n'"--mode fileMode - String. Optional. Enforce the directory mode for \`mkdir --mode\` and \`chmod\`. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to \`-\` to reset to no value."$'\n'"--owner ownerName - String. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to \`-\` to reset to no value."$'\n'""
base="directory.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Given a list of directories, ensure they exist and create them if they do not."$'\n'""$'\n'""
descriptionLineCount="2"
example="    directoryRequire \"\$cachePath\""$'\n'""
file="bin/build/tools/directory.sh"
fn="directoryRequire"
fnMarker="directoryrequire"
foundNames=([0]="argument" [1]="example" [2]="requires")
line="194"
rawComment="Given a list of directories, ensure they exist and create them if they do not."$'\n'"Argument: directoryPath ... - One or more directories to create"$'\n'"Example:     {fn} \"\$cachePath\""$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --mode fileMode - String. Optional. Enforce the directory mode for \`mkdir --mode\` and \`chmod\`. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to \`-\` to reset to no value."$'\n'"Argument: --owner ownerName - String. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to \`-\` to reset to no value."$'\n'"Requires: throwArgument usageArgumentFunction usageArgumentString decorate catchEnvironment dirname"$'\n'"Requires: chmod chown"$'\n'""$'\n'""
requires="throwArgument usageArgumentFunction usageArgumentString decorate catchEnvironment dirname"$'\n'"chmod chown"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceHash="da838a55948477df4605f58aff4c29b4f13319f7"
sourceLine="194"
summary="Given a list of directories, ensure they exist and create"
summaryComputed="true"
usage="directoryRequire [ directoryPath ... ] [ --help ] [ --mode fileMode ] [ --owner ownerName ]"
