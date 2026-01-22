#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/identical.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--singles singlesFiles - File. Optional. One or more files which contain a list of allowed \`{identical}\` singles, one per line."$'\n'"--single singleToken - String. Optional. One or more tokens which cam be singles."$'\n'"--repair directory - Directory. Optional. Any files in onr or more directories can be used to repair other files."$'\n'"--internal-only - Flag. Optional. Just do \`--internal\` repairs."$'\n'"--interactive - Flag. Optional. Interactive mode on fixing errors."$'\n'"... - Arguments. Optional. Additional arguments are passed directly to \`identicalCheck\`."$'\n'""
base="identical.sh"
description="Identical check for shell files"$'\n'""$'\n'"Looks for up to three tokens in code:"$'\n'""$'\n'"- \`# \`\`{identical} tokenName 1\`"$'\n'"- \`# \`\`_{identical}_ tokenName 1\`, and"$'\n'"- \`# \`\`DOC\`\` TEMPLATE: tokenName 1\`"$'\n'""$'\n'"This allows for overlapping identical sections within templates with the intent:"$'\n'""$'\n'"- \`{identical}\` - used in most cases (not internal)"$'\n'"- \`_{identical}_\` - used in templates which must be included in {identical} templates"$'\n'"- \`__{identical}__\` - used in templates which must be included in _{identical}_ templates"$'\n'"- \`DOC\`\` TEMPLATE:\` - used in documentation templates for functions - is handled by internal document generator"$'\n'""$'\n'""
file="bin/build/tools/identical.sh"
fn="identicalCheckShell"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/identical.sh"
sourceModified="1768845777"
summary="Identical check for shell files"
usage="identicalCheckShell [ --help ] [ --singles singlesFiles ] [ --single singleToken ] [ --repair directory ] [ --internal-only ] [ --interactive ] [ ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255midenticalCheckShell[0m [94m[ --help ][0m [94m[ --singles singlesFiles ][0m [94m[ --single singleToken ][0m [94m[ --repair directory ][0m [94m[ --internal-only ][0m [94m[ --interactive ][0m [94m[ ... ][0m

    [94m--help                  [1;97mFlag. Optional. Display this help.[0m
    [94m--singles singlesFiles  [1;97mFile. Optional. One or more files which contain a list of allowed [38;2;0;255;0;48;2;0;0;0mIDENTICAL[0m singles, one per line.[0m
    [94m--single singleToken    [1;97mString. Optional. One or more tokens which cam be singles.[0m
    [94m--repair directory      [1;97mDirectory. Optional. Any files in onr or more directories can be used to repair other files.[0m
    [94m--internal-only         [1;97mFlag. Optional. Just do [38;2;0;255;0;48;2;0;0;0m--internal[0m repairs.[0m
    [94m--interactive           [1;97mFlag. Optional. Interactive mode on fixing errors.[0m
    [94m...                     [1;97mArguments. Optional. Additional arguments are passed directly to [38;2;0;255;0;48;2;0;0;0midenticalCheck[0m.[0m

Identical check for shell files

Looks for up to three tokens in code:

- [38;2;0;255;0;48;2;0;0;0m# [0m[38;2;0;255;0;48;2;0;0;0mIDENTICAL tokenName 1[0m
- [38;2;0;255;0;48;2;0;0;0m# [0m[38;2;0;255;0;48;2;0;0;0m_IDENTICAL_ tokenName 1[0m, and
- [38;2;0;255;0;48;2;0;0;0m# [0m[38;2;0;255;0;48;2;0;0;0mDOC[0m[38;2;0;255;0;48;2;0;0;0m TEMPLATE: tokenName 1[0m

This allows for overlapping identical sections within templates with the intent:

- [38;2;0;255;0;48;2;0;0;0mIDENTICAL[0m - used in most cases (not internal)
- [38;2;0;255;0;48;2;0;0;0m_IDENTICAL_[0m - used in templates which must be included in IDENTICAL templates
- [38;2;0;255;0;48;2;0;0;0m__IDENTICAL__[0m - used in templates which must be included in _IDENTICAL_ templates
- [38;2;0;255;0;48;2;0;0;0mDOC[0m[38;2;0;255;0;48;2;0;0;0m TEMPLATE:[0m - used in documentation templates for functions - is handled by internal document generator

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: identicalCheckShell [ --help ] [ --singles singlesFiles ] [ --single singleToken ] [ --repair directory ] [ --internal-only ] [ --interactive ] [ ... ]

    --help                  Flag. Optional. Display this help.
    --singles singlesFiles  File. Optional. One or more files which contain a list of allowed IDENTICAL singles, one per line.
    --single singleToken    String. Optional. One or more tokens which cam be singles.
    --repair directory      Directory. Optional. Any files in onr or more directories can be used to repair other files.
    --internal-only         Flag. Optional. Just do --internal repairs.
    --interactive           Flag. Optional. Interactive mode on fixing errors.
    ...                     Arguments. Optional. Additional arguments are passed directly to identicalCheck.

Identical check for shell files

Looks for up to three tokens in code:

- # IDENTICAL tokenName 1
- # _IDENTICAL_ tokenName 1, and
- # DOC TEMPLATE: tokenName 1

This allows for overlapping identical sections within templates with the intent:

- IDENTICAL - used in most cases (not internal)
- _IDENTICAL_ - used in templates which must be included in IDENTICAL templates
- __IDENTICAL__ - used in templates which must be included in _IDENTICAL_ templates
- DOC TEMPLATE: - used in documentation templates for functions - is handled by internal document generator

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
