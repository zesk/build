#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="text.sh"
description="Depends: sha1sum, /dev/random"$'\n'"Description: Outputs 40 random hexadecimal characters, lowercase."$'\n'"Example:     testPassword=\"\$(randomString)\""$'\n'"Output: cf7861b50054e8c680a9552917b43ec2b9edae2b"$'\n'"stdout: \`String\`. A random hexadecimal string."$'\n'""
file="bin/build/tools/text.sh"
foundNames=()
rawComment="Depends: sha1sum, /dev/random"$'\n'"Description: Outputs 40 random hexadecimal characters, lowercase."$'\n'"Example:     testPassword=\"\$(randomString)\""$'\n'"Output: cf7861b50054e8c680a9552917b43ec2b9edae2b"$'\n'"stdout: \`String\`. A random hexadecimal string."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="0fd758750c580a32fcbee69b6f6578e372baf3cd"
summary="Depends: sha1sum, /dev/random"
usage="randomString"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mrandomString'$'\e''[0m'$'\n'''$'\n''Depends: sha1sum, /dev/random'$'\n''Description: Outputs 40 random hexadecimal characters, lowercase.'$'\n''Example:     testPassword="$(randomString)"'$'\n''Output: cf7861b50054e8c680a9552917b43ec2b9edae2b'$'\n''stdout: '$'\e''[[(code)]mString'$'\e''[[(reset)]m. A random hexadecimal string.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: randomString'$'\n'''$'\n''Depends: sha1sum, /dev/random'$'\n''Description: Outputs 40 random hexadecimal characters, lowercase.'$'\n''Example:     testPassword="$(randomString)"'$'\n''Output: cf7861b50054e8c680a9552917b43ec2b9edae2b'$'\n''stdout: String. A random hexadecimal string.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.492
