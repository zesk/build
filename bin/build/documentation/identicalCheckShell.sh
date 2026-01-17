#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/identical.sh"
argument="--help -  Flag. Optional.Display this help."$'\n'"--singles singlesFiles -  File. Optional.One or more files which contain a list of allowed \`{identical}\` singles, one per line."$'\n'"--single singleToken - String. Optional. One or more tokens which cam be singles."$'\n'"--repair directory -  Directory. Optional.Any files in onr or more directories can be used to repair other files."$'\n'"--internal-only - Flag. Optional. Just do \`--internal\` repairs."$'\n'"--interactive - Flag. Optional. Interactive mode on fixing errors."$'\n'"... - Optional. Additional arguments are passed directly to \`identicalCheck\`."$'\n'""
base="identical.sh"
description="Identical check for shell files"$'\n'""$'\n'"Looks for up to three tokens in code:"$'\n'""$'\n'"- \`# \`\`{identical} tokenName 1\`"$'\n'"- \`# \`\`_{identical}_ tokenName 1\`, and"$'\n'"- \`# \`\`DOC\`\` TEMPLATE: tokenName 1\`"$'\n'""$'\n'"This allows for overlapping identical sections within templates with the intent:"$'\n'""$'\n'"- \`{identical}\` - used in most cases (not internal)"$'\n'"- \`_{identical}_\` - used in templates which must be included in {identical} templates"$'\n'"- \`__{identical}__\` - used in templates which must be included in _{identical}_ templates"$'\n'"- \`DOC\`\` TEMPLATE:\` - used in documentation templates for functions - is handled by internal document generator"$'\n'""$'\n'""
file="bin/build/tools/identical.sh"
fn="identicalCheckShell"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/identical.sh"
sourceModified="1768683999"
summary="Identical check for shell files"
usage="identicalCheckShell [ --help ] [ --singles singlesFiles ] [ --single singleToken ] [ --repair directory ] [ --internal-only ] [ --interactive ] [ ... ]"
