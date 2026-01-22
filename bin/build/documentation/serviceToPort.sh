#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/platform.sh"
argument="service - String. Required. A unix service typically found in \`/etc/services\`"$'\n'"--services servicesFile - File. Optional. File like '/etc/services\`."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="platform.sh"
description="Get the port number associated with a service"$'\n'""$'\n'"Return Code: 1 - service not found"$'\n'"Return Code: 2 - bad argument or invalid port"$'\n'"Return Code: 0 - service found and output is an integer"$'\n'""
file="bin/build/tools/platform.sh"
fn="serviceToPort"
output="Port number of associated service (integer) one per line"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceModified="1768873865"
summary="Get the port number associated with a service"
usage="serviceToPort service [ --services servicesFile ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mserviceToPort[0m [38;2;255;255;0m[35;48;2;0;0;0mservice[0m[0m [94m[ --services servicesFile ][0m [94m[ --help ][0m

    [31mservice                  [1;97mString. Required. A unix service typically found in [38;2;0;255;0;48;2;0;0;0m/etc/services[0m[0m
    [94m--services servicesFile  [1;97mFile. Optional. File like '\''/etc/services[38;2;0;255;0;48;2;0;0;0m.[0m[0m
    [94m--help                   [1;97mFlag. Optional. Display this help.[0m

Get the port number associated with a service

Return Code: 1 - service not found
Return Code: 2 - bad argument or invalid port
Return Code: 0 - service found and output is an integer

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: serviceToPort service [ --services servicesFile ] [ --help ]

    service                  String. Required. A unix service typically found in /etc/services
    --services servicesFile  File. Optional. File like '\''/etc/services.
    --help                   Flag. Optional. Display this help.

Get the port number associated with a service

Return Code: 1 - service not found
Return Code: 2 - bad argument or invalid port
Return Code: 0 - service found and output is an integer

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
