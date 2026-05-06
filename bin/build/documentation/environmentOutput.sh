#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--underscore - Flag. Optional. Include environment variables which begin with underscore \`_\`."$'\n'"--skip-prefix prefixString - String. Optional. Skip environment variables which begin with this exact prefix (case-sensitive)."$'\n'"--secure - Flag. Optional. Include environment variables which are in \`environmentSecureVariables\`"$'\n'"variable ... - String. Optional. Output these variables explicitly."$'\n'""
base="environment.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output all exported environment variables, hiding secure ones and ones prefixed with underscore."$'\n'"Any values which contain a newline are also skipped."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/environment.sh"
fn="environmentOutput"
fnMarker="environmentoutput"
foundNames=([0]="see" [1]="requires" [2]="argument")
line="199"
rawComment="Output all exported environment variables, hiding secure ones and ones prefixed with underscore."$'\n'"Any values which contain a newline are also skipped."$'\n'"See: environmentSecureVariables"$'\n'"Requires: throwArgument decorate environmentSecureVariables grepSafe env textRemoveFields"$'\n'"Argument: --underscore - Flag. Optional. Include environment variables which begin with underscore \`_\`."$'\n'"Argument: --skip-prefix prefixString - String. Optional. Skip environment variables which begin with this exact prefix (case-sensitive)."$'\n'"Argument: --secure - Flag. Optional. Include environment variables which are in \`environmentSecureVariables\`"$'\n'"Argument: variable ... - String. Optional. Output these variables explicitly."$'\n'""$'\n'""
requires="throwArgument decorate environmentSecureVariables grepSafe env textRemoveFields"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="environmentSecureVariables"$'\n'""
sourceFile="bin/build/tools/environment.sh"
sourceHash="fd4da5f1d9a2c52100a1a281185a474bae9aba02"
sourceLine="199"
summary="Output all exported environment variables, hiding secure ones and ones"
summaryComputed="true"
usage="environmentOutput [ --underscore ] [ --skip-prefix prefixString ] [ --secure ] [ variable ... ]"
