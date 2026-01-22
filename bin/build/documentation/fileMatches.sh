#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/file.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"pattern ... - String. Required.\`grep -e\` Pattern to find in files. No quoting is added so ensure these are compatible with \`grep -e\`."$'\n'"-- - Delimiter. Required. exception."$'\n'"exception ... - String. Optional. \`grep -e\` File pattern which should be ignored."$'\n'"-- - Delimiter. Required. file."$'\n'"file ... - File. Required. File to search. Special file \`-\` indicates files should be read from \`stdin\`."$'\n'""
base="file.sh"
description="Find one or more patterns in a list of files, with a list of file name pattern exceptions."$'\n'""$'\n'""
file="bin/build/tools/file.sh"
fn="fileMatches"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/file.sh"
sourceModified="1769063211"
summary="Find one or more patterns in a list of files,"
usage="fileMatches [ --help ] pattern ... -- [ exception ... ] -- file ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mfileMatches[0m [94m[ --help ][0m [38;2;255;255;0m[35;48;2;0;0;0mpattern ...[0m[0m [38;2;255;255;0m[35;48;2;0;0;0m [94m[ exception ... ][0m [38;2;255;255;0m[35;48;2;0;0;0m [38;2;255;255;0m[35;48;2;0;0;0mfile ...[0m[0m

    [94m--help         [1;97mFlag. Optional. Display this help.[0m
    [31mpattern ...    [1;97mString. Required.[38;2;0;255;0;48;2;0;0;0mgrep -e[0m Pattern to find in files. No quoting is added so ensure these are compatible with [38;2;0;255;0;48;2;0;0;0mgrep -e[0m.[0m
    [31m--             [1;97mDelimiter. Required. exception.[0m
    [94mexception ...  [1;97mString. Optional. [38;2;0;255;0;48;2;0;0;0mgrep -e[0m File pattern which should be ignored.[0m
    [31m--             [1;97mDelimiter. Required. file.[0m
    [31mfile ...       [1;97mFile. Required. File to search. Special file [38;2;0;255;0;48;2;0;0;0m-[0m indicates files should be read from [38;2;0;255;0;48;2;0;0;0mstdin[0m.[0m

Find one or more patterns in a list of files, with a list of file name pattern exceptions.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: fileMatches [ --help ] pattern ...  [ exception ... ]  file ...

    --help         Flag. Optional. Display this help.
    pattern ...    String. Required.grep -e Pattern to find in files. No quoting is added so ensure these are compatible with grep -e.
    --             Delimiter. Required. exception.
    exception ...  String. Optional. grep -e File pattern which should be ignored.
    --             Delimiter. Required. file.
    file ...       File. Required. File to search. Special file - indicates files should be read from stdin.

Find one or more patterns in a list of files, with a list of file name pattern exceptions.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
