#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/platform.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"service ... - String. Optional. A unix service typically found in \`/etc/services\`"$'\n'""
base="platform.sh"
description="Hard-coded services for:"$'\n'""$'\n'"- \`ssh\` -> 22"$'\n'"- \`http\`-> 80"$'\n'"- \`https\`-> 80"$'\n'"- \`postgres\`-> 5432"$'\n'"- \`mariadb\`-> 3306"$'\n'"- \`mysql\`-> 3306"$'\n'""$'\n'"Backup when \`/etc/services\` does not exist."$'\n'""$'\n'"Return Code: 1 - service not found"$'\n'"Return Code: 0 - service found and output is an integer"$'\n'""$'\n'""
file="bin/build/tools/platform.sh"
fn="serviceToStandardPort"
output="Port number of associated service (integer) one per line"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="serviceToPort"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceModified="1768873865"
summary="Hard-coded services for:"
usage="serviceToStandardPort [ --help ] [ service ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mserviceToStandardPort[0m [94m[ --help ][0m [94m[ service ... ][0m

    [94m--help       [1;97mFlag. Optional. Display this help.[0m
    [94mservice ...  [1;97mString. Optional. A unix service typically found in [38;2;0;255;0;48;2;0;0;0m/etc/services[0m[0m

Hard-coded services for:

- [38;2;0;255;0;48;2;0;0;0mssh[0m -> 22
- [38;2;0;255;0;48;2;0;0;0mhttp[0m-> 80
- [38;2;0;255;0;48;2;0;0;0mhttps[0m-> 80
- [38;2;0;255;0;48;2;0;0;0mpostgres[0m-> 5432
- [38;2;0;255;0;48;2;0;0;0mmariadb[0m-> 3306
- [38;2;0;255;0;48;2;0;0;0mmysql[0m-> 3306

Backup when [38;2;0;255;0;48;2;0;0;0m/etc/services[0m does not exist.

Return Code: 1 - service not found
Return Code: 0 - service found and output is an integer

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: serviceToStandardPort [ --help ] [ service ... ]

    --help       Flag. Optional. Display this help.
    service ...  String. Optional. A unix service typically found in /etc/services

Hard-coded services for:

- ssh -> 22
- http-> 80
- https-> 80
- postgres-> 5432
- mariadb-> 3306
- mysql-> 3306

Backup when /etc/services does not exist.

Return Code: 1 - service not found
Return Code: 0 - service found and output is an integer

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
