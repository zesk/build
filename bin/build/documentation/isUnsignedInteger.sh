#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="example.sh"
description="Summary: Is value an unsigned integer?"$'\n'"Test if a value is a 0 or greater integer. Leading \"+\" is ok."$'\n'"Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash"$'\n'"Credits: F. Hauri - Give Up GitHub (isnum_Case)"$'\n'"Original: is_uint"$'\n'"Argument: value - EmptyString. Value to test if it is an unsigned integer."$'\n'"Return Code: 0 - if it is an unsigned integer"$'\n'"Return Code: 1 - if it is not an unsigned integer"$'\n'"Requires: returnMessage"$'\n'""
file="bin/build/tools/example.sh"
foundNames=()
rawComment="Summary: Is value an unsigned integer?"$'\n'"Test if a value is a 0 or greater integer. Leading \"+\" is ok."$'\n'"Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash"$'\n'"Credits: F. Hauri - Give Up GitHub (isnum_Case)"$'\n'"Original: is_uint"$'\n'"Argument: value - EmptyString. Value to test if it is an unsigned integer."$'\n'"Return Code: 0 - if it is an unsigned integer"$'\n'"Return Code: 1 - if it is not an unsigned integer"$'\n'"Requires: returnMessage"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/example.sh"
sourceHash="d31910f0251ea4404646f765659549c358927e01"
summary="Summary: Is value an unsigned integer?"
usage="isUnsignedInteger"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]misUnsignedInteger'$'\e''[0m'$'\n'''$'\n''Summary: Is value an unsigned integer?'$'\n''Test if a value is a 0 or greater integer. Leading "+" is ok.'$'\n''Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash'$'\n''Credits: F. Hauri - Give Up GitHub (isnum_Case)'$'\n''Original: is_uint'$'\n''Argument: value - EmptyString. Value to test if it is an unsigned integer.'$'\n''Return Code: 0 - if it is an unsigned integer'$'\n''Return Code: 1 - if it is not an unsigned integer'$'\n''Requires: returnMessage'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: isUnsignedInteger'$'\n'''$'\n''Summary: Is value an unsigned integer?'$'\n''Test if a value is a 0 or greater integer. Leading "+" is ok.'$'\n''Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash'$'\n''Credits: F. Hauri - Give Up GitHub (isnum_Case)'$'\n''Original: is_uint'$'\n''Argument: value - EmptyString. Value to test if it is an unsigned integer.'$'\n''Return Code: 0 - if it is an unsigned integer'$'\n''Return Code: 1 - if it is not an unsigned integer'$'\n''Requires: returnMessage'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.463
