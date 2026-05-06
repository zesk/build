#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--underscore - Flag. Optional. Include environment variables which begin with underscore \`_\`."$'\n'"--secure - Flag. Optional. Include environment variables which are in \`environmentSecureVariables\`"$'\n'"--keep-comments - Flag. Keep all comments in the source"$'\n'"--variables - CommaDelimitedList. Optional. Always output the value of these variables."$'\n'"--parse - Flag. Optional. Parse the file for things which look like variables to output (basically \`^foo=\`)"$'\n'"environmentFile - File. Required. Environment file to load, evaluate, and output in raw form (Bash-compatible)."$'\n'""
base="compile.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Load an environment file and evaluate it using bash and output the changed environment variables after running"$'\n'"Do not perform this operation on files which are untrusted."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/environment/compile.sh"
fn="environmentCompile"
fnMarker="environmentcompile"
foundNames=([0]="summary" [1]="argument" [2]="security")
line="16"
rawComment="Summary: Compile an environment file to evaluated names and values"$'\n'"Load an environment file and evaluate it using bash and output the changed environment variables after running"$'\n'"Do not perform this operation on files which are untrusted."$'\n'"Argument: --underscore - Flag. Optional. Include environment variables which begin with underscore \`_\`."$'\n'"Argument: --secure - Flag. Optional. Include environment variables which are in \`environmentSecureVariables\`"$'\n'"Argument: --keep-comments - Flag. Keep all comments in the source"$'\n'"Argument: --variables - CommaDelimitedList. Optional. Always output the value of these variables."$'\n'"Argument: --parse - Flag. Optional. Parse the file for things which look like variables to output (basically \`^foo=\`)"$'\n'"Argument: environmentFile - File. Required. Environment file to load, evaluate, and output in raw form (Bash-compatible)."$'\n'"Security: source"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
security="source"$'\n'""
sourceFile="bin/build/tools/environment/compile.sh"
sourceHash="570522e56b01f52bb6c9f872cfc4d62e29b7befb"
sourceLine="16"
summary="Compile an environment file to evaluated names and values"
summaryComputed=""
usage="environmentCompile [ --underscore ] [ --secure ] [ --keep-comments ] [ --variables ] [ --parse ] environmentFile"
