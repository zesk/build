#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="identical.sh"
description="Argument: --prefix prefix - String. Required. A text prefix to search for to identify identical sections (e.g. \`# IDENTICAL\`) (may specify more than one)"$'\n'"Argument: file ... - File. Required. A file to search for identical tokens."$'\n'"stdout: tokens, one per line"$'\n'""
file="bin/build/tools/identical.sh"
foundNames=()
rawComment="Argument: --prefix prefix - String. Required. A text prefix to search for to identify identical sections (e.g. \`# IDENTICAL\`) (may specify more than one)"$'\n'"Argument: file ... - File. Required. A file to search for identical tokens."$'\n'"stdout: tokens, one per line"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/identical.sh"
sourceHash="3d17e0e52d21bf0984ad94f99e9132c29a6aaed3"
summary="Argument: --prefix prefix - String. Required. A text prefix to"
usage="identicalFindTokens"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]midenticalFindTokens'$'\e''[0m'$'\n'''$'\n''Argument: --prefix prefix - String. Required. A text prefix to search for to identify identical sections (e.g. '$'\e''[[(code)]m# IDENTICAL'$'\e''[[(reset)]m) (may specify more than one)'$'\n''Argument: file ... - File. Required. A file to search for identical tokens.'$'\n''stdout: tokens, one per line'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: identicalFindTokens'$'\n'''$'\n''Argument: --prefix prefix - String. Required. A text prefix to search for to identify identical sections (e.g. # IDENTICAL) (may specify more than one)'$'\n''Argument: file ... - File. Required. A file to search for identical tokens.'$'\n''stdout: tokens, one per line'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.475
