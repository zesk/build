#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/daemontools.sh"
argument="none"
base="daemontools.sh"
description="Install daemontools and dependencies"$'\n'""
file="bin/build/tools/daemontools.sh"
fn="daemontoolsInstall"
platform="\`docker\` containers will not install \`daemontools-run\` as it kills the container"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceModified="1768769644"
summary="Install daemontools and dependencies"
usage="daemontoolsInstall"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdaemontoolsInstall[0m

Install daemontools and dependencies

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: daemontoolsInstall

Install daemontools and dependencies

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
