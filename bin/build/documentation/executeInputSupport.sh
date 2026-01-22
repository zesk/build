#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/sugar.sh"
argument="executor ... -- - The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial \`--\`."$'\n'"-- - Alone after the executor forces \`stdin\` to be ignored. The \`--\` flag is also removed from the arguments passed to the executor."$'\n'"... - Any additional arguments are passed directly to the executor"$'\n'""
base="sugar.sh"
description="Support arguments and stdin as arguments to an executor"$'\n'""
file="bin/build/tools/sugar.sh"
fn="executeInputSupport"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/sugar.sh"
sourceModified="1769063211"
summary="Support arguments and stdin as arguments to an executor"
usage="executeInputSupport [ executor ... -- ] [ -- ] [ ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mexecuteInputSupport[0m [94m[ executor ... -- ][0m [94m[ -- ][0m [94m[ ... ][0m

    [94mexecutor ... --  [1;97mThe command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial [38;2;0;255;0;48;2;0;0;0m--[0m.[0m
    [94m--               [1;97mAlone after the executor forces [38;2;0;255;0;48;2;0;0;0mstdin[0m to be ignored. The [38;2;0;255;0;48;2;0;0;0m--[0m flag is also removed from the arguments passed to the executor.[0m
    [94m...              [1;97mAny additional arguments are passed directly to the executor[0m

Support arguments and stdin as arguments to an executor

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: executeInputSupport [ executor ... -- ] [ -- ] [ ... ]

    executor ... --  The command to run on each line of input or on each additional argument. Arguments to prefix the final variable argument can be supplied prior to an initial --.
    --               Alone after the executor forces stdin to be ignored. The -- flag is also removed from the arguments passed to the executor.
    ...              Any additional arguments are passed directly to the executor

Support arguments and stdin as arguments to an executor

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
