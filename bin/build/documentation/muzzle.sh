#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sugar.sh"
argument="command - Callable. Required. Thing to muzzle."$'\n'"... - Arguments. Optional. Additional arguments."$'\n'""
base="sugar.sh"
description="Suppress stdout without piping. Handy when you just want a behavior not the output."$'\n'""
example="    muzzle pushd \"\$buildDir\""$'\n'"    catchEnvironment \"\$handler\" phpBuild || returnUndo \$? muzzle popd || return \$?"$'\n'""
file="bin/build/tools/sugar.sh"
fn="muzzle"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sugar.sh"
sourceModified="1769063211"
stdout="- No output from stdout ever from this function"$'\n'""
summary="Suppress stdout without piping. Handy when you just want a"
usage="muzzle command [ ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmuzzle[0m [38;2;255;255;0m[35;48;2;0;0;0mcommand[0m[0m [94m[ ... ][0m

    [31mcommand  [1;97mCallable. Required. Thing to muzzle.[0m
    [94m...      [1;97mArguments. Optional. Additional arguments.[0m

Suppress stdout without piping. Handy when you just want a behavior not the output.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
- No output from stdout ever from this function

Example:
    muzzle pushd "$buildDir"
    catchEnvironment "$handler" phpBuild || returnUndo $? muzzle popd || return $?
'
# shellcheck disable=SC2016
helpPlain='Usage: muzzle command [ ... ]

    command  Callable. Required. Thing to muzzle.
    ...      Arguments. Optional. Additional arguments.

Suppress stdout without piping. Handy when you just want a behavior not the output.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
- No output from stdout ever from this function

Example:
    muzzle pushd "$buildDir"
    catchEnvironment "$handler" phpBuild || returnUndo $? muzzle popd || return $?
'
