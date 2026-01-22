#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/documentation.sh"
argument="--env-file envFile - File. Optional. One (or more) environment files used to map \`documentTemplate\` prior to scanning, as defaults prior to each function generation, and after file generation."$'\n'"cacheDirectory - Required. Cache directory where the indexes live."$'\n'"sourceFile - Required. The document template containing functions to define"$'\n'"functionTemplate - Required. The template for individual functions defined in the \`documentTemplate\`."$'\n'"targetFile - Required. Target file to generate"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="documentation.sh"
description="Convert a template which contains bash functions into full-fledged documentation."$'\n'""$'\n'"The process:"$'\n'""$'\n'"1. \`documentTemplate\` is scanned for tokens which are assumed to represent Bash functions"$'\n'"1. \`functionTemplate\` is used to generate the documentation for each function"$'\n'"1. Functions are looked up in \`cacheDirectory\` using indexing functions and"$'\n'"1. Template used to generate documentation and compiled to \`targetFile\`"$'\n'""$'\n'"\`cacheDirectory\` is required - build an index using \`documentationIndexIndex\` prior to using this."$'\n'""$'\n'"Return Code: 0 - If success"$'\n'"Return Code: 1 - Issue with file generation"$'\n'"Return Code: 2 - Argument error"$'\n'""
file="bin/build/tools/documentation.sh"
fn="documentationTemplateCompile"
requires="catchEnvironment timingStart throwArgument usageArgumentFile usageArgumentDirectory usageArgumentFileDirectory"$'\n'"basename decorate statusMessage fileTemporaryName rm grep cut source mapTokens returnClean"$'\n'"mapEnvironment shaPipe printf"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="documentationIndexLookup"$'\n'"documentationIndexIndex"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceModified="1768842201"
summary="Convert a template file to a documentation file using templates"$'\n'""
usage="documentationTemplateCompile [ --env-file envFile ] cacheDirectory sourceFile functionTemplate targetFile [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdocumentationTemplateCompile[0m [94m[ --env-file envFile ][0m [38;2;255;255;0m[35;48;2;0;0;0mcacheDirectory[0m[0m [38;2;255;255;0m[35;48;2;0;0;0msourceFile[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mfunctionTemplate[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mtargetFile[0m[0m [94m[ --help ][0m

    [94m--env-file envFile  [1;97mFile. Optional. One (or more) environment files used to map [38;2;0;255;0;48;2;0;0;0mdocumentTemplate[0m prior to scanning, as defaults prior to each function generation, and after file generation.[0m
    [31mcacheDirectory      [1;97mRequired. Cache directory where the indexes live.[0m
    [31msourceFile          [1;97mRequired. The document template containing functions to define[0m
    [31mfunctionTemplate    [1;97mRequired. The template for individual functions defined in the [38;2;0;255;0;48;2;0;0;0mdocumentTemplate[0m.[0m
    [31mtargetFile          [1;97mRequired. Target file to generate[0m
    [94m--help              [1;97mFlag. Optional. Display this help.[0m

Convert a template which contains bash functions into full-fledged documentation.

The process:

1. [38;2;0;255;0;48;2;0;0;0mdocumentTemplate[0m is scanned for tokens which are assumed to represent Bash functions
1. [38;2;0;255;0;48;2;0;0;0mfunctionTemplate[0m is used to generate the documentation for each function
1. Functions are looked up in [38;2;0;255;0;48;2;0;0;0mcacheDirectory[0m using indexing functions and
1. Template used to generate documentation and compiled to [38;2;0;255;0;48;2;0;0;0mtargetFile[0m

[38;2;0;255;0;48;2;0;0;0mcacheDirectory[0m is required - build an index using [38;2;0;255;0;48;2;0;0;0mdocumentationIndexIndex[0m prior to using this.

Return Code: 0 - If success
Return Code: 1 - Issue with file generation
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: documentationTemplateCompile [ --env-file envFile ] cacheDirectory sourceFile functionTemplate targetFile [ --help ]

    --env-file envFile  File. Optional. One (or more) environment files used to map documentTemplate prior to scanning, as defaults prior to each function generation, and after file generation.
    cacheDirectory      Required. Cache directory where the indexes live.
    sourceFile          Required. The document template containing functions to define
    functionTemplate    Required. The template for individual functions defined in the documentTemplate.
    targetFile          Required. Target file to generate
    --help              Flag. Optional. Display this help.

Convert a template which contains bash functions into full-fledged documentation.

The process:

1. documentTemplate is scanned for tokens which are assumed to represent Bash functions
1. functionTemplate is used to generate the documentation for each function
1. Functions are looked up in cacheDirectory using indexing functions and
1. Template used to generate documentation and compiled to targetFile

cacheDirectory is required - build an index using documentationIndexIndex prior to using this.

Return Code: 0 - If success
Return Code: 1 - Issue with file generation
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
