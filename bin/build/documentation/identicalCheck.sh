#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
    # {identical} tokenName n
applicationFile="bin/build/tools/identical.sh"
argument="--extension extension - String. Required. One or more extensions to search for in the current directory."$'\n'"--prefix prefix - String. Required. A text prefix to search for to identify identical sections (e.g. \`# IDENTICAL\`) (may specify more than one)"$'\n'"--exclude pattern - String. Optional. One or more patterns of paths to exclude. Similar to pattern used in \`find\`."$'\n'"--cd directory - Directory. Optional.Change to this directory before running. Defaults to current directory."$'\n'"--repair directory - Directory. Optional.Any files in onr or more directories can be used to repair other files."$'\n'"--token token - String. Optional. ONLY do this token. May be specified more than once."$'\n'"--skip file - Directory. Optional.Ignore this file for repairs."$'\n'"--ignore-singles - Flag. Optional.Skip the check to see if single entries exist."$'\n'"--no-map - Flag. Optional.Do not map __BASE__, __FILE__, __DIR__ tokens."$'\n'"--debug - Optional. Additional debugging information is output."$'\n'"--help - Flag. Optional.This help."$'\n'"--singles singlesFiles - File. Optional.One or more files which contain a list of allowed \`{identical}\` singles, one per line."$'\n'"--single singleToken - String. Optional. One or more tokens which cam be singles."$'\n'""
base="identical.sh"
build_debug="identical-compare - Show verbose comparisons when things differ between identical sections"$'\n'""
description="Return Code: 2 - Argument error"$'\n'"Return Code: 0 - Success, everything matches"$'\n'"Return Code: 100 - Failures"$'\n'""$'\n'"When, for whatever reason, you need code to match between files, add a comment in the form:"$'\n'""$'\n'"    # {identical} tokenName n"$'\n'""$'\n'"Where \`tokenName\` is unique to your project, \`n\` is the number of lines to match. All found sets of lines in this form"$'\n'"must match each other set of lines with the same prefix, otherwise errors and details about failures are printed to stdout."$'\n'""$'\n'"The command to then check would be:"$'\n'""$'\n'"    {fn} --extension sh --prefix '# {identical}'"$'\n'""$'\n'"This is largely useful for projects in which specific functions are replicated between scripts for code independence, yet"$'\n'"should remain identical."$'\n'""$'\n'"Mapping also automatically handles file names and paths, so using the token \`__FILE__\` within your identical source"$'\n'"will convert to the target file's application path."$'\n'""$'\n'"Failures are considered:"$'\n'""$'\n'"- Partial success, but warnings occurred with an invalid number in a file"$'\n'"- Two code instances with the same token were found which were not identical"$'\n'"- Two code instances with the same token were found which have different line counts"$'\n'""$'\n'"This is best used as a pre-commit check, for example."$'\n'""
file="bin/build/tools/identical.sh"
fn="identicalCheck"
foundNames=([0]="argument" [1]="see" [2]="build_debug")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="identicalWatch"$'\n'""
source="bin/build/tools/identical.sh"
sourceModified="1768695708"
summary="Return Code: 2 - Argument error"
usage="identicalCheck --extension extension --prefix prefix [ --exclude pattern ] [ --cd directory ] [ --repair directory ] [ --token token ] [ --skip file ] [ --ignore-singles ] [ --no-map ] [ --debug ] [ --help ] [ --singles singlesFiles ] [ --single singleToken ]"
