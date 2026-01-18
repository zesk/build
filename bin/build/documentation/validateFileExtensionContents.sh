#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/lint.sh"
argument="\`extension0\` - Required - the extension to search for (\`*.extension\`)"$'\n'"\`--\` - Separator. Required. Separates extensions from text"$'\n'"\`text0\` - String. Required. Text which must exist in each item with the extension given."$'\n'"\`--\` - Separator. Optional. Final delimiter to specify find arguments."$'\n'"findArgs - Arguments. Optional. Passed to \`find\`. Limit find to additional conditions."$'\n'""
base="lint.sh"
description="Search for item extensions and ensure that text is found in each item."$'\n'""$'\n'"This can be run on any directory tree to test files in any application."$'\n'""$'\n'"By default, any directory which begins with a dot \`.\` will be ignored."$'\n'""$'\n'"Side-effect: Errors written to stderr, status written to stdout"$'\n'"Return Code: 0 - All found files contain all text strings"$'\n'"Return Code: 1 - One or more files does not contain all text strings"$'\n'"Return Code: 2 - Arguments error (missing extension or text)"$'\n'""$'\n'""
environment="This operates in the current working directory"$'\n'""
example="    validateFileContents sh php js -- 'Widgets LLC' 'Copyright &copy; 2026'"$'\n'""
file="bin/build/tools/lint.sh"
fn="validateFileExtensionContents"
foundNames=([0]="example" [1]="argument" [2]="environment" [3]="summary")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/lint.sh"
sourceModified="1768759461"
summary="Check files for the existence of a string"$'\n'""
usage="validateFileExtensionContents [ \`extension0\` ] \`--\` \`text0\` [ \`--\` ] [ findArgs ]"
