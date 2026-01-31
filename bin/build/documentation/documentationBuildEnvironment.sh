#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="documentation.sh"
description="Build documentation for ./bin/env (or bin/build/env) directory."$'\n'"Creates a cache at \`documentationBuildCache\`"$'\n'"Argument: --documentation documentationPath - Directory. Optional. Path to documentation root. Default is \`./documentation/source\`."$'\n'"Argument: --source sourcePath - Directory. Optional. Path to source environment files. Defaults to \`\$(buildHome)/bin/env\` if not specified."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: documentationBuild"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Issue with environment"$'\n'"Return Code: 2 - Argument error"$'\n'""
file="bin/build/tools/documentation.sh"
foundNames=()
rawComment="Build documentation for ./bin/env (or bin/build/env) directory."$'\n'"Creates a cache at \`documentationBuildCache\`"$'\n'"Argument: --documentation documentationPath - Directory. Optional. Path to documentation root. Default is \`./documentation/source\`."$'\n'"Argument: --source sourcePath - Directory. Optional. Path to source environment files. Defaults to \`\$(buildHome)/bin/env\` if not specified."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"See: documentationBuild"$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Issue with environment"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceHash="46ab638aa51f9a58ed6d53b666c068deff5385ca"
summary="Build documentation for ./bin/env (or bin/build/env) directory."
usage="documentationBuildEnvironment"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdocumentationBuildEnvironment'$'\e''[0m'$'\n'''$'\n''Build documentation for ./bin/env (or bin/build/env) directory.'$'\n''Creates a cache at '$'\e''[[(code)]mdocumentationBuildCache'$'\e''[[(reset)]m'$'\n''Argument: --documentation documentationPath - Directory. Optional. Path to documentation root. Default is '$'\e''[[(code)]m./documentation/source'$'\e''[[(reset)]m.'$'\n''Argument: --source sourcePath - Directory. Optional. Path to source environment files. Defaults to '$'\e''[[(code)]m$(buildHome)/bin/env'$'\e''[[(reset)]m if not specified.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''See: documentationBuild'$'\n''Return Code: 0 - Success'$'\n''Return Code: 1 - Issue with environment'$'\n''Return Code: 2 - Argument error'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: documentationBuildEnvironment'$'\n'''$'\n''Build documentation for ./bin/env (or bin/build/env) directory.'$'\n''Creates a cache at documentationBuildCache'$'\n''Argument: --documentation documentationPath - Directory. Optional. Path to documentation root. Default is ./documentation/source.'$'\n''Argument: --source sourcePath - Directory. Optional. Path to source environment files. Defaults to $(buildHome)/bin/env if not specified.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''See: documentationBuild'$'\n''Return Code: 0 - Success'$'\n''Return Code: 1 - Issue with environment'$'\n''Return Code: 2 - Argument error'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.48
