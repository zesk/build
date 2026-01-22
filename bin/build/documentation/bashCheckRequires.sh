#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--ignore prefix. String. Optional. Ignore exact function names."$'\n'"--ignore-prefix prefix - String. Optional. Ignore function names which match the prefix and do not check them."$'\n'"--report - Flag. Optional. Output a report of various functions and handler after processing is complete."$'\n'"--require - Flag. Optional. Requires at least one or more requirements to be listed and met to pass"$'\n'"--unused - Flag. Optional. Check for unused functions and report on them."$'\n'""
base="bash.sh"
description="Checks a bash script to ensure all requirements are met, outputs a list of unmet requirements"$'\n'"Scans a bash script for lines which look like:"$'\n'""$'\n'""$'\n'"Each requirement token is:"$'\n'""$'\n'"- a bash function which MUST be defined"$'\n'"- a shell script (executable) which must be present"$'\n'""$'\n'"If all requirements are met, exit status of 0."$'\n'"If any requirements are not met, exit status of 1 and a list of unmet requirements are listed"$'\n'""$'\n'""
file="bin/build/tools/bash.sh"
fn="bashCheckRequires"
foundNames=""
requires="token1 token2"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceModified="1768776883"
summary="Checks a bash script to ensure all requirements are met,"
usage="bashCheckRequires [ --help ] [ --ignore prefix. String. Optional. Ignore exact function names. ] [ --ignore-prefix prefix ] [ --report ] [ --require ] [ --unused ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashCheckRequires[0m [94m[ --help ][0m [94m[ --ignore prefix. String. Optional. Ignore exact function names. ][0m [94m[ --ignore-prefix prefix ][0m [94m[ --report ][0m [94m[ --require ][0m [94m[ --unused ][0m

    [94m--help                                                           [1;97mFlag. Optional. Display this help.[0m
    [94m--ignore prefix. String. Optional. Ignore exact function names.  [1;97m--ignore prefix. String. Optional. Ignore exact function names.[0m
    [94m--ignore-prefix prefix                                           [1;97mString. Optional. Ignore function names which match the prefix and do not check them.[0m
    [94m--report                                                         [1;97mFlag. Optional. Output a report of various functions and handler after processing is complete.[0m
    [94m--require                                                        [1;97mFlag. Optional. Requires at least one or more requirements to be listed and met to pass[0m
    [94m--unused                                                         [1;97mFlag. Optional. Check for unused functions and report on them.[0m

Checks a bash script to ensure all requirements are met, outputs a list of unmet requirements
Scans a bash script for lines which look like:


Each requirement token is:

- a bash function which MUST be defined
- a shell script (executable) which must be present

If all requirements are met, exit status of 0.
If any requirements are not met, exit status of 1 and a list of unmet requirements are listed

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashCheckRequires [ --help ] [ --ignore prefix. String. Optional. Ignore exact function names. ] [ --ignore-prefix prefix ] [ --report ] [ --require ] [ --unused ]

    --help                                                           Flag. Optional. Display this help.
    --ignore prefix. String. Optional. Ignore exact function names.  --ignore prefix. String. Optional. Ignore exact function names.
    --ignore-prefix prefix                                           String. Optional. Ignore function names which match the prefix and do not check them.
    --report                                                         Flag. Optional. Output a report of various functions and handler after processing is complete.
    --require                                                        Flag. Optional. Requires at least one or more requirements to be listed and met to pass
    --unused                                                         Flag. Optional. Check for unused functions and report on them.

Checks a bash script to ensure all requirements are met, outputs a list of unmet requirements
Scans a bash script for lines which look like:


Each requirement token is:

- a bash function which MUST be defined
- a shell script (executable) which must be present

If all requirements are met, exit status of 0.
If any requirements are not met, exit status of 1 and a list of unmet requirements are listed

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
