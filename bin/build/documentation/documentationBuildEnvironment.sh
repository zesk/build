#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/documentation.sh"
argument="--documentation documentationPath - Directory. Optional. Path to documentation root. Default is \`./documentation/source\`."$'\n'"--source sourcePath - Directory. Optional. Path to source environment files. Defaults to \`\$(buildHome)/bin/env\` if not specified."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="documentation.sh"
description="Build documentation for ./bin/env (or bin/build/env) directory."$'\n'"Creates a cache at \`documentationBuildCache\`"$'\n'""
file="bin/build/tools/documentation.sh"
foundNames=([0]="argument" [1]="see" [2]="return_code")
rawComment="Build documentation for ./bin/env (or bin/build/env) directory."$'\n'"Creates a cache at \`documentationBuildCache\`"$'\n'"Argument: --documentation documentationPath - Directory. Optional. Path to documentation root. Default is \`./documentation/source\`."$'\n'"Argument: --source sourcePath - Directory. Optional. Path to source environment files. Defaults to \`\$(buildHome)/bin/env\` if not specified."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: documentationBuild"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Issue with environment"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Issue with environment"$'\n'"2 - Argument error"$'\n'""
see="documentationBuild"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceModified="1769065497"
summary="Build documentation for ./bin/env (or bin/build/env) directory."
usage="documentationBuildEnvironment [ --documentation documentationPath ] [ --source sourcePath ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationBuildEnvironment'$'\e''[0m '$'\e''[[(blue)]m[ --documentation documentationPath ]'$'\e''[0m '$'\e''[[(blue)]m[ --source sourcePath ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--documentation documentationPath  '$'\e''[[(value)]mDirectory. Optional. Path to documentation root. Default is '$'\e''[[(code)]m./documentation/source'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--source sourcePath                '$'\e''[[(value)]mDirectory. Optional. Path to source environment files. Defaults to '$'\e''[[(code)]m$(buildHome)/bin/env'$'\e''[[(reset)]m if not specified.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help                             '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Build documentation for ./bin/env (or bin/build/env) directory.'$'\n''Creates a cache at '$'\e''[[(code)]mdocumentationBuildCache'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Issue with environment'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: documentationBuildEnvironment [ --documentation documentationPath ] [ --source sourcePath ] [ --help ]'$'\n'''$'\n''    --documentation documentationPath  Directory. Optional. Path to documentation root. Default is ./documentation/source.'$'\n''    --source sourcePath                Directory. Optional. Path to source environment files. Defaults to $(buildHome)/bin/env if not specified.'$'\n''    --help                             Flag. Optional. Display this help.'$'\n'''$'\n''Build documentation for ./bin/env (or bin/build/env) directory.'$'\n''Creates a cache at documentationBuildCache'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Issue with environment'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.488
