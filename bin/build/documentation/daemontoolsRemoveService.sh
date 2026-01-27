#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/daemontools.sh"
argument="serviceName - String. Required. Service name to remove."$'\n'""
base="daemontools.sh"
description="Remove a daemontools service by name"$'\n'""
file="bin/build/tools/daemontools.sh"
foundNames=([0]="argument")
rawComment="Remove a daemontools service by name"$'\n'"Argument: serviceName - String. Required. Service name to remove."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceModified="1769109690"
summary="Remove a daemontools service by name"
usage="daemontoolsRemoveService serviceName"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdaemontoolsRemoveService'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mserviceName'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mserviceName  '$'\e''[[(value)]mString. Required. Service name to remove.'$'\e''[[(reset)]m'$'\n'''$'\n''Remove a daemontools service by name'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: daemontoolsRemoveService serviceName'$'\n'''$'\n''    serviceName  String. Required. Service name to remove.'$'\n'''$'\n''Remove a daemontools service by name'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.595
