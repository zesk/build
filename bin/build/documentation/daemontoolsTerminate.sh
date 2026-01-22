#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/daemontools.sh"
argument="--timeout seconds - Integer. Optional."$'\n'""
base="daemontools.sh"
description="Terminate daemontools as gracefully as possible"$'\n'""
file="bin/build/tools/daemontools.sh"
fn="daemontoolsTerminate"
requires="throwArgument decorate usageArgumentInteger throwEnvironment catchEnvironment usageRequireBinary statusMessage"$'\n'"svscanboot id svc svstat"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceModified="1768769644"
summary="Terminate daemontools as gracefully as possible"
usage="daemontoolsTerminate [ --timeout seconds ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdaemontoolsTerminate[0m [94m[ --timeout seconds ][0m

    [94m--timeout seconds  [1;97mInteger. Optional.[0m

Terminate daemontools as gracefully as possible

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: daemontoolsTerminate [ --timeout seconds ]

    --timeout seconds  Integer. Optional.

Terminate daemontools as gracefully as possible

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
