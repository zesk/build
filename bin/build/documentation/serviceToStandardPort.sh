#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"service ... - String. Optional. A unix service typically found in \`/etc/services\`"$'\n'""
base="platform.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Hard-coded services for:"$'\n'""$'\n'"- \`ssh\` -> 22"$'\n'"- \`http\`-> 80"$'\n'"- \`https\`-> 80"$'\n'"- \`postgres\`-> 5432"$'\n'"- \`mariadb\`-> 3306"$'\n'"- \`mysql\`-> 3306"$'\n'""$'\n'"Backup when \`/etc/services\` does not exist."$'\n'""$'\n'""
descriptionLineCount="11"
file="bin/build/tools/platform.sh"
fn="serviceToStandardPort"
fnMarker="servicetostandardport"
foundNames=([0]="argument" [1]="output" [2]="return_code" [3]="see")
line="221"
output="Port number of associated service (integer) one per line"$'\n'""
rawComment="Hard-coded services for:"$'\n'"- \`ssh\` -> 22"$'\n'"- \`http\`-> 80"$'\n'"- \`https\`-> 80"$'\n'"- \`postgres\`-> 5432"$'\n'"- \`mariadb\`-> 3306"$'\n'"- \`mysql\`-> 3306"$'\n'"Backup when \`/etc/services\` does not exist."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: service ... - String. Optional. A unix service typically found in \`/etc/services\`"$'\n'"Output: Port number of associated service (integer) one per line"$'\n'"Return Code: 1 - service not found"$'\n'"Return Code: 0 - service found and output is an integer"$'\n'"See: serviceToPort"$'\n'""$'\n'""
return_code="1 - service not found"$'\n'"0 - service found and output is an integer"$'\n'""
see="serviceToPort"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceHash="097e41ee15602cdab3bc28d8a420362c8b93b425"
sourceLine="221"
summary="Hard-coded services for:"
summaryComputed="true"
usage="serviceToStandardPort [ --help ] [ service ... ]"
