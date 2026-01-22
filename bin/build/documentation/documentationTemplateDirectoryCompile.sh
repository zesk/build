#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/documentation.sh"
argument="--filter filterArgs ... --  - Arguments. Optional. Passed to \`find\` and allows filtering list."$'\n'"--force - Flag. Optional. Force generation of files."$'\n'"--verbose - Flag. Optional. Output more messages."$'\n'"--env-file envFile - File. Optional. One (or more) environment files used during map of \`functionTemplate\`"$'\n'"cacheDirectory - Required. The directory where function index exists and additional cache files can be stored."$'\n'"templateDirectory - Required. Directory containing documentation templates"$'\n'"functionTemplate - Required. Function template file to generate documentation for functions"$'\n'"targetDirectory - Required. Directory to create generated documentation"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="documentation.sh"
description="Convert a directory of templates for bash functions into full-fledged documentation."$'\n'""$'\n'"The process:"$'\n'""$'\n'"1. \`templateDirectory\` is scanned for files which look like \`*.md\`"$'\n'"1. \`{fn}\` is called for each one"$'\n'""$'\n'"If the \`cacheDirectory\` is supplied, it's used to store values and hashes of the various files to avoid having"$'\n'"to regenerate each time."$'\n'""$'\n'"Return Code: 0 - If success"$'\n'"Return Code: 1 - Any template file failed to generate for any reason"$'\n'"Return Code: 2 - Argument error"$'\n'""$'\n'""
file="bin/build/tools/documentation.sh"
fn="documentationTemplateDirectoryCompile"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="documentationTemplateCompile"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceModified="1768842201"
summary="Convert a directory of templates into documentation for Bash functions"$'\n'""
usage="documentationTemplateDirectoryCompile [ --filter filterArgs ... --  ] [ --force ] [ --verbose ] [ --env-file envFile ] cacheDirectory templateDirectory functionTemplate targetDirectory [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdocumentationTemplateDirectoryCompile[0m [94m[ --filter filterArgs ... --  ][0m [94m[ --force ][0m [94m[ --verbose ][0m [94m[ --env-file envFile ][0m [38;2;255;255;0m[35;48;2;0;0;0mcacheDirectory[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mtemplateDirectory[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mfunctionTemplate[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mtargetDirectory[0m[0m [94m[ --help ][0m

    [94m--filter filterArgs ... --   [1;97mArguments. Optional. Passed to [38;2;0;255;0;48;2;0;0;0mfind[0m and allows filtering list.[0m
    [94m--force                      [1;97mFlag. Optional. Force generation of files.[0m
    [94m--verbose                    [1;97mFlag. Optional. Output more messages.[0m
    [94m--env-file envFile           [1;97mFile. Optional. One (or more) environment files used during map of [38;2;0;255;0;48;2;0;0;0mfunctionTemplate[0m[0m
    [31mcacheDirectory               [1;97mRequired. The directory where function index exists and additional cache files can be stored.[0m
    [31mtemplateDirectory            [1;97mRequired. Directory containing documentation templates[0m
    [31mfunctionTemplate             [1;97mRequired. Function template file to generate documentation for functions[0m
    [31mtargetDirectory              [1;97mRequired. Directory to create generated documentation[0m
    [94m--help                       [1;97mFlag. Optional. Display this help.[0m

Convert a directory of templates for bash functions into full-fledged documentation.

The process:

1. [38;2;0;255;0;48;2;0;0;0mtemplateDirectory[0m is scanned for files which look like [38;2;0;255;0;48;2;0;0;0m[36m.md[0m[0m
1. [38;2;0;255;0;48;2;0;0;0mdocumentationTemplateDirectoryCompile[0m is called for each one

If the [38;2;0;255;0;48;2;0;0;0mcacheDirectory[0m is supplied, it'\''s used to store values and hashes of the various files to avoid having
to regenerate each time.

Return Code: 0 - If success
Return Code: 1 - Any template file failed to generate for any reason
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: documentationTemplateDirectoryCompile [ --filter filterArgs ... --  ] [ --force ] [ --verbose ] [ --env-file envFile ] cacheDirectory templateDirectory functionTemplate targetDirectory [ --help ]

    --filter filterArgs ... --   Arguments. Optional. Passed to find and allows filtering list.
    --force                      Flag. Optional. Force generation of files.
    --verbose                    Flag. Optional. Output more messages.
    --env-file envFile           File. Optional. One (or more) environment files used during map of functionTemplate
    cacheDirectory               Required. The directory where function index exists and additional cache files can be stored.
    templateDirectory            Required. Directory containing documentation templates
    functionTemplate             Required. Function template file to generate documentation for functions
    targetDirectory              Required. Directory to create generated documentation
    --help                       Flag. Optional. Display this help.

Convert a directory of templates for bash functions into full-fledged documentation.

The process:

1. templateDirectory is scanned for files which look like .md
1. documentationTemplateDirectoryCompile is called for each one

If the cacheDirectory is supplied, it'\''s used to store values and hashes of the various files to avoid having
to regenerate each time.

Return Code: 0 - If success
Return Code: 1 - Any template file failed to generate for any reason
Return Code: 2 - Argument error

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
