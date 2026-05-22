#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-21
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--path cannonPath - Directory. Optional. Run textCannon operation starting in this directory."$'\n'"fromText - Required. String of text to search for."$'\n'"toText - Required. String of text to replace."$'\n'"findArgs ... - Arguments. Optional. Any additional arguments are meant to filter files."$'\n'""
base="map.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Replace text \`fromText\` with \`toText\` in files, using \`findArgs\` to filter files if needed."$'\n'""$'\n'"This can break your files so use with caution. Blank \`searchText\` is **not allowed**."$'\n'"The term \`textCannon\` is not a mistake - it will break something at some point."$'\n'""$'\n'""
descriptionLineCount="5"
example="    textCannon master main ! -path '*/old-version/*')"$'\n'""
file="bin/build/tools/map.sh"
fn="textCannon"
fnMarker="textcannon"
foundNames=([0]="summary" [1]="example" [2]="argument" [3]="return_code")
line="481"
rawComment="Summary: Replace text \`fromText\` with \`toText\` in files"$'\n'"Replace text \`fromText\` with \`toText\` in files, using \`findArgs\` to filter files if needed."$'\n'"This can break your files so use with caution. Blank \`searchText\` is **not allowed**."$'\n'"The term \`textCannon\` is not a mistake - it will break something at some point."$'\n'"Example:     {fn} master main ! -path '*/old-version/*')"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"Argument: --path cannonPath - Directory. Optional. Run textCannon operation starting in this directory."$'\n'"Argument: fromText - Required. String of text to search for."$'\n'"Argument: toText - Required. String of text to replace."$'\n'"Argument: findArgs ... - Arguments. Optional. Any additional arguments are meant to filter files."$'\n'"Return Code: 0 - Success, no files changed"$'\n'"Return Code: 3 - At least one or more files were modified successfully"$'\n'"Return Code: 1 - --path is not a directory"$'\n'"Return Code: 1 - searchText is not blank"$'\n'"Return Code: 1 - \`fileTemporaryName\` failed"$'\n'"Return Code: 2 - Arguments are identical"$'\n'""$'\n'""
return_code="0 - Success, no files changed"$'\n'"3 - At least one or more files were modified successfully"$'\n'"1 - --path is not a directory"$'\n'"1 - searchText is not blank"$'\n'"1 - \`fileTemporaryName\` failed"$'\n'"2 - Arguments are identical"$'\n'""
sourceFile="bin/build/tools/map.sh"
sourceHash="28c85a1a2f0604d47009077a23130a3172acf6bf"
sourceLine="481"
summary="Replace text \`fromText\` with \`toText\` in files"
summaryComputed=""
usage="textCannon [ --help ] [ --handler handler ] [ --path cannonPath ] fromText toText [ findArgs ... ]"
