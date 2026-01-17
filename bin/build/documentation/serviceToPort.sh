#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/platform.sh"
argument="service - String. Required. A unix service typically found in \`/etc/services\`"$'\n'"--services servicesFile -  File. Optional.File like '/etc/services\`."$'\n'"--help -  Flag. Optional.Display this help."$'\n'""
base="platform.sh"
description="Get the port number associated with a service"$'\n'""$'\n'"Return Code: 1 - service not found"$'\n'"Return Code: 2 - bad argument or invalid port"$'\n'"Return Code: 0 - service found and output is an integer"$'\n'""
file="bin/build/tools/platform.sh"
fn="serviceToPort"
foundNames=([0]="argument" [1]="output")
output="Port number of associated service (integer) one per line"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/platform.sh"
sourceModified="1768683999"
summary="Get the port number associated with a service"
usage="serviceToPort service [ --services servicesFile ] [ --help ]"
