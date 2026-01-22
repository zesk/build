#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/lint.sh"
argument="file ... - File. Required. A item to look for matches in. Use \`-\` to read file list from \`stdin\`."$'\n'"-- - Required. Separates files from text"$'\n'"text ... - Required. Text which must exist in each item"$'\n'""
base="lint.sh"
description="Search for item extensions and ensure that text is found in each item."$'\n'""$'\n'"This can be run on any directory tree to test files in any application."$'\n'""$'\n'"By default, any directory which begins with a dot \`.\` will be ignored."$'\n'""$'\n'"Side-effect: Errors written to stderr, status written to stdout"$'\n'"Return Code: 0 - All found files contain all text string or strings"$'\n'"Return Code: 1 - One or more files does not contain all text string or strings"$'\n'"Return Code: 2 - Arguments error (missing extension or text)"$'\n'""$'\n'""
example="    validateFileContents foo.sh my.sh -- \"Copyright 2024\" \"Company, LLC\""$'\n'""
file="bin/build/tools/lint.sh"
fn="validateFileContents"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/lint.sh"
sourceModified="1768759461"
summary="Check files for the existence of a string or strings"$'\n'""
usage="validateFileContents file ... -- text ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mvalidateFileContents[0m [38;2;255;255;0m[35;48;2;0;0;0mfile ...[0m[0m [38;2;255;255;0m[35;48;2;0;0;0m [38;2;255;255;0m[35;48;2;0;0;0mtext ...[0m[0m

    [31mfile ...  [1;97mFile. Required. A item to look for matches in. Use [38;2;0;255;0;48;2;0;0;0m-[0m to read file list from [38;2;0;255;0;48;2;0;0;0mstdin[0m.[0m
    [31m--        [1;97mRequired. Separates files from text[0m
    [31mtext ...  [1;97mRequired. Text which must exist in each item[0m

Search for item extensions and ensure that text is found in each item.

This can be run on any directory tree to test files in any application.

By default, any directory which begins with a dot [38;2;0;255;0;48;2;0;0;0m.[0m will be ignored.

Side-effect: Errors written to stderr, status written to stdout
Return Code: 0 - All found files contain all text string or strings
Return Code: 1 - One or more files does not contain all text string or strings
Return Code: 2 - Arguments error (missing extension or text)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    validateFileContents foo.sh my.sh -- "Copyright 2024" "Company, LLC"
'
# shellcheck disable=SC2016
helpPlain='Usage: validateFileContents file ...  text ...

    file ...  File. Required. A item to look for matches in. Use - to read file list from stdin.
    --        Required. Separates files from text
    text ...  Required. Text which must exist in each item

Search for item extensions and ensure that text is found in each item.

This can be run on any directory tree to test files in any application.

By default, any directory which begins with a dot . will be ignored.

Side-effect: Errors written to stderr, status written to stdout
Return Code: 0 - All found files contain all text string or strings
Return Code: 1 - One or more files does not contain all text string or strings
Return Code: 2 - Arguments error (missing extension or text)

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    validateFileContents foo.sh my.sh -- "Copyright 2024" "Company, LLC"
'
