#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="platform.sh"
description="Get the port number associated with a service"$'\n'"Argument: service - String. Required. A unix service typically found in \`/etc/services\`"$'\n'"Argument: --services servicesFile - File. Optional. File like '/etc/services\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Output: Port number of associated service (integer) one per line"$'\n'"Return Code: 1 - service not found"$'\n'"Return Code: 2 - bad argument or invalid port"$'\n'"Return Code: 0 - service found and output is an integer"$'\n'""
file="bin/build/tools/platform.sh"
foundNames=()
rawComment="Get the port number associated with a service"$'\n'"Argument: service - String. Required. A unix service typically found in \`/etc/services\`"$'\n'"Argument: --services servicesFile - File. Optional. File like '/etc/services\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Output: Port number of associated service (integer) one per line"$'\n'"Return Code: 1 - service not found"$'\n'"Return Code: 2 - bad argument or invalid port"$'\n'"Return Code: 0 - service found and output is an integer"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceHash="a1e5b60c969c8edace1146de6c1a3e07b2d6a084"
summary="Get the port number associated with a service"
usage="serviceToPort"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mserviceToPort'$'\e''[0m'$'\n'''$'\n''Get the port number associated with a service'$'\n''Argument: service - String. Required. A unix service typically found in '$'\e''[[(code)]m/etc/services'$'\e''[[(reset)]m'$'\n''Argument: --services servicesFile - File. Optional. File like '\''/etc/services'$'\e''[[(code)]m.'$'\e''[[(reset)]m'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Output: Port number of associated service (integer) one per line'$'\n''Return Code: 1 - service not found'$'\n''Return Code: 2 - bad argument or invalid port'$'\n''Return Code: 0 - service found and output is an integer'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: serviceToPort'$'\n'''$'\n''Get the port number associated with a service'$'\n''Argument: service - String. Required. A unix service typically found in /etc/services'$'\n''Argument: --services servicesFile - File. Optional. File like '\''/etc/services.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Output: Port number of associated service (integer) one per line'$'\n''Return Code: 1 - service not found'$'\n''Return Code: 2 - bad argument or invalid port'$'\n''Return Code: 0 - service found and output is an integer'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.459
