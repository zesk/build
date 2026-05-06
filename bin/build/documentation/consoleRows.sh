#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output the number of columns in the terminal. Default is 60 if not able to be determined from \`TERM\`."$'\n'""$'\n'""
descriptionLineCount="2"
environment="- \`COLUMNS\` - May be defined after calling this"$'\n'"- \`LINES\` - May be defined after calling this"$'\n'""
example="    tail -n \$(consoleRows) \"\$file\""$'\n'""
file="bin/build/tools/colors.sh"
fn="consoleRows"
fnMarker="consolerows"
foundNames=([0]="summary" [1]="argument" [2]="see" [3]="example" [4]="environment" [5]="side_effect")
line="440"
rawComment="Summary: Row count in current console"$'\n'"Output the number of columns in the terminal. Default is 60 if not able to be determined from \`TERM\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: stty"$'\n'"Example:     tail -n \$(consoleRows) \"\$file\""$'\n'"Environment: - \`COLUMNS\` - May be defined after calling this"$'\n'"Environment: - \`LINES\` - May be defined after calling this"$'\n'"Side Effect: MAY define two environment variables"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="stty"$'\n'""
side_effect="MAY define two environment variables"$'\n'""
sourceFile="bin/build/tools/colors.sh"
sourceHash="313fe5b4ec3dfe1711045dafef5293c8f27eb9ea"
sourceLine="440"
summary="Row count in current console"
summaryComputed=""
usage="consoleRows [ --help ]"
