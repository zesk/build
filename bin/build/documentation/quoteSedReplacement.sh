#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="sed.sh"
description="Summary: Quote sed replacement strings for shell use"$'\n'"Argument: text - EmptyString. Required. Text to quote"$'\n'"Argument: separatorChar - The character used to separate the sed pattern and replacement. Defaults to \`/\`."$'\n'"Output: string quoted and appropriate to insert in a \`sed\` replacement phrase"$'\n'"Example:     sed \"s/\$(quoteSedPattern \"\$1\")/\$(quoteSedReplacement \"\$2\")/g\""$'\n'"Example:     needSlash=\$(quoteSedPattern '\$.*/[\\]^')"$'\n'"Requires: printf sed usageDocument __help"$'\n'""
file="bin/build/tools/sed.sh"
foundNames=()
rawComment="Summary: Quote sed replacement strings for shell use"$'\n'"Argument: text - EmptyString. Required. Text to quote"$'\n'"Argument: separatorChar - The character used to separate the sed pattern and replacement. Defaults to \`/\`."$'\n'"Output: string quoted and appropriate to insert in a \`sed\` replacement phrase"$'\n'"Example:     sed \"s/\$(quoteSedPattern \"\$1\")/\$(quoteSedReplacement \"\$2\")/g\""$'\n'"Example:     needSlash=\$(quoteSedPattern '\$.*/[\\]^')"$'\n'"Requires: printf sed usageDocument __help"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sed.sh"
sourceHash="3d4ba5c523c9cedaf6e07ff31fc317123b86e880"
summary="Summary: Quote sed replacement strings for shell use"
usage="quoteSedReplacement"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mquoteSedReplacement'$'\e''[0m'$'\n'''$'\n''Summary: Quote sed replacement strings for shell use'$'\n''Argument: text - EmptyString. Required. Text to quote'$'\n''Argument: separatorChar - The character used to separate the sed pattern and replacement. Defaults to '$'\e''[[(code)]m/'$'\e''[[(reset)]m.'$'\n''Output: string quoted and appropriate to insert in a '$'\e''[[(code)]msed'$'\e''[[(reset)]m replacement phrase'$'\n''Example:     sed "s/$(quoteSedPattern "$1")/$(quoteSedReplacement "$2")/g"'$'\n''Example:     needSlash=$(quoteSedPattern '\''$.'$'\e''[[(cyan)]m/[\]^'\'')'$'\e''[[(reset)]m'$'\n''Requires: printf sed usageDocument __help'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: quoteSedReplacement'$'\n'''$'\n''Summary: Quote sed replacement strings for shell use'$'\n''Argument: text - EmptyString. Required. Text to quote'$'\n''Argument: separatorChar - The character used to separate the sed pattern and replacement. Defaults to /.'$'\n''Output: string quoted and appropriate to insert in a sed replacement phrase'$'\n''Example:     sed "s/$(quoteSedPattern "$1")/$(quoteSedReplacement "$2")/g"'$'\n''Example:     needSlash=$(quoteSedPattern '\''$./[\]^'\'')'$'\n''Requires: printf sed usageDocument __help'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.49
