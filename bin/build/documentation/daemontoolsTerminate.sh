#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="daemontools.sh"
description="Terminate daemontools as gracefully as possible"$'\n'"Argument: --timeout seconds - Integer. Optional."$'\n'"Requires: throwArgument decorate usageArgumentInteger throwEnvironment catchEnvironment usageRequireBinary statusMessage"$'\n'"Requires: svscanboot id svc svstat"$'\n'""
file="bin/build/tools/daemontools.sh"
foundNames=()
rawComment="Terminate daemontools as gracefully as possible"$'\n'"Argument: --timeout seconds - Integer. Optional."$'\n'"Requires: throwArgument decorate usageArgumentInteger throwEnvironment catchEnvironment usageRequireBinary statusMessage"$'\n'"Requires: svscanboot id svc svstat"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceHash="b3ac4f07a3bb1601c513cdedd29c6e17c7c74232"
summary="Terminate daemontools as gracefully as possible"
usage="daemontoolsTerminate"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdaemontoolsTerminate'$'\e''[0m'$'\n'''$'\n''Terminate daemontools as gracefully as possible'$'\n''Argument: --timeout seconds - Integer. Optional.'$'\n''Requires: throwArgument decorate usageArgumentInteger throwEnvironment catchEnvironment usageRequireBinary statusMessage'$'\n''Requires: svscanboot id svc svstat'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: daemontoolsTerminate'$'\n'''$'\n''Terminate daemontools as gracefully as possible'$'\n''Argument: --timeout seconds - Integer. Optional.'$'\n''Requires: throwArgument decorate usageArgumentInteger throwEnvironment catchEnvironment usageRequireBinary statusMessage'$'\n''Requires: svscanboot id svc svstat'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.486
