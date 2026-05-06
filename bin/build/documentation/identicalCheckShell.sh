#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--singles singlesFiles - File. Optional. One or more files which contain a list of allowed \`{identical}\` singles, one per line."$'\n'"--single singleToken - String. Optional. One or more tokens which cam be singles."$'\n'"--repair directory - Directory. Optional. Any files in onr or more directories can be used to repair other files."$'\n'"--internal-only - Flag. Optional. Just do \`--internal\` repairs."$'\n'"--interactive - Flag. Optional. Interactive mode on fixing errors."$'\n'"... - Arguments. Optional. Additional arguments are passed directly to \`identicalCheck\`."$'\n'""
base="identical.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Identical check for shell files"$'\n'""$'\n'"Looks for up to three tokens in code:"$'\n'""$'\n'"- \`# \`\`{identical} tokenName 1\`"$'\n'"- \`# \`\`_{identical}_ tokenName 1\`, and"$'\n'"- \`# \`\`DOC\`\` TEMPLATE: tokenName 1\`"$'\n'""$'\n'"This allows for overlapping identical sections within templates with the intent:"$'\n'""$'\n'"- \`{identical}\` - used in most cases (not internal)"$'\n'"- \`_{identical}_\` - used in templates which must be included in {identical} templates"$'\n'"- \`__{identical}__\` - used in templates which must be included in _{identical}_ templates"$'\n'"- \`DOC\`\` TEMPLATE:\` - used in documentation templates for functions - is handled by internal document generator"$'\n'""$'\n'""
descriptionLineCount="15"
file="bin/build/tools/identical.sh"
fn="identicalCheckShell"
fnMarker="identicalcheckshell"
foundNames=([0]="argument")
line="116"
rawComment="Identical check for shell files"$'\n'"Looks for up to three tokens in code:"$'\n'"- \`# \`\`{identical} tokenName 1\`"$'\n'"- \`# \`\`_{identical}_ tokenName 1\`, and"$'\n'"- \`# \`\`DOC\`\` TEMPLATE: tokenName 1\`"$'\n'"This allows for overlapping identical sections within templates with the intent:"$'\n'"- \`{identical}\` - used in most cases (not internal)"$'\n'"- \`_{identical}_\` - used in templates which must be included in {identical} templates"$'\n'"- \`__{identical}__\` - used in templates which must be included in _{identical}_ templates"$'\n'"- \`DOC\`\` TEMPLATE:\` - used in documentation templates for functions - is handled by internal document generator"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --singles singlesFiles - File. Optional. One or more files which contain a list of allowed \`{identical}\` singles, one per line."$'\n'"Argument: --single singleToken - String. Optional. One or more tokens which cam be singles."$'\n'"Argument: --repair directory - Directory. Optional. Any files in onr or more directories can be used to repair other files."$'\n'"Argument: --internal-only - Flag. Optional. Just do \`--internal\` repairs."$'\n'"Argument: --interactive - Flag. Optional. Interactive mode on fixing errors."$'\n'"Argument: ... - Arguments. Optional. Additional arguments are passed directly to \`identicalCheck\`."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/identical.sh"
sourceHash="9b062c3d858b37e9d0bb2c6dc51ad89ca20e549b"
sourceLine="116"
summary="Identical check for shell files"
summaryComputed="true"
usage="identicalCheckShell [ --help ] [ --singles singlesFiles ] [ --single singleToken ] [ --repair directory ] [ --internal-only ] [ --interactive ] [ ... ]"
