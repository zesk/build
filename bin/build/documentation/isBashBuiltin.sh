#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-11
# shellcheck disable=SC2034
argument="builtin - String. Required. String to check if it's a bash builtin."$'\n'""
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Useful for introspection or validation - checks if a token is a bash built-in (e.g. \`cd\`) vs. a binary on the system (\`/bin/cd\`)."$'\n'"Implementation taken directly from the Bash man page."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/bash.sh"
fn="isBashBuiltin"
fnMarker="isbashbuiltin"
foundNames=([0]="summary" [1]="argument" [2]="return_code")
line="100"
rawComment="Summary: Is a token a bash builtin?"$'\n'"Useful for introspection or validation - checks if a token is a bash built-in (e.g. \`cd\`) vs. a binary on the system (\`/bin/cd\`)."$'\n'"Implementation taken directly from the Bash man page."$'\n'"Argument: builtin - String. Required. String to check if it's a bash builtin."$'\n'"Return Code: 0 - Yes, this string is a bash builtin command."$'\n'"Return Code: 1 - No, this is not a bash builtin command"$'\n'""$'\n'""
return_code="0 - Yes, this string is a bash builtin command."$'\n'"1 - No, this is not a bash builtin command"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="c338e57d5d9111ed127b37263341910041a4b278"
sourceLine="100"
summary="Is a token a bash builtin?"
summaryComputed=""
usage="isBashBuiltin builtin"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misBashBuiltin'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mbuiltin'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mbuiltin  '$'\e''[[(value)]mString. Required. String to check if it'\''s a bash builtin.'$'\e''[[(reset)]m'$'\n'''$'\n''Useful for introspection or validation - checks if a token is a bash built-in (e.g. '$'\e''[[(code)]mcd'$'\e''[[(reset)]m) vs. a binary on the system ('$'\e''[[(code)]m/bin/cd'$'\e''[[(reset)]m).'$'\n''Implementation taken directly from the Bash man page.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Yes, this string is a bash builtin command.'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - No, this is not a bash builtin command'
# shellcheck disable=SC2016
helpPlain='Usage: isBashBuiltin builtin'$'\n'''$'\n''    builtin  String. Required. String to check if it'\''s a bash builtin.'$'\n'''$'\n''Useful for introspection or validation - checks if a token is a bash built-in (e.g. cd) vs. a binary on the system (/bin/cd).'$'\n''Implementation taken directly from the Bash man page.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Yes, this string is a bash builtin command.'$'\n''- 1 - No, this is not a bash builtin command'
documentationPath="documentation/source/tools/bash.md"
