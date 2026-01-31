#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="bash.sh"
description="Show function handler in files"$'\n'"Argument: functionName - String. Required. Function which should be called somewhere within a file."$'\n'"Argument: file - File. Required. File to search for function handler."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Function is used within the file"$'\n'"Return Code: 1 - Function is *not* used within the file"$'\n'"This check is simplistic and does not verify actual coverage or code paths."$'\n'"Requires: throwArgument decorate usageArgumentString usageArgumentFile quoteGrepPattern bashStripComments cat grep"$'\n'""
file="bin/build/tools/bash.sh"
foundNames=()
rawComment="Show function handler in files"$'\n'"Argument: functionName - String. Required. Function which should be called somewhere within a file."$'\n'"Argument: file - File. Required. File to search for function handler."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - Function is used within the file"$'\n'"Return Code: 1 - Function is *not* used within the file"$'\n'"This check is simplistic and does not verify actual coverage or code paths."$'\n'"Requires: throwArgument decorate usageArgumentString usageArgumentFile quoteGrepPattern bashStripComments cat grep"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceHash="c27f4788f9122cfbb778e66b32894938a8ca0ace"
summary="Show function handler in files"
usage="bashShowUsage"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashShowUsage'$'\e''[0m'$'\n'''$'\n''Show function handler in files'$'\n''Argument: functionName - String. Required. Function which should be called somewhere within a file.'$'\n''Argument: file - File. Required. File to search for function handler.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 0 - Function is used within the file'$'\n''Return Code: 1 - Function is '$'\e''[[(cyan)]mnot'$'\e''[[(reset)]m used within the file'$'\n''This check is simplistic and does not verify actual coverage or code paths.'$'\n''Requires: throwArgument decorate usageArgumentString usageArgumentFile quoteGrepPattern bashStripComments cat grep'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: bashShowUsage'$'\n'''$'\n''Show function handler in files'$'\n''Argument: functionName - String. Required. Function which should be called somewhere within a file.'$'\n''Argument: file - File. Required. File to search for function handler.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 0 - Function is used within the file'$'\n''Return Code: 1 - Function is not used within the file'$'\n''This check is simplistic and does not verify actual coverage or code paths.'$'\n''Requires: throwArgument decorate usageArgumentString usageArgumentFile quoteGrepPattern bashStripComments cat grep'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.437
