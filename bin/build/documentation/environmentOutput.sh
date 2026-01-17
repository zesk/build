#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment.sh"
argument="--underscore - Flag. Optional. Include environment variables which begin with underscore \`_\`."$'\n'"--skip-prefix - String. Optional. Skip environment variables which begin with this exact prefix (case-sensitive)."$'\n'"--secure - Flag. Optional. Include environment variables which are in \`environmentSecureVariables\`"$'\n'""
base="environment.sh"
description="Output all exported environment variables, hiding secure ones and ones prefixed with underscore."$'\n'"Any values which contain a newline are also skipped."$'\n'""$'\n'""
file="bin/build/tools/environment.sh"
fn="environmentOutput"
foundNames=([0]="see" [1]="requires" [2]="argument")
requires="throwArgument decorate environmentSecureVariables grepSafe env removeFields"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="environmentSecureVariables"$'\n'""
source="bin/build/tools/environment.sh"
sourceModified="1768683999"
summary="Output all exported environment variables, hiding secure ones and ones"
usage="environmentOutput [ --underscore ] [ --skip-prefix ] [ --secure ]"
