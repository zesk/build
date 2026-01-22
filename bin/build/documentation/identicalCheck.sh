#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/identical.sh"
argument="--extension extension - String. Required. One or more extensions to search for in the current directory."$'\n'"--prefix prefix - String. Required. A text prefix to search for to identify identical sections (e.g. \`# IDENTICAL\`) (may specify more than one)"$'\n'"--exclude pattern - String. Optional. One or more patterns of paths to exclude. Similar to pattern used in \`find\`."$'\n'"--cd directory - Directory. Optional. Change to this directory before running. Defaults to current directory."$'\n'"--repair directory - Directory. Optional. Any files in onr or more directories can be used to repair other files."$'\n'"--skip file - Directory. Optional. Ignore this file for repairs."$'\n'"--ignore-singles - Flag. Optional. Skip the check to see if single entries exist."$'\n'"--no-map - Flag. Optional. Do not map __BASE__, __FILE__, __DIR__ tokens."$'\n'"--debug - Flag. Optional. Additional debugging information is output."$'\n'"--help - Flag. Optional. This help."$'\n'"--singles singlesFiles - File. Optional. One or more files which contain a list of allowed \`{identical}\` singles, one per line."$'\n'"--single singleToken - String. Optional. One or more tokens which cam be singles."$'\n'"--token token - String. Optional. Replace this token (only). May be specified more than once. Old method, deprecated but here for compatibility."$'\n'"token ... - String. Optional. Replace this token (only). May be specified more than once."$'\n'""
base="identical.sh"
build_debug="identical-compare - Show verbose comparisons when things differ between identical sections"$'\n'""
description="Return Code: 2 - Argument error"$'\n'"Return Code: 0 - Success, everything matches"$'\n'"Return Code: 100 - Failures"$'\n'""$'\n'"When, for whatever reason, you need code to match between files, add a comment in the form:"$'\n'""$'\n'"    # {identical} tokenName n"$'\n'""$'\n'"Where \`tokenName\` is unique to your project, \`n\` is the number of lines to match. All found sets of lines in this form"$'\n'"must match each other set of lines with the same prefix, otherwise errors and details about failures are printed to stdout."$'\n'""$'\n'"The command to then check would be:"$'\n'""$'\n'"    {fn} --extension sh --prefix '# {identical}'"$'\n'""$'\n'"This is largely useful for projects in which specific functions are replicated between scripts for code independence, yet"$'\n'"should remain identical."$'\n'""$'\n'"Mapping also automatically handles file names and paths, so using the token \`__FILE__\` within your identical source"$'\n'"will convert to the target file's application path."$'\n'""$'\n'"Failures are considered:"$'\n'""$'\n'"- Partial success, but warnings occurred with an invalid number in a file"$'\n'"- Two code instances with the same token were found which were not identical"$'\n'"- Two code instances with the same token were found which have different line counts"$'\n'""$'\n'"This is best used as a pre-commit check, for example."$'\n'""
file="bin/build/tools/identical.sh"
fn="identicalCheck"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="identicalWatch"$'\n'""
sourceFile="bin/build/tools/identical.sh"
sourceModified="1768845777"
summary="Return Code: 2 - Argument error"
usage="identicalCheck --extension extension --prefix prefix [ --exclude pattern ] [ --cd directory ] [ --repair directory ] [ --skip file ] [ --ignore-singles ] [ --no-map ] [ --debug ] [ --help ] [ --singles singlesFiles ] [ --single singleToken ] [ --token token ] [ token ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255midenticalCheck[0m [38;2;255;255;0m[35;48;2;0;0;0m--extension extension[0m[0m [38;2;255;255;0m[35;48;2;0;0;0m--prefix prefix[0m[0m [94m[ --exclude pattern ][0m [94m[ --cd directory ][0m [94m[ --repair directory ][0m [94m[ --skip file ][0m [94m[ --ignore-singles ][0m [94m[ --no-map ][0m [94m[ --debug ][0m [94m[ --help ][0m [94m[ --singles singlesFiles ][0m [94m[ --single singleToken ][0m [94m[ --token token ][0m [94m[ token ... ][0m

    [31m--extension extension   [1;97mString. Required. One or more extensions to search for in the current directory.[0m
    [31m--prefix prefix         [1;97mString. Required. A text prefix to search for to identify identical sections (e.g. [38;2;0;255;0;48;2;0;0;0m# IDENTICAL[0m) (may specify more than one)[0m
    [94m--exclude pattern       [1;97mString. Optional. One or more patterns of paths to exclude. Similar to pattern used in [38;2;0;255;0;48;2;0;0;0mfind[0m.[0m
    [94m--cd directory          [1;97mDirectory. Optional. Change to this directory before running. Defaults to current directory.[0m
    [94m--repair directory      [1;97mDirectory. Optional. Any files in onr or more directories can be used to repair other files.[0m
    [94m--skip file             [1;97mDirectory. Optional. Ignore this file for repairs.[0m
    [94m--ignore-singles        [1;97mFlag. Optional. Skip the check to see if single entries exist.[0m
    [94m--no-map                [1;97mFlag. Optional. Do not map __BASE__, __FILE__, __DIR__ tokens.[0m
    [94m--debug                 [1;97mFlag. Optional. Additional debugging information is output.[0m
    [94m--help                  [1;97mFlag. Optional. This help.[0m
    [94m--singles singlesFiles  [1;97mFile. Optional. One or more files which contain a list of allowed [38;2;0;255;0;48;2;0;0;0mIDENTICAL[0m singles, one per line.[0m
    [94m--single singleToken    [1;97mString. Optional. One or more tokens which cam be singles.[0m
    [94m--token token           [1;97mString. Optional. Replace this token (only). May be specified more than once. Old method, deprecated but here for compatibility.[0m
    [94mtoken ...               [1;97mString. Optional. Replace this token (only). May be specified more than once.[0m

Return Code: 2 - Argument error
Return Code: 0 - Success, everything matches
Return Code: 100 - Failures

When, for whatever reason, you need code to match between files, add a comment in the form:

    # IDENTICAL tokenName n

Where [38;2;0;255;0;48;2;0;0;0mtokenName[0m is unique to your project, [38;2;0;255;0;48;2;0;0;0mn[0m is the number of lines to match. All found sets of lines in this form
must match each other set of lines with the same prefix, otherwise errors and details about failures are printed to stdout.

The command to then check would be:

    identicalCheck --extension sh --prefix '\''# IDENTICAL'\''

This is largely useful for projects in which specific functions are replicated between scripts for code independence, yet
should remain identical.

Mapping also automatically handles file names and paths, so using the token [38;2;0;255;0;48;2;0;0;0m__FILE__[0m within your identical source
will convert to the target file'\''s application path.

Failures are considered:

- Partial success, but warnings occurred with an invalid number in a file
- Two code instances with the same token were found which were not identical
- Two code instances with the same token were found which have different line counts

This is best used as a pre-commit check, for example.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

[38;2;0;255;0;48;2;0;0;0mBUILD_DEBUG[0m settings:
- identical-compare - Show verbose comparisons when things differ between identical sections
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: identicalCheck --extension extension --prefix prefix [ --exclude pattern ] [ --cd directory ] [ --repair directory ] [ --skip file ] [ --ignore-singles ] [ --no-map ] [ --debug ] [ --help ] [ --singles singlesFiles ] [ --single singleToken ] [ --token token ] [ token ... ]

    --extension extension   String. Required. One or more extensions to search for in the current directory.
    --prefix prefix         String. Required. A text prefix to search for to identify identical sections (e.g. # IDENTICAL) (may specify more than one)
    --exclude pattern       String. Optional. One or more patterns of paths to exclude. Similar to pattern used in find.
    --cd directory          Directory. Optional. Change to this directory before running. Defaults to current directory.
    --repair directory      Directory. Optional. Any files in onr or more directories can be used to repair other files.
    --skip file             Directory. Optional. Ignore this file for repairs.
    --ignore-singles        Flag. Optional. Skip the check to see if single entries exist.
    --no-map                Flag. Optional. Do not map __BASE__, __FILE__, __DIR__ tokens.
    --debug                 Flag. Optional. Additional debugging information is output.
    --help                  Flag. Optional. This help.
    --singles singlesFiles  File. Optional. One or more files which contain a list of allowed IDENTICAL singles, one per line.
    --single singleToken    String. Optional. One or more tokens which cam be singles.
    --token token           String. Optional. Replace this token (only). May be specified more than once. Old method, deprecated but here for compatibility.
    token ...               String. Optional. Replace this token (only). May be specified more than once.

Return Code: 2 - Argument error
Return Code: 0 - Success, everything matches
Return Code: 100 - Failures

When, for whatever reason, you need code to match between files, add a comment in the form:

    # IDENTICAL tokenName n

Where tokenName is unique to your project, n is the number of lines to match. All found sets of lines in this form
must match each other set of lines with the same prefix, otherwise errors and details about failures are printed to stdout.

The command to then check would be:

    identicalCheck --extension sh --prefix '\''# IDENTICAL'\''

This is largely useful for projects in which specific functions are replicated between scripts for code independence, yet
should remain identical.

Mapping also automatically handles file names and paths, so using the token __FILE__ within your identical source
will convert to the target file'\''s application path.

Failures are considered:

- Partial success, but warnings occurred with an invalid number in a file
- Two code instances with the same token were found which were not identical
- Two code instances with the same token were found which have different line counts

This is best used as a pre-commit check, for example.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

BUILD_DEBUG settings:
- identical-compare - Show verbose comparisons when things differ between identical sections
- 
'
