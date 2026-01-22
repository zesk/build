#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="... - Arguments. Required. printf arguments."$'\n'""
base="text.sh"
description="Pipe to output some text before any output, otherwise, nothing is output."$'\n'"Without arguments, displays help."$'\n'""
file="bin/build/tools/text.sh"
fn="printfOutputPrefix"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/text.sh"
sourceModified="1768776345"
stdin="text (Optional)"$'\n'""
stdout="printf output and then the stdin text IFF stdin text is non-blank"$'\n'""
summary="Pipe to output some text before any output, otherwise, nothing"
usage="printfOutputPrefix ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mprintfOutputPrefix[0m [38;2;255;255;0m[35;48;2;0;0;0m...[0m[0m

    [31m...  [1;97mArguments. Required. printf arguments.[0m

Pipe to output some text before any output, otherwise, nothing is output.
Without arguments, displays help.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from [38;2;0;255;0;48;2;0;0;0mstdin[0m:
text (Optional)

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
printf output and then the stdin text IFF stdin text is non-blank
'
# shellcheck disable=SC2016
helpPlain='Usage: printfOutputPrefix ...

    ...  Arguments. Required. printf arguments.

Pipe to output some text before any output, otherwise, nothing is output.
Without arguments, displays help.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Reads from stdin:
text (Optional)

Writes to stdout:
printf output and then the stdin text IFF stdin text is non-blank
'
