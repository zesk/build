#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="contextStart - Directory. Required. Context in which the command should run."$'\n'"command ... - Required. Command to run in new context."$'\n'""
base="build.sh"
description="Run a command and ensure the build tools context matches the current project"$'\n'"Avoid infinite loops here, call down."$'\n'""
file="bin/build/tools/build.sh"
fn="buildEnvironmentContext"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceModified="1769063211"
summary="Run a command and ensure the build tools context matches"
usage="buildEnvironmentContext contextStart command ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbuildEnvironmentContext[0m [38;2;255;255;0m[35;48;2;0;0;0mcontextStart[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mcommand ...[0m[0m

    [31mcontextStart  [1;97mDirectory. Required. Context in which the command should run.[0m
    [31mcommand ...   [1;97mRequired. Command to run in new context.[0m

Run a command and ensure the build tools context matches the current project
Avoid infinite loops here, call down.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: buildEnvironmentContext contextStart command ...

    contextStart  Directory. Required. Context in which the command should run.
    command ...   Required. Command to run in new context.

Run a command and ensure the build tools context matches the current project
Avoid infinite loops here, call down.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
