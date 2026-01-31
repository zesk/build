#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="serviceName - String. Required. Service name to remove."$'\n'""
base="daemontools.sh"
description="Remove a daemontools service by name"$'\n'""
file="bin/build/tools/daemontools.sh"
foundNames=([0]="argument")
rawComment="Remove a daemontools service by name"$'\n'"Argument: serviceName - String. Required. Service name to remove."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/daemontools.sh"
sourceHash="ad7724ecae1a0dfef00687192388ecf23b24032c"
summary="Remove a daemontools service by name"
summaryComputed="true"
usage="daemontoolsRemoveService serviceName"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdaemontoolsRemoveService'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mserviceName'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mserviceName  '$'\e''[[(value)]mString. Required. Service name to remove.'$'\e''[[(reset)]m'$'\n'''$'\n''Remove a daemontools service by name'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: [[(info)]mdaemontoolsRemoveService [[(bold)]m[[(magenta)]mserviceName'$'\n'''$'\n''    [[(red)]mserviceName  [[(value)]mString. Required. Service name to remove.[[(reset)]m'$'\n'''$'\n''Remove a daemontools service by name'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0[[(reset)]m - Success'$'\n''- [[(code)]m1[[(reset)]m - Environment error'$'\n''- [[(code)]m2[[(reset)]m - Argument error'$'\n'''
# elapsed 3.994
