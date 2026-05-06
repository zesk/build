#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="service - String. Required. A unix service typically found in \`/etc/services\`"$'\n'"--services servicesFile - File. Optional. File like '/etc/services\`."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="platform.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Get the port number associated with a service"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/platform.sh"
fn="serviceToPort"
fnMarker="servicetoport"
foundNames=([0]="argument" [1]="output" [2]="return_code")
line="263"
output="Port number of associated service (integer) one per line"$'\n'""
rawComment="Get the port number associated with a service"$'\n'"Argument: service - String. Required. A unix service typically found in \`/etc/services\`"$'\n'"Argument: --services servicesFile - File. Optional. File like '/etc/services\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Output: Port number of associated service (integer) one per line"$'\n'"Return Code: 1 - service not found"$'\n'"Return Code: 2 - bad argument or invalid port"$'\n'"Return Code: 0 - service found and output is an integer"$'\n'""$'\n'""
return_code="1 - service not found"$'\n'"2 - bad argument or invalid port"$'\n'"0 - service found and output is an integer"$'\n'""
sourceFile="bin/build/tools/platform.sh"
sourceHash="097e41ee15602cdab3bc28d8a420362c8b93b425"
sourceLine="263"
summary="Get the port number associated with a service"
summaryComputed="true"
usage="serviceToPort service [ --services servicesFile ] [ --help ]"
