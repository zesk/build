#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="service - String. Required. A unix service typically found in \`/etc/services\`"$'\n'"--services servicesFile - File. Optional. File like '/etc/services\`."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="platform.sh"
description="Get the port number associated with a service"$'\n'""
file="bin/build/tools/platform.sh"
fn="serviceToPort"
foundNames=([0]="argument" [1]="output" [2]="return_code")
line="263"
lowerFn="servicetoport"
output="Port number of associated service (integer) one per line"$'\n'""
rawComment="Get the port number associated with a service"$'\n'"Argument: service - String. Required. A unix service typically found in \`/etc/services\`"$'\n'"Argument: --services servicesFile - File. Optional. File like '/etc/services\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Output: Port number of associated service (integer) one per line"$'\n'"Return Code: 1 - service not found"$'\n'"Return Code: 2 - bad argument or invalid port"$'\n'"Return Code: 0 - service found and output is an integer"$'\n'""$'\n'""
return_code="1 - service not found"$'\n'"2 - bad argument or invalid port"$'\n'"0 - service found and output is an integer"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceHash="097e41ee15602cdab3bc28d8a420362c8b93b425"
sourceLine="263"
summary="Get the port number associated with a service"
summaryComputed="true"
usage="serviceToPort service [ --services servicesFile ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mserviceToPort'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mservice'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --services servicesFile ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mservice                  '$'\e''[[(value)]mString. Required. A unix service typically found in '$'\e''[[(code)]m/etc/services'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--services servicesFile  '$'\e''[[(value)]mFile. Optional. File like '\''/etc/services'$'\e''[[(code)]m.'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                   '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Get the port number associated with a service'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - service not found'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - bad argument or invalid port'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - service found and output is an integer'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: serviceToPort service [ --services servicesFile ] [ --help ]'$'\n'''$'\n''    service                  String. Required. A unix service typically found in /etc/services'$'\n''    --services servicesFile  File. Optional. File like '\''/etc/services.'$'\n''    --help                   Flag. Optional. Display this help.'$'\n'''$'\n''Get the port number associated with a service'$'\n'''$'\n''Return codes:'$'\n''- 1 - service not found'$'\n''- 2 - bad argument or invalid port'$'\n''- 0 - service found and output is an integer'$'\n'''
documentationPath="documentation/source/tools/service.md"
