#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/daemontools.sh"
argument="serviceName - String. Required. Service name to remove."$'\n'""
base="daemontools.sh"
description="Remove a daemontools service by name"$'\n'""$'\n'""
file="bin/build/tools/daemontools.sh"
fn="daemontoolsRemoveService"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceModified="1769063211"
summary="Remove a daemontools service by name"
usage="daemontoolsRemoveService serviceName"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdaemontoolsRemoveService[0m [38;2;255;255;0m[35;48;2;0;0;0mserviceName[0m[0m

    [31mserviceName  [1;97mString. Required. Service name to remove.[0m

Remove a daemontools service by name

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: daemontoolsRemoveService serviceName

    serviceName  String. Required. Service name to remove.

Remove a daemontools service by name

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
