#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="handler - Function. Required."$'\n'"function - String. Required."$'\n'"sourceFile - File. Required."$'\n'"--generate - Flag. Optional. Generate cached files."$'\n'"--no-cache - Flag. Optional. Skip any attempt to cache anything."$'\n'"--cache - Flag. Optional. Force use of cache."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="documentation.sh"
build_debug="usage-cache-skip - Skip caching by default (override with \`--cache\`)"$'\n'""
description="Extract documentation variables from a comment stripped of the '# ' prefixes."$'\n'"A few special values are generated/computed:"$'\n'"- \`description\` - Any line in the comment which is not in variable is appended to the field \`description\`"$'\n'"- \`fn\` - The function name (no parenthesis or anything)"$'\n'"- \`base\` - The basename of the file"$'\n'"- \`file\` - The relative path name of the file from the application root"$'\n'"- \`summary\` - Defaults to first ten words of \`description\`"$'\n'"- \`exit_code\` - Defaults to \`0 - Always succeeds\`"$'\n'"- \`reviewed\`  - Defaults to \`Never\`"$'\n'"- \`environment\"  - Defaults to \`No environment dependencies or modifications.\`"$'\n'"Otherwise the assumed variables (in addition to above) to define functions are:"$'\n'"- \`argument\` - Individual arguments"$'\n'"- \`usage\` - Canonical usage example (code)"$'\n'"- \`example\` - An example of usage (code, many)"$'\n'"- \`depends\` - Any dependencies (list)"$'\n'""
file="bin/build/tools/documentation.sh"
fn="bashDocumentationExtract"
foundNames=([0]="usage" [1]="summary" [2]="argument" [3]="stdin" [4]="build_debug")
rawComment="Extract documentation variables from a comment stripped of the '# ' prefixes."$'\n'"Usage: {fn} [ --generate ] [ --no-cache | --cache ] [ --help ] handler function sourceFile"$'\n'"A few special values are generated/computed:"$'\n'"- \`description\` - Any line in the comment which is not in variable is appended to the field \`description\`"$'\n'"- \`fn\` - The function name (no parenthesis or anything)"$'\n'"- \`base\` - The basename of the file"$'\n'"- \`file\` - The relative path name of the file from the application root"$'\n'"- \`summary\` - Defaults to first ten words of \`description\`"$'\n'"- \`exit_code\` - Defaults to \`0 - Always succeeds\`"$'\n'"- \`reviewed\`  - Defaults to \`Never\`"$'\n'"- \`environment\"  - Defaults to \`No environment dependencies or modifications.\`"$'\n'"Otherwise the assumed variables (in addition to above) to define functions are:"$'\n'"- \`argument\` - Individual arguments"$'\n'"- \`usage\` - Canonical usage example (code)"$'\n'"- \`example\` - An example of usage (code, many)"$'\n'"- \`depends\` - Any dependencies (list)"$'\n'"Summary: Generate a set of name/value pairs to document bash functions"$'\n'"Argument: handler - Function. Required."$'\n'"Argument: function - String. Required."$'\n'"Argument: sourceFile - File. Required."$'\n'"Argument: --generate - Flag. Optional. Generate cached files."$'\n'"Argument: --no-cache - Flag. Optional. Skip any attempt to cache anything."$'\n'"Argument: --cache - Flag. Optional. Force use of cache."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdin: Pipe stripped comments to extract information"$'\n'"BUILD_DEBUG: usage-cache-skip - Skip caching by default (override with \`--cache\`)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceHash="ac6911d0adf876a80a8dadee36af8e18f039de50"
stdin="Pipe stripped comments to extract information"$'\n'""
summary="Generate a set of name/value pairs to document bash functions"$'\n'""
usage="bashDocumentationExtract [ --generate ] [ --no-cache | --cache ] [ --help ] handler function sourceFile"$'\n'""
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
