#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/lint.sh"
argument="\`extension0\` - Required - the extension to search for (\`*.extension\`)"$'\n'"\`--\` - Separator. Required. Separates extensions from text"$'\n'"\`text0\` - String. Required. Text which must exist in each item with the extension given."$'\n'"\`--\` - Separator. Optional. Final delimiter to specify find arguments."$'\n'"findArgs - Arguments. Optional. Passed to \`find\`. Limit find to additional conditions."$'\n'""
base="lint.sh"
description="Search for item extensions and ensure that text is found in each item."$'\n'""$'\n'"This can be run on any directory tree to test files in any application."$'\n'""$'\n'"By default, any directory which begins with a dot \`.\` will be ignored."$'\n'""$'\n'"Side-effect: Errors written to stderr, status written to stdout"$'\n'"Return Code: 0 - All found files contain all text strings"$'\n'"Return Code: 1 - One or more files does not contain all text strings"$'\n'"Return Code: 2 - Arguments error (missing extension or text)"$'\n'""$'\n'""
environment="This operates in the current working directory"$'\n'""
example="    validateFileContents sh php js -- 'Widgets LLC' 'Copyright &copy; 2026'"$'\n'""
file="bin/build/tools/lint.sh"
fn="validateFileExtensionContents"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/lint.sh"
sourceModified="1768759461"
summary="Check files for the existence of a string"$'\n'""
usage="validateFileExtensionContents [ \`extension0\` ] \`--\` \`text0\` [ \`--\` ] [ findArgs ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mvalidateFileExtensionContents[0m [94m[ `extension0` ][0m [38;2;255;255;0m[35;48;2;0;0;0m`--`[0m[0m [38;2;255;255;0m[35;48;2;0;0;0m`text0`[0m[0m [94m[ `--` ][0m [94m[ findArgs ][0m

    [31m[38;2;0;255;0;48;2;0;0;0mextension0[0m  [1;97mRequired - the extension to search for ([38;2;0;255;0;48;2;0;0;0m[36m.extension[0m)[0m[0m
    [31m[38;2;0;255;0;48;2;0;0;0m--[0m          [1;97mSeparator. Required. Separates extensions from text[0m
    [31m[38;2;0;255;0;48;2;0;0;0mtext0[0m       [1;97mString. Required. Text which must exist in each item with the extension given.[0m
    [94m[38;2;0;255;0;48;2;0;0;0m--[0m          [1;97mSeparator. Optional. Final delimiter to specify find arguments.[0m
    [94mfindArgs      [1;97mArguments. Optional. Passed to [38;2;0;255;0;48;2;0;0;0mfind[0m. Limit find to additional conditions.[0m

Search for item extensions and ensure that text is found in each item.

This can be run on any directory tree to test files in any application.

By default, any directory which begins with a dot [38;2;0;255;0;48;2;0;0;0m.[0m will be ignored.

Side-effect: Errors written to stderr, status written to stdout
Return Code: 0 - All found files contain all text strings
Return Code: 1 - One or more files does not contain all text strings
Return Code: 2 - Arguments error (missing extension or text)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- This operates in the current working directory
- 

Example:
    validateFileContents sh php js -- '\''Widgets LLC'\'' '\''Copyright &copy; 2026'\''
'
# shellcheck disable=SC2016
helpPlain='Usage: validateFileExtensionContents [ `extension0` ] `--` `text0` [ `--` ] [ findArgs ]

    extension0  Required - the extension to search for (.extension)
    --          Separator. Required. Separates extensions from text
    text0       String. Required. Text which must exist in each item with the extension given.
    --          Separator. Optional. Final delimiter to specify find arguments.
    findArgs      Arguments. Optional. Passed to find. Limit find to additional conditions.

Search for item extensions and ensure that text is found in each item.

This can be run on any directory tree to test files in any application.

By default, any directory which begins with a dot . will be ignored.

Side-effect: Errors written to stderr, status written to stdout
Return Code: 0 - All found files contain all text strings
Return Code: 1 - One or more files does not contain all text strings
Return Code: 2 - Arguments error (missing extension or text)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- This operates in the current working directory
- 

Example:
    validateFileContents sh php js -- '\''Widgets LLC'\'' '\''Copyright &copy; 2026'\''
'
