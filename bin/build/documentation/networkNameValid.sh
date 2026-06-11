#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-11
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"name - String. Network name to test for validity."$'\n'""
base="network.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Must be valid name containing alphabetic characters, dashes, or dots."$'\n'"Dotted sections must be no longer than 63 characters; total name must be no longer than 253 characters."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/network.sh"
fn="networkNameValid"
fnMarker="networknamevalid"
foundNames=([0]="summary" [1]="argument" [2]="return_code" [3]="stdin")
line="115"
rawComment="Summary: Is a network host name valid?"$'\n'"Must be valid name containing alphabetic characters, dashes, or dots."$'\n'"Dotted sections must be no longer than 63 characters; total name must be no longer than 253 characters."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: name - String. Network name to test for validity."$'\n'"Return Code: 0 - All network names passed in are valid."$'\n'"Return Code: 1 - One or more network names passed in are not valid"$'\n'"stdin: line:String - Network names to test for validity."$'\n'""$'\n'""
return_code="0 - All network names passed in are valid."$'\n'"1 - One or more network names passed in are not valid"$'\n'""
sourceFile="bin/build/tools/network.sh"
sourceHash="c6bb29c8fed5128e9b6862594b56a1536f11596a"
sourceLine="115"
stdin="line:String - Network names to test for validity."$'\n'""
summary="Is a network host name valid?"
summaryComputed=""
usage="networkNameValid [ --help ] [ name ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mnetworkNameValid'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ name ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mname    '$'\e''[[(value)]mString. Network name to test for validity.'$'\e''[[(reset)]m'$'\n'''$'\n''Must be valid name containing alphabetic characters, dashes, or dots.'$'\n''Dotted sections must be no longer than 63 characters; total name must be no longer than 253 characters.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All network names passed in are valid.'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - One or more network names passed in are not valid'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''line:String - Network names to test for validity.'
# shellcheck disable=SC2016
helpPlain='Usage: networkNameValid [ --help ] [ name ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    name    String. Network name to test for validity.'$'\n'''$'\n''Must be valid name containing alphabetic characters, dashes, or dots.'$'\n''Dotted sections must be no longer than 63 characters; total name must be no longer than 253 characters.'$'\n'''$'\n''Return codes:'$'\n''- 0 - All network names passed in are valid.'$'\n''- 1 - One or more network names passed in are not valid'$'\n'''$'\n''Reads from stdin:'$'\n''line:String - Network names to test for validity.'
documentationPath=""
