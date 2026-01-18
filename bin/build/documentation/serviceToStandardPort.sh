#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/platform.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"service ... - String. Optional. A unix service typically found in \`/etc/services\`"$'\n'""
base="platform.sh"
description="Hard-coded services for:"$'\n'""$'\n'"- \`ssh\` -> 22"$'\n'"- \`http\`-> 80"$'\n'"- \`https\`-> 80"$'\n'"- \`postgres\`-> 5432"$'\n'"- \`mariadb\`-> 3306"$'\n'"- \`mysql\`-> 3306"$'\n'""$'\n'"Backup when \`/etc/services\` does not exist."$'\n'""$'\n'"Return Code: 1 - service not found"$'\n'"Return Code: 0 - service found and output is an integer"$'\n'""$'\n'""
file="bin/build/tools/platform.sh"
fn="serviceToStandardPort"
foundNames=([0]="argument" [1]="output" [2]="see")
output="Port number of associated service (integer) one per line"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="serviceToPort"$'\n'""
source="bin/build/tools/platform.sh"
sourceModified="1768721470"
summary="Hard-coded services for:"
usage="serviceToStandardPort [ --help ] [ service ... ]"
