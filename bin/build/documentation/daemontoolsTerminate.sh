#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/daemontools.sh"
argument="--timeout seconds - Integer. Optional."$'\n'""
base="daemontools.sh"
description="Terminate daemontools as gracefully as possible"$'\n'""
file="bin/build/tools/daemontools.sh"
fn="daemontoolsTerminate"
foundNames=([0]="argument" [1]="requires")
requires="throwArgument decorate usageArgumentInteger throwEnvironment catchEnvironment usageRequireBinary statusMessage"$'\n'"svscanboot id svc svstat"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/daemontools.sh"
sourceModified="1768721469"
summary="Terminate daemontools as gracefully as possible"
usage="daemontoolsTerminate [ --timeout seconds ]"
