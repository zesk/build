#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/node.sh"
argument="action - String. Optional. Action to perform: install run update uninstall"$'\n'"... - Arguments. Required. Passed to the node package manager. Required. when action is provided."$'\n'""
base="node.sh"
description="Run an action using the current node package manager"$'\n'"Provides an abstraction to libraries to support any node package manager."$'\n'"Optionally will output the current node package manager when no arguments are passed."$'\n'"No-Argument: Outputs the current node package manager code name"$'\n'""
file="bin/build/tools/node.sh"
fn="nodePackageManager"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/node.sh"
sourceModified="1769063211"
summary="Run an action using the current node package manager"
usage="nodePackageManager [ action ] ..."
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mnodePackageManager[0m [94m[ action ][0m [38;2;255;255;0m[35;48;2;0;0;0m...[0m[0m

    [94maction  [1;97mString. Optional. Action to perform: install run update uninstall[0m
    [31m...     [1;97mArguments. Required. Passed to the node package manager. Required. when action is provided.[0m

Run an action using the current node package manager
Provides an abstraction to libraries to support any node package manager.
Optionally will output the current node package manager when no arguments are passed.
No-Argument: Outputs the current node package manager code name

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: nodePackageManager [ action ] ...

    action  String. Optional. Action to perform: install run update uninstall
    ...     Arguments. Required. Passed to the node package manager. Required. when action is provided.

Run an action using the current node package manager
Provides an abstraction to libraries to support any node package manager.
Optionally will output the current node package manager when no arguments are passed.
No-Argument: Outputs the current node package manager code name

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
