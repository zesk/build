#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output the number of columns in the terminal. Default is 80 if not able to be determined from \`TERM\`."$'\n'""$'\n'""
descriptionLineCount="2"
environment="- \`COLUMNS\` - May be defined after calling this"$'\n'"- \`LINES\` - May be defined after calling this"$'\n'""
example="    textRepeat \$(consoleColumns)"$'\n'""
file="bin/build/tools/colors.sh"
fn="consoleColumns"
fnMarker="consolecolumns"
foundNames=([0]="summary" [1]="stdout" [2]="argument" [3]="see" [4]="example" [5]="environment" [6]="side_effect")
line="405"
rawComment="Summary: Column count in current console"$'\n'"Output the number of columns in the terminal. Default is 80 if not able to be determined from \`TERM\`."$'\n'"stdout: Integer"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: stty"$'\n'"Example:     textRepeat \$(consoleColumns)"$'\n'"Environment: - \`COLUMNS\` - May be defined after calling this"$'\n'"Environment: - \`LINES\` - May be defined after calling this"$'\n'"Side Effect: MAY define two environment variables"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="stty"$'\n'""
side_effect="MAY define two environment variables"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="313fe5b4ec3dfe1711045dafef5293c8f27eb9ea"
sourceLine="405"
stdout="Integer"$'\n'""
summary="Column count in current console"
summaryComputed=""
usage="consoleColumns [ --help ]"
