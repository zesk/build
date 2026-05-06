#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="fn - String. Required. Name of \`fn\`"$'\n'"sourceFile - File. Required."$'\n'"sourceLine - PositiveInteger. Optional."$'\n'"--generate - Flag. Optional. Generate cached files."$'\n'"--no-cache - Flag. Optional. Skip any attempt to cache anything."$'\n'"--cache - Flag. Optional. Force use of cache."$'\n'"--function - Flag. Optional. Function derivations \`return_code\` \`fn\` \`lowerFn\` \`fnMarker\` \`argument\` \`usage\`"$'\n'"--environment - Flag. Optional. Environment variable derivations \`env\` \`envMarker\`"$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="documentation.sh"
build_debug="usage-cache-skip - Skip caching by default (override with \`--cache\`)"$'\n'""
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Extract documentation variables from a comment stripped of the '# ' prefixes."$'\n'""$'\n'"A few special values are generated/computed:"$'\n'""$'\n'"- \`description\` - Any line in the comment which is not in variable is appended to the field \`description\`"$'\n'"- \`fn\` - The function name (no parenthesis or anything)"$'\n'"- \`base\` - The basename of the file"$'\n'"- \`file\` - The relative path name of the file from the application root"$'\n'"- \`summary\` - Defaults to first ten words of \`description\`"$'\n'"- \`exit_code\` - Defaults to \`0 - Always succeeds\`"$'\n'"- \`reviewed\`  - Defaults to \`Never\`"$'\n'"- \`environment\"  - Defaults to \`No environment dependencies or modifications.\`"$'\n'""$'\n'"Otherwise the assumed variables (in addition to above) to define functions are:"$'\n'""$'\n'"- \`argument\` - Individual arguments"$'\n'"- \`usage\` - Canonical usage example (code)"$'\n'"- \`example\` - An example of usage (code, many)"$'\n'"- \`depends\` - Any dependencies (list)"$'\n'""$'\n'""
descriptionLineCount="20"
file="bin/build/tools/documentation.sh"
fn="bashDocumentationExtract"
fnMarker="bashdocumentationextract"
foundNames=([0]="usage" [1]="summary" [2]="argument" [3]="stdin" [4]="build_debug")
line="60"
rawComment="Extract documentation variables from a comment stripped of the '# ' prefixes."$'\n'"Usage: {fn} [ --generate ] [ --no-cache | --cache ] [ --help ] handler function sourceFile"$'\n'"A few special values are generated/computed:"$'\n'"- \`description\` - Any line in the comment which is not in variable is appended to the field \`description\`"$'\n'"- \`fn\` - The function name (no parenthesis or anything)"$'\n'"- \`base\` - The basename of the file"$'\n'"- \`file\` - The relative path name of the file from the application root"$'\n'"- \`summary\` - Defaults to first ten words of \`description\`"$'\n'"- \`exit_code\` - Defaults to \`0 - Always succeeds\`"$'\n'"- \`reviewed\`  - Defaults to \`Never\`"$'\n'"- \`environment\"  - Defaults to \`No environment dependencies or modifications.\`"$'\n'"Otherwise the assumed variables (in addition to above) to define functions are:"$'\n'"- \`argument\` - Individual arguments"$'\n'"- \`usage\` - Canonical usage example (code)"$'\n'"- \`example\` - An example of usage (code, many)"$'\n'"- \`depends\` - Any dependencies (list)"$'\n'"Summary: Generate a set of name/value pairs to document bash entities"$'\n'"Argument: fn - String. Required. Name of \`fn\`"$'\n'"Argument: sourceFile - File. Required."$'\n'"Argument: sourceLine - PositiveInteger. Optional."$'\n'"Argument: --generate - Flag. Optional. Generate cached files."$'\n'"Argument: --no-cache - Flag. Optional. Skip any attempt to cache anything."$'\n'"Argument: --cache - Flag. Optional. Force use of cache."$'\n'"Argument: --function - Flag. Optional. Function derivations \`return_code\` \`fn\` \`lowerFn\` \`fnMarker\` \`argument\` \`usage\`"$'\n'"Argument: --environment - Flag. Optional. Environment variable derivations \`env\` \`envMarker\`"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"stdin: Pipe stripped comments to extract information"$'\n'"BUILD_DEBUG: usage-cache-skip - Skip caching by default (override with \`--cache\`)"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceHash="7487e1e4be50d4eb634f007bfd41adda45ab6d68"
sourceLine="60"
stdin="Pipe stripped comments to extract information"$'\n'""
summary="Generate a set of name/value pairs to document bash entities"
summaryComputed=""
usage="bashDocumentationExtract [ --generate ] [ --no-cache | --cache ] [ --help ] handler function sourceFile"$'\n'""
