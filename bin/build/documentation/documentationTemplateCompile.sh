#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/documentation.sh"
argument="--env-file envFile - File. Optional. One (or more) environment files used to map \`documentTemplate\` prior to scanning, as defaults prior to each function generation, and after file generation."$'\n'"cacheDirectory - Required. Cache directory where the indexes live."$'\n'"sourceFile - Required. The document template containing functions to define"$'\n'"functionTemplate - Required. The template for individual functions defined in the \`documentTemplate\`."$'\n'"targetFile - Required. Target file to generate"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="documentation.sh"
description="Convert a template which contains bash functions into full-fledged documentation."$'\n'""$'\n'"The process:"$'\n'""$'\n'"1. \`documentTemplate\` is scanned for tokens which are assumed to represent Bash functions"$'\n'"1. \`functionTemplate\` is used to generate the documentation for each function"$'\n'"1. Functions are looked up in \`cacheDirectory\` using indexing functions and"$'\n'"1. Template used to generate documentation and compiled to \`targetFile\`"$'\n'""$'\n'"\`cacheDirectory\` is required - build an index using \`documentationIndexIndex\` prior to using this."$'\n'""$'\n'"Return Code: 0 - If success"$'\n'"Return Code: 1 - Issue with file generation"$'\n'"Return Code: 2 - Argument error"$'\n'""
file="bin/build/tools/documentation.sh"
fn="documentationTemplateCompile"
foundNames=([0]="summary" [1]="argument" [2]="see" [3]="requires")
requires="catchEnvironment timingStart throwArgument usageArgumentFile usageArgumentDirectory usageArgumentFileDirectory"$'\n'"basename decorate statusMessage fileTemporaryName rm grep cut source mapTokens returnClean"$'\n'"mapEnvironment shaPipe printf"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="documentationIndexLookup"$'\n'"documentationIndexIndex"$'\n'""
source="bin/build/tools/documentation.sh"
sourceModified="1768761838"
summary="Convert a template file to a documentation file using templates"$'\n'""
usage="documentationTemplateCompile [ --env-file envFile ] cacheDirectory sourceFile functionTemplate targetFile [ --help ]"
