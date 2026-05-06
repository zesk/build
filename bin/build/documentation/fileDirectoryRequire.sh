#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--mode fileMode - String. Optional. Enforce the directory mode for \`mkdir --mode\` and \`chmod\`. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to \`-\` to reset to no value."$'\n'"--owner ownerName - String. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to \`-\` to reset to no value."$'\n'"fileDirectory ... - FileDirectory. Required. Test if file directory exists (file does not have to exist)"$'\n'""
base="directory.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Given a list of files, ensure their parent directories exist"$'\n'""$'\n'"Creates the directories for all files passed in."$'\n'""$'\n'""
descriptionLineCount="4"
example="    logFile=./.build/\$me.log"$'\n'"    fileDirectoryRequire \"\$logFile\""$'\n'""
file="bin/build/tools/directory.sh"
fn="fileDirectoryRequire"
fnMarker="filedirectoryrequire"
foundNames=([0]="example" [1]="argument" [2]="requires")
line="119"
logFile=""
rawComment="Given a list of files, ensure their parent directories exist"$'\n'"Creates the directories for all files passed in."$'\n'"Example:     logFile=./.build/\$me.log"$'\n'"Example:     {fn} \"\$logFile\""$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --mode fileMode - String. Optional. Enforce the directory mode for \`mkdir --mode\` and \`chmod\`. Affects directories after it in the command line; supply multiple modes and order your directories if needed. Set to \`-\` to reset to no value."$'\n'"Argument: --owner ownerName - String. Optional. Enforce the directory owner the directory. Affects all directories supplied AFTER it on the command line. Set to \`-\` to reset to no value."$'\n'"Argument: fileDirectory ... - FileDirectory. Required. Test if file directory exists (file does not have to exist)"$'\n'"Requires: chmod throwArgument usageArgumentString decorate catchEnvironment dirname"$'\n'""$'\n'""
requires="chmod throwArgument usageArgumentString decorate catchEnvironment dirname"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceHash="da838a55948477df4605f58aff4c29b4f13319f7"
sourceLine="119"
summary="Given a list of files, ensure their parent directories exist"
summaryComputed="true"
usage="fileDirectoryRequire [ --handler handler ] [ --help ] [ --mode fileMode ] [ --owner ownerName ] fileDirectory ..."
