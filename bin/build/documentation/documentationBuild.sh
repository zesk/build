#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/documentation.sh"
argument="--git - Flag. Optional. Merge current branch in with \`docs\` branch"$'\n'"--commit - Flag. Optional. Commit docs to non-docs branch"$'\n'"--force - Flag. Optional. Force generation, ignore cache directives"$'\n'"--unlinked - Flag. Optional. Show unlinked functions"$'\n'"--unlinked-update - Flag. Optional. Update unlinked document file"$'\n'"--clean - Flag. Optional. Erase the cache before starting."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--company companyName - String. Optional. Company name (uses \`BUILD_COMPANY\` if not set)"$'\n'"--company-link companyLink - String. Optional. Company name (uses \`BUILD_COMPANY_LINK\` if not set)"$'\n'"--unlinked-source directory - Directory. Optional."$'\n'"--page-template pageTemplateFile - File. Optional."$'\n'"--source sourceDirectory - Directory. Required. Location of source code. Can specify one or more."$'\n'"--target targetDirectory - Directory. Required. Location of documentation build target."$'\n'"--function-template functionTemplateFile - File. Optional."$'\n'"--unlinked-template unlinkedTemplateFile - File. Optional."$'\n'"--unlinked-target unlinkedTarget - FileDirectory. Optional."$'\n'"--see-prefix seePrefix - EmptyString. Optional."$'\n'"--see-update - Flag. Optional. Update the \`see\` indexes only."$'\n'"--unlinked-update - Flag. Optional. Update the unlinked file only."$'\n'"--index-update - Flag. Optional. Update the documentation indexes only."$'\n'"--docs-update - Flag. Optional. Update the documentation target only."$'\n'""
artifact="\`cacheDirectory\` may be created even on non-zero exit code"$'\n'""
base="documentation.sh"
description="Build documentation for Bash functions"$'\n'""$'\n'"Given that bash is not an ideal template language, caching is mandatory."$'\n'""$'\n'"Uses a cache at \`buildCacheDirectory\`"$'\n'""$'\n'"Return Code: 0 - Success"$'\n'"Return Code: 1 - Issue with environment"$'\n'"Return Code: 2 - Argument error"$'\n'""
file="bin/build/tools/documentation.sh"
fn="documentationBuild"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="buildCacheDirectory"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceModified="1769065497"
summary="Build documentation for Bash functions"
usage="documentationBuild [ --git ] [ --commit ] [ --force ] [ --unlinked ] [ --unlinked-update ] [ --clean ] [ --help ] [ --company companyName ] [ --company-link companyLink ] [ --unlinked-source directory ] [ --page-template pageTemplateFile ] --source sourceDirectory --target targetDirectory [ --function-template functionTemplateFile ] [ --unlinked-template unlinkedTemplateFile ] [ --unlinked-target unlinkedTarget ] [ --see-prefix seePrefix ] [ --see-update ] [ --unlinked-update ] [ --index-update ] [ --docs-update ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdocumentationBuild[0m [94m[ --git ][0m [94m[ --commit ][0m [94m[ --force ][0m [94m[ --unlinked ][0m [94m[ --unlinked-update ][0m [94m[ --clean ][0m [94m[ --help ][0m [94m[ --company companyName ][0m [94m[ --company-link companyLink ][0m [94m[ --unlinked-source directory ][0m [94m[ --page-template pageTemplateFile ][0m [38;2;255;255;0m[35;48;2;0;0;0m--source sourceDirectory[0m[0m [38;2;255;255;0m[35;48;2;0;0;0m--target targetDirectory[0m[0m [94m[ --function-template functionTemplateFile ][0m [94m[ --unlinked-template unlinkedTemplateFile ][0m [94m[ --unlinked-target unlinkedTarget ][0m [94m[ --see-prefix seePrefix ][0m [94m[ --see-update ][0m [94m[ --unlinked-update ][0m [94m[ --index-update ][0m [94m[ --docs-update ][0m

    [94m--git                                     [1;97mFlag. Optional. Merge current branch in with [38;2;0;255;0;48;2;0;0;0mdocs[0m branch[0m
    [94m--commit                                  [1;97mFlag. Optional. Commit docs to non-docs branch[0m
    [94m--force                                   [1;97mFlag. Optional. Force generation, ignore cache directives[0m
    [94m--unlinked                                [1;97mFlag. Optional. Show unlinked functions[0m
    [94m--unlinked-update                         [1;97mFlag. Optional. Update unlinked document file[0m
    [94m--clean                                   [1;97mFlag. Optional. Erase the cache before starting.[0m
    [94m--help                                    [1;97mFlag. Optional. Display this help.[0m
    [94m--company companyName                     [1;97mString. Optional. Company name (uses [38;2;0;255;0;48;2;0;0;0mBUILD_COMPANY[0m if not set)[0m
    [94m--company-link companyLink                [1;97mString. Optional. Company name (uses [38;2;0;255;0;48;2;0;0;0mBUILD_COMPANY_LINK[0m if not set)[0m
    [94m--unlinked-source directory               [1;97mDirectory. Optional.[0m
    [94m--page-template pageTemplateFile          [1;97mFile. Optional.[0m
    [31m--source sourceDirectory                  [1;97mDirectory. Required. Location of source code. Can specify one or more.[0m
    [31m--target targetDirectory                  [1;97mDirectory. Required. Location of documentation build target.[0m
    [94m--function-template functionTemplateFile  [1;97mFile. Optional.[0m
    [94m--unlinked-template unlinkedTemplateFile  [1;97mFile. Optional.[0m
    [94m--unlinked-target unlinkedTarget          [1;97mFileDirectory. Optional.[0m
    [94m--see-prefix seePrefix                    [1;97mEmptyString. Optional.[0m
    [94m--see-update                              [1;97mFlag. Optional. Update the [38;2;0;255;0;48;2;0;0;0msee[0m indexes only.[0m
    [94m--unlinked-update                         [1;97mFlag. Optional. Update the unlinked file only.[0m
    [94m--index-update                            [1;97mFlag. Optional. Update the documentation indexes only.[0m
    [94m--docs-update                             [1;97mFlag. Optional. Update the documentation target only.[0m

Build documentation for Bash functions

Given that bash is not an ideal template language, caching is mandatory.

Uses a cache at [38;2;0;255;0;48;2;0;0;0mbuildCacheDirectory[0m

Return Code: 0 - Success
Return Code: 1 - Issue with environment
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: documentationBuild [ --git ] [ --commit ] [ --force ] [ --unlinked ] [ --unlinked-update ] [ --clean ] [ --help ] [ --company companyName ] [ --company-link companyLink ] [ --unlinked-source directory ] [ --page-template pageTemplateFile ] --source sourceDirectory --target targetDirectory [ --function-template functionTemplateFile ] [ --unlinked-template unlinkedTemplateFile ] [ --unlinked-target unlinkedTarget ] [ --see-prefix seePrefix ] [ --see-update ] [ --unlinked-update ] [ --index-update ] [ --docs-update ]

    --git                                     Flag. Optional. Merge current branch in with docs branch
    --commit                                  Flag. Optional. Commit docs to non-docs branch
    --force                                   Flag. Optional. Force generation, ignore cache directives
    --unlinked                                Flag. Optional. Show unlinked functions
    --unlinked-update                         Flag. Optional. Update unlinked document file
    --clean                                   Flag. Optional. Erase the cache before starting.
    --help                                    Flag. Optional. Display this help.
    --company companyName                     String. Optional. Company name (uses BUILD_COMPANY if not set)
    --company-link companyLink                String. Optional. Company name (uses BUILD_COMPANY_LINK if not set)
    --unlinked-source directory               Directory. Optional.
    --page-template pageTemplateFile          File. Optional.
    --source sourceDirectory                  Directory. Required. Location of source code. Can specify one or more.
    --target targetDirectory                  Directory. Required. Location of documentation build target.
    --function-template functionTemplateFile  File. Optional.
    --unlinked-template unlinkedTemplateFile  File. Optional.
    --unlinked-target unlinkedTarget          FileDirectory. Optional.
    --see-prefix seePrefix                    EmptyString. Optional.
    --see-update                              Flag. Optional. Update the see indexes only.
    --unlinked-update                         Flag. Optional. Update the unlinked file only.
    --index-update                            Flag. Optional. Update the documentation indexes only.
    --docs-update                             Flag. Optional. Update the documentation target only.

Build documentation for Bash functions

Given that bash is not an ideal template language, caching is mandatory.

Uses a cache at buildCacheDirectory

Return Code: 0 - Success
Return Code: 1 - Issue with environment
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
