#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/map.sh"
argument="--help - Flag. Optional.Display this help."$'\n'"--handler handler - Function. Optional.Use this error handler instead of the default error handler."$'\n'"--path cannonPath - Directory. Optional.Run cannon operation starting in this directory."$'\n'"fromText - Required. String of text to search for."$'\n'"toText - Required. String of text to replace."$'\n'"findArgs ... - Arguments. Optional.Any additional arguments are meant to filter files."$'\n'""
base="map.sh"
description="Replace text \`fromText\` with \`toText\` in files, using \`findArgs\` to filter files if needed."$'\n'""$'\n'"This can break your files so use with caution. Blank searchText is not allowed."$'\n'"The term \`cannon\` is not a mistake - it will break something at some point."$'\n'""$'\n'"Return Code: 0 - Success, no files changed"$'\n'"Return Code: 3 - At least one or more files were modified successfully"$'\n'"Return Code: 1 - --path is not a directory"$'\n'"Return Code: 1 - searchText is not blank"$'\n'"Return Code: 1 - fileTemporaryName failed"$'\n'"Return Code: 2 - Arguments are identical"$'\n'""
example="    cannon master main ! -path '*/old-version/*')"$'\n'""
file="bin/build/tools/map.sh"
fn="cannon"
foundNames=([0]="example" [1]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/map.sh"
sourceModified="1768695708"
summary="Replace text \`fromText\` with \`toText\` in files, using \`findArgs\` to"
usage="cannon [ --help ] [ --handler handler ] [ --path cannonPath ] fromText toText [ findArgs ... ]"
