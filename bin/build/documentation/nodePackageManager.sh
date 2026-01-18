#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/node.sh"
argument="action - Optional. Action to perform: install run update uninstall"$'\n'"... - Arguments. Required. Passed to the node package manager. Required. when action is provided."$'\n'""
base="node.sh"
description="Run an action using the current node package manager"$'\n'"Provides an abstraction to libraries to support any node package manager."$'\n'"Optionally will output the current node package manager when no arguments are passed."$'\n'"No-Argument: Outputs the current node package manager code name"$'\n'""
file="bin/build/tools/node.sh"
fn="nodePackageManager"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/node.sh"
sourceModified="1768695708"
summary="Run an action using the current node package manager"
usage="nodePackageManager [ action ] ..."
