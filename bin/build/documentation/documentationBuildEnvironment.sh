#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/documentation.sh"
argument="--documentation documentationPath - Directory. Optional. Path to documentation root. Default is \`./documentation/source\`."$'\n'"--source sourcePath - Directory. Optional. Path to source environment files. Defaults to \`\$(buildHome)/bin/env\` if not specified."$'\n'"--help - Flag. Optional.Display this help."$'\n'""
base="documentation.sh"
description="Build documentation for ./bin/env (or bin/build/env) directory."$'\n'""$'\n'"Creates a cache at \`documentationBuildCache\`"$'\n'""$'\n'""$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Issue with environment"$'\n'"Return Code: 2 - Argument error"$'\n'""
file="bin/build/tools/documentation.sh"
fn="documentationBuildEnvironment"
foundNames=([0]="argument" [1]="see")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="documentationBuild"$'\n'""
source="bin/build/tools/documentation.sh"
sourceModified="1768710514"
summary="Build documentation for ./bin/env (or bin/build/env) directory."
usage="documentationBuildEnvironment [ --documentation documentationPath ] [ --source sourcePath ] [ --help ]"
