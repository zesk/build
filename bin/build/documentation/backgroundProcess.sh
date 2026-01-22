#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/prompt-modules.sh"
argument="--verbose - Flag. Optional. Be verbose."$'\n'"--report - Flag. Optional. Show a long report of all processes."$'\n'"--summary - Flag. Optional. Show a summary of all processes."$'\n'"--monitor - Flag. Optional. Interactively show report and refresh."$'\n'"--watch - Flag. Optional. Repeat showing summary."$'\n'"--verbose-toggle - Flag. Optional. Toggle the global verbose reporting."$'\n'"--terminate - Flag. Optional. Terminate all processes and delete all background process records."$'\n'"--go - Flag. Optional. Check all process states and update them."$'\n'"--new-only - Flag. Optional. Output a message for new processes only."$'\n'"--stop stopSeconds - PositiveInteger. Optional. Check every stop seconds after starting to see if should be stopped."$'\n'"--wait waitSeconds - PositiveInteger. Optional. After stopping, wait this many seconds before trying again."$'\n'"--frequency checkSeconds - PositiveInteger. Optional. Check condition at this frequency."$'\n'"condition ... - Callable. Required. Condition to test. Output of this is compared to see if we should stop process and restart it."$'\n'"-- - Delimiter. Required. Separates command."$'\n'"command ... - Callable. Required. Function to run in the background."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="prompt-modules.sh"
description="> UNSTABLE: Seems this does not handle long processes well which do not quit quickly. Need to improve testing. Use"$'\n'"> at your own risk. (2026-01-12 KMD)"$'\n'""$'\n'"Run a single process in the background continuously until a condition is met."$'\n'""$'\n'"\`condition\` and \`command\` required when an action flag is not specified."$'\n'""$'\n'"Action flags:"$'\n'""$'\n'"    --go --report --monitor --verbose-toggle --stop-all --summary"$'\n'""$'\n'"This can be used to run processes on your code in the background."$'\n'""$'\n'"The \`condition\` should output *any* form of output which, when it changes (or exits non-zero), will require the \`command\` to be run."$'\n'"As long as the \`condition\` remains the same between calls, \`command\` is not run."$'\n'""$'\n'"Once \`command\` is run the process is monitored; and every \`stopSeconds\` seconds \`condition\` is run again - if \`condition\` changes"$'\n'"between the starting value and the new value then the command is terminated. The manager waits \`waitSeconds\` and then runs \`command\`"$'\n'"again. (Capturing \`condition\` at the start.)"$'\n'""$'\n'"If \`condition\` exits zero – then it is simply run every \`checkSeconds\` seconds to see if \`command\` needs to be run again."$'\n'""$'\n'"This allows you to have background processes which, while you edit your code, for example, will pause momentarily while you edit and not use up"$'\n'"all of your available CPU."$'\n'""$'\n'"To see status, try:"$'\n'""$'\n'"    {fn} --summary"$'\n'"    {fn} --report"$'\n'"    {fn} --monitor"$'\n'"    {fn} --watch"$'\n'""$'\n'""
file="bin/build/tools/prompt-modules.sh"
fn="backgroundProcess"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/prompt-modules.sh"
sourceModified="1768721469"
summary="Background process manager for shell (UNSTABLE)"$'\n'""
usage="backgroundProcess [ --verbose ] [ --report ] [ --summary ] [ --monitor ] [ --watch ] [ --verbose-toggle ] [ --terminate ] [ --go ] [ --new-only ] [ --stop stopSeconds ] [ --wait waitSeconds ] [ --frequency checkSeconds ] condition ... -- command ... [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbackgroundProcess[0m [94m[ --verbose ][0m [94m[ --report ][0m [94m[ --summary ][0m [94m[ --monitor ][0m [94m[ --watch ][0m [94m[ --verbose-toggle ][0m [94m[ --terminate ][0m [94m[ --go ][0m [94m[ --new-only ][0m [94m[ --stop stopSeconds ][0m [94m[ --wait waitSeconds ][0m [94m[ --frequency checkSeconds ][0m [38;2;255;255;0m[35;48;2;0;0;0mcondition ...[0m[0m [38;2;255;255;0m[35;48;2;0;0;0m [38;2;255;255;0m[35;48;2;0;0;0mcommand ...[0m[0m [94m[ --help ][0m

    [94m--verbose                 [1;97mFlag. Optional. Be verbose.[0m
    [94m--report                  [1;97mFlag. Optional. Show a long report of all processes.[0m
    [94m--summary                 [1;97mFlag. Optional. Show a summary of all processes.[0m
    [94m--monitor                 [1;97mFlag. Optional. Interactively show report and refresh.[0m
    [94m--watch                   [1;97mFlag. Optional. Repeat showing summary.[0m
    [94m--verbose-toggle          [1;97mFlag. Optional. Toggle the global verbose reporting.[0m
    [94m--terminate               [1;97mFlag. Optional. Terminate all processes and delete all background process records.[0m
    [94m--go                      [1;97mFlag. Optional. Check all process states and update them.[0m
    [94m--new-only                [1;97mFlag. Optional. Output a message for new processes only.[0m
    [94m--stop stopSeconds        [1;97mPositiveInteger. Optional. Check every stop seconds after starting to see if should be stopped.[0m
    [94m--wait waitSeconds        [1;97mPositiveInteger. Optional. After stopping, wait this many seconds before trying again.[0m
    [94m--frequency checkSeconds  [1;97mPositiveInteger. Optional. Check condition at this frequency.[0m
    [31mcondition ...             [1;97mCallable. Required. Condition to test. Output of this is compared to see if we should stop process and restart it.[0m
    [31m--                        [1;97mDelimiter. Required. Separates command.[0m
    [31mcommand ...               [1;97mCallable. Required. Function to run in the background.[0m
    [94m--help                    [1;97mFlag. Optional. Display this help.[0m

> UNSTABLE: Seems this does not handle long processes well which do not quit quickly. Need to improve testing. Use
> at your own risk. (2026-01-12 KMD)

Run a single process in the background continuously until a condition is met.

[38;2;0;255;0;48;2;0;0;0mcondition[0m and [38;2;0;255;0;48;2;0;0;0mcommand[0m required when an action flag is not specified.

Action flags:

    --go --report --monitor --verbose-toggle --stop-all --summary

This can be used to run processes on your code in the background.

The [38;2;0;255;0;48;2;0;0;0mcondition[0m should output [36many[0m form of output which, when it changes (or exits non-zero), will require the [38;2;0;255;0;48;2;0;0;0mcommand[0m to be run.
As long as the [38;2;0;255;0;48;2;0;0;0mcondition[0m remains the same between calls, [38;2;0;255;0;48;2;0;0;0mcommand[0m is not run.

Once [38;2;0;255;0;48;2;0;0;0mcommand[0m is run the process is monitored; and every [38;2;0;255;0;48;2;0;0;0mstopSeconds[0m seconds [38;2;0;255;0;48;2;0;0;0mcondition[0m is run again - if [38;2;0;255;0;48;2;0;0;0mcondition[0m changes
between the starting value and the new value then the command is terminated. The manager waits [38;2;0;255;0;48;2;0;0;0mwaitSeconds[0m and then runs [38;2;0;255;0;48;2;0;0;0mcommand[0m
again. (Capturing [38;2;0;255;0;48;2;0;0;0mcondition[0m at the start.)

If [38;2;0;255;0;48;2;0;0;0mcondition[0m exits zero – then it is simply run every [38;2;0;255;0;48;2;0;0;0mcheckSeconds[0m seconds to see if [38;2;0;255;0;48;2;0;0;0mcommand[0m needs to be run again.

This allows you to have background processes which, while you edit your code, for example, will pause momentarily while you edit and not use up
all of your available CPU.

To see status, try:

    backgroundProcess --summary
    backgroundProcess --report
    backgroundProcess --monitor
    backgroundProcess --watch

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: backgroundProcess [ --verbose ] [ --report ] [ --summary ] [ --monitor ] [ --watch ] [ --verbose-toggle ] [ --terminate ] [ --go ] [ --new-only ] [ --stop stopSeconds ] [ --wait waitSeconds ] [ --frequency checkSeconds ] condition ...  command ... [ --help ]

    --verbose                 Flag. Optional. Be verbose.
    --report                  Flag. Optional. Show a long report of all processes.
    --summary                 Flag. Optional. Show a summary of all processes.
    --monitor                 Flag. Optional. Interactively show report and refresh.
    --watch                   Flag. Optional. Repeat showing summary.
    --verbose-toggle          Flag. Optional. Toggle the global verbose reporting.
    --terminate               Flag. Optional. Terminate all processes and delete all background process records.
    --go                      Flag. Optional. Check all process states and update them.
    --new-only                Flag. Optional. Output a message for new processes only.
    --stop stopSeconds        PositiveInteger. Optional. Check every stop seconds after starting to see if should be stopped.
    --wait waitSeconds        PositiveInteger. Optional. After stopping, wait this many seconds before trying again.
    --frequency checkSeconds  PositiveInteger. Optional. Check condition at this frequency.
    condition ...             Callable. Required. Condition to test. Output of this is compared to see if we should stop process and restart it.
    --                        Delimiter. Required. Separates command.
    command ...               Callable. Required. Function to run in the background.
    --help                    Flag. Optional. Display this help.

> UNSTABLE: Seems this does not handle long processes well which do not quit quickly. Need to improve testing. Use
> at your own risk. (2026-01-12 KMD)

Run a single process in the background continuously until a condition is met.

condition and command required when an action flag is not specified.

Action flags:

    --go --report --monitor --verbose-toggle --stop-all --summary

This can be used to run processes on your code in the background.

The condition should output any form of output which, when it changes (or exits non-zero), will require the command to be run.
As long as the condition remains the same between calls, command is not run.

Once command is run the process is monitored; and every stopSeconds seconds condition is run again - if condition changes
between the starting value and the new value then the command is terminated. The manager waits waitSeconds and then runs command
again. (Capturing condition at the start.)

If condition exits zero – then it is simply run every checkSeconds seconds to see if command needs to be run again.

This allows you to have background processes which, while you edit your code, for example, will pause momentarily while you edit and not use up
all of your available CPU.

To see status, try:

    backgroundProcess --summary
    backgroundProcess --report
    backgroundProcess --monitor
    backgroundProcess --watch

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
