#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/documentation.sh"
argument="--git - Flag. Optional. Merge current branch in with \`docs\` branch"$'\n'"--commit - Flag. Optional. Commit docs to non-docs branch"$'\n'"--force - Flag. Optional. Force generation, ignore cache directives"$'\n'"--unlinked - Flag. Optional. Show unlinked functions"$'\n'"--unlinked-update - Flag. Optional. Update unlinked document file"$'\n'"--clean - Flag. Optional. Erase the cache before starting."$'\n'"--help - Optional. Flag. Display this help."$'\n'"--company companyName - String. Optional. Company name (uses \`BUILD_COMPANY\` if not set)"$'\n'"--company-link companyLink - String. Optional. Company name (uses \`BUILD_COMPANY_LINK\` if not set)"$'\n'"--unlinked-source directory - Directory. Optional."$'\n'"--page-template pageTemplateFile - File. Optional."$'\n'"--source sourceDirectory - Directory. Required. Location of source code. Can specify one or more."$'\n'"--target targetDirectory - Directory. Required. Location of documentation build target."$'\n'"--function-template functionTemplateFile - File. Optional."$'\n'"--unlinked-template unlinkedTemplateFile - File. Optional."$'\n'"--unlinked-target unlinkedTarget - FileDirectory. Optional."$'\n'"--see-prefix seePrefix - EmptyString. Optional."$'\n'"--see-update - Flag. Optional. Update the \`see\` indexes only."$'\n'"--unlinked-update - Flag. Optional. Update the unlinked file only."$'\n'"--index-update - Flag. Optional. Update the documentation indexes only."$'\n'"--docs-update - Flag. Optional. Update the documentation target only."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
artifact="\`cacheDirectory\` may be created even on non-zero exit code"$'\n'""
base="documentation.sh"
description="Build documentation for Bash functions"$'\n'""$'\n'"Given that bash is not an ideal template language, caching is mandatory."$'\n'""$'\n'"Uses a cache at \`buildCacheDirectory\`"$'\n'""$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Issue with environment"$'\n'"Return Code: 2 - Argument error"$'\n'""
file="bin/build/tools/documentation.sh"
fn="documentationBuild"
foundNames=([0]="see" [1]="argument" [2]="artifact")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="buildCacheDirectory"$'\n'""
source="bin/build/tools/documentation.sh"
sourceModified="1768721469"
summary="Build documentation for Bash functions"
usage="documentationBuild [ --git ] [ --commit ] [ --force ] [ --unlinked ] [ --unlinked-update ] [ --clean ] [ --help ] [ --company companyName ] [ --company-link companyLink ] [ --unlinked-source directory ] [ --page-template pageTemplateFile ] --source sourceDirectory --target targetDirectory [ --function-template functionTemplateFile ] [ --unlinked-template unlinkedTemplateFile ] [ --unlinked-target unlinkedTarget ] [ --see-prefix seePrefix ] [ --see-update ] [ --unlinked-update ] [ --index-update ] [ --docs-update ] [ --help ]"
