#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/identical.sh"
argument="--prefix prefix - String. Required. A text prefix to search for to identify identical sections (e.g. \`# IDENTICAL\`) (may specify more than one)"$'\n'"file ... - File. Required. A file to search for identical tokens."$'\n'""
base="identical.sh"
description="No documentation for \`identicalFindTokens\`."$'\n'""
exitCode="0"
file="bin/build/tools/identical.sh"
foundNames=([0]="argument" [1]="stdout")
rawComment="Argument: --prefix prefix - String. Required. A text prefix to search for to identify identical sections (e.g. \`# IDENTICAL\`) (may specify more than one)"$'\n'"Argument: file ... - File. Required. A file to search for identical tokens."$'\n'"stdout: tokens, one per line"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/identical.sh"
sourceModified="1769063211"
stdout="tokens, one per line"$'\n'""
summary="undocumented"
usage="identicalFindTokens --prefix prefix file ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]midenticalFindTokens'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]m--prefix prefix'$'\e''[0m'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mfile ...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]m--prefix prefix  '$'\e''[[value]mString. Required. A text prefix to search for to identify identical sections (e.g. '$'\e''[[code]m# IDENTICAL'$'\e''[[reset]m) (may specify more than one)'$'\e''[[reset]m'$'\n''    '$'\e''[[red]mfile ...         '$'\e''[[value]mFile. Required. A file to search for identical tokens.'$'\e''[[reset]m'$'\n'''$'\n''No documentation for '$'\e''[[code]midenticalFindTokens'$'\e''[[reset]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[code]mstdout'$'\e''[[reset]m:'$'\n''tokens, one per line'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: identicalFindTokens --prefix prefix file ...'$'\n'''$'\n''    --prefix prefix  String. Required. A text prefix to search for to identify identical sections (e.g. # IDENTICAL) (may specify more than one)'$'\n''    file ...         File. Required. A file to search for identical tokens.'$'\n'''$'\n''No documentation for identicalFindTokens.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''tokens, one per line'$'\n'''
