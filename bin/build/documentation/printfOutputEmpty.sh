#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-13
# shellcheck disable=SC2034
argument="... - Arguments. Required. printf arguments."$'\n'""
base="text.sh"
description="Pipes all input to output, if any input exists behaves like \`cat\`. If input is empty then runs and outputs the \`printf\` statement result."$'\n'"Without arguments, displays help."$'\n'""
example="    cat \"\$failedFunctions\" | decorate wrap -- \"- \" | printfOutputEmpty \"%s\\n\" \"No functions failed.\""$'\n'""
file="bin/build/tools/text.sh"
fn="printfOutputEmpty"
foundNames=([0]="summary" [1]="argument" [2]="stdin" [3]="stdout" [4]="example")
rawComment="Summary: printf when output is blank"$'\n'"Pipes all input to output, if any input exists behaves like \`cat\`. If input is empty then runs and outputs the \`printf\` statement result."$'\n'"Argument: ... - Arguments. Required. printf arguments."$'\n'"Without arguments, displays help."$'\n'"stdin: text (Optional)"$'\n'"stdout: printf output and then the stdin text IFF stdin text is blank"$'\n'"Example:     cat \"\$failedFunctions\" | decorate wrap -- \"- \" | {fn} \"%s\\n\" \"No functions failed.\""$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceHash="f0c5212f3e402f51e272ac32015e5e0be9f2581c"
stdin="text (Optional)"$'\n'""
stdout="printf output and then the stdin text IFF stdin text is blank"$'\n'""
summary="printf when output is blank"$'\n'""
usage="printfOutputEmpty ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mprintfOutputEmpty'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]m...  '$'\e''[[(value)]mArguments. Required. printf arguments.'$'\e''[[(reset)]m'$'\n'''$'\n''Pipes all input to output, if any input exists behaves like '$'\e''[[(code)]mcat'$'\e''[[(reset)]m. If input is empty then runs and outputs the '$'\e''[[(code)]mprintf'$'\e''[[(reset)]m statement result.'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Reads from '$'\e''[[(code)]mstdin'$'\e''[[(reset)]m:'$'\n''text (Optional)'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''printf output and then the stdin text IFF stdin text is blank'$'\n'''$'\n''Example:'$'\n''    cat "$failedFunctions" | decorate wrap -- "- " | printfOutputEmpty "%s\n" "No functions failed."'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: printfOutputEmpty ...'$'\n'''$'\n''    ...  Arguments. Required. printf arguments.'$'\n'''$'\n''Pipes all input to output, if any input exists behaves like cat. If input is empty then runs and outputs the printf statement result.'$'\n''Without arguments, displays help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Reads from stdin:'$'\n''text (Optional)'$'\n'''$'\n''Writes to stdout:'$'\n''printf output and then the stdin text IFF stdin text is blank'$'\n'''$'\n''Example:'$'\n''    cat "$failedFunctions" | decorate wrap -- "- " | printfOutputEmpty "%s\n" "No functions failed."'$'\n'''
