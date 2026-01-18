#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/documentation.sh"
argument="--filter filterArgs ... --  - Arguments. Optional. Passed to \`find\` and allows filtering list."$'\n'"--force - Flag. Optional. Force generation of files."$'\n'"--verbose - Flag. Optional. Output more messages."$'\n'"--env-file envFile - File. Optional. One (or more) environment files used during map of \`functionTemplate\`"$'\n'"cacheDirectory - Required. The directory where function index exists and additional cache files can be stored."$'\n'"templateDirectory - Required. Directory containing documentation templates"$'\n'"functionTemplate - Required. Function template file to generate documentation for functions"$'\n'"targetDirectory - Required. Directory to create generated documentation"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="documentation.sh"
description="Convert a directory of templates for bash functions into full-fledged documentation."$'\n'""$'\n'"The process:"$'\n'""$'\n'"1. \`templateDirectory\` is scanned for files which look like \`*.md\`"$'\n'"1. \`{fn}\` is called for each one"$'\n'""$'\n'"If the \`cacheDirectory\` is supplied, it's used to store values and hashes of the various files to avoid having"$'\n'"to regenerate each time."$'\n'""$'\n'"Return Code: 0 - If success"$'\n'"Return Code: 1 - Any template file failed to generate for any reason"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
file="bin/build/tools/documentation.sh"
fn="documentationTemplateDirectoryCompile"
foundNames=([0]="argument" [1]="summary" [2]="see")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="documentationTemplateCompile"$'\n'""
source="bin/build/tools/documentation.sh"
sourceModified="1768721469"
summary="Convert a directory of templates into documentation for Bash functions"$'\n'""
usage="documentationTemplateDirectoryCompile [ --filter filterArgs ... --  ] [ --force ] [ --verbose ] [ --env-file envFile ] cacheDirectory templateDirectory functionTemplate targetDirectory [ --help ]"
