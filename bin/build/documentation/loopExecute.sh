#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="loopCallable - Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails."$'\n'"--delay delaySeconds - Integer. Optional. Delay in seconds between checks in interactive mode."$'\n'"--until exitCode - Integer. Optional. Check until exit code matches this."$'\n'"--title title - String. Optional. Display this title instead of the command."$'\n'"arguments ... - Optional. Arguments. Arguments to \`loopCallable\`"$'\n'""
base="interactive.sh"
description="Run checks interactively until errors are all fixed."$'\n'""
file="bin/build/tools/interactive.sh"
fn="loopExecute"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceModified="1768759374"
summary="Run checks interactively until errors are all fixed."
usage="loopExecute loopCallable [ --delay delaySeconds ] [ --until exitCode ] [ --title title ] [ arguments ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mloopExecute[0m [38;2;255;255;0m[35;48;2;0;0;0mloopCallable[0m[0m [94m[ --delay delaySeconds ][0m [94m[ --until exitCode ][0m [94m[ --title title ][0m [94m[ arguments ... ][0m

    [31mloopCallable          [1;97mCallable. Required. Call this on each file and a zero result code means passed and non-zero means fails.[0m
    [94m--delay delaySeconds  [1;97mInteger. Optional. Delay in seconds between checks in interactive mode.[0m
    [94m--until exitCode      [1;97mInteger. Optional. Check until exit code matches this.[0m
    [94m--title title         [1;97mString. Optional. Display this title instead of the command.[0m
    [94marguments ...         [1;97mOptional. Arguments. Arguments to [38;2;0;255;0;48;2;0;0;0mloopCallable[0m[0m

Run checks interactively until errors are all fixed.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: loopExecute loopCallable [ --delay delaySeconds ] [ --until exitCode ] [ --title title ] [ arguments ... ]

    loopCallable          Callable. Required. Call this on each file and a zero result code means passed and non-zero means fails.
    --delay delaySeconds  Integer. Optional. Delay in seconds between checks in interactive mode.
    --until exitCode      Integer. Optional. Check until exit code matches this.
    --title title         String. Optional. Display this title instead of the command.
    arguments ...         Optional. Arguments. Arguments to loopCallable

Run checks interactively until errors are all fixed.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
