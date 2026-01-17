#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/directory.sh"
argument="--help -  Flag. Optional.Display this help."$'\n'"--mode fileMode - String. Optional. Enforce the directory mode for \`mkdir --mode\` and \`chmod\`. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to \`-\` to reset to no value."$'\n'"--owner ownerName - String. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to \`-\` to reset to no value."$'\n'"fileDirectory ... - FileDirectory. Required. Test if file directory exists (file does not have to exist)"$'\n'""
base="directory.sh"
description="Given a list of files, ensure their parent directories exist"$'\n'""$'\n'"Creates the directories for all files passed in."$'\n'""$'\n'""
example="    logFile=./.build/\$me.log"$'\n'"    fileDirectoryRequire \"\$logFile\""$'\n'""
file="bin/build/tools/directory.sh"
fn="fileDirectoryRequire"
foundNames=([0]="example" [1]="argument" [2]="requires")
requires="chmod throwArgument usageArgumentString decorate catchEnvironment dirname"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/directory.sh"
sourceModified="1768683853"
summary="Given a list of files, ensure their parent directories exist"
usage="fileDirectoryRequire [ --help ] [ --mode fileMode ] [ --owner ownerName ] fileDirectory ..."
