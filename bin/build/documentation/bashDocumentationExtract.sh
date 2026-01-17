#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/documentation.sh"
argument="function - String. Required. Function defined in \`file\`"$'\n'"sourceFile - File. Required. File where the function is defined."$'\n'"--help -  Flag. Optional.Display this help."$'\n'""
base="documentation.sh"
build_debug="documentation-cache - Saves information to \`bin/build/documentation\`"$'\n'""
description="Extract documentation variables from a comment stripped of the '# ' prefixes."$'\n'""$'\n'"A few special values are generated/computed:"$'\n'""$'\n'"- \`description\` - Any line in the comment which is not in variable is appended to the field \`description\`"$'\n'"- \`fn\` - The function name (no parenthesis or anything)"$'\n'"- \`base\` - The basename of the file"$'\n'"- \`file\` - The relative path name of the file from the application root"$'\n'"- \`summary\` - Defaults to first ten words of \`description\`"$'\n'"- \`exit_code\` - Defaults to \`0 - Always succeeds\`"$'\n'"- \`reviewed\`  - Defaults to \`Never\`"$'\n'"- \`environment\"  - Defaults to \`No environment dependencies or modifications.\`"$'\n'""$'\n'"Otherwise the assumed variables (in addition to above) to define functions are:"$'\n'""$'\n'"- \`argument\` - Individual arguments"$'\n'"- \`usage\` - Canonical usage example (code)"$'\n'"- \`example\` - An example of usage (code, many)"$'\n'"- \`depends\` - Any dependencies (list)"$'\n'""$'\n'""
file="bin/build/tools/documentation.sh"
fn="bashDocumentationExtract"
foundNames=([0]="summary" [1]="argument" [2]="stdin" [3]="build_debug")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/documentation.sh"
sourceModified="1768683999"
stdin="Pipe stripped comments to extract information"$'\n'""
summary="Generate a set of name/value pairs to document bash functions"$'\n'""
usage="bashDocumentationExtract function sourceFile [ --help ]"
