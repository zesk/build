#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/identical.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"... - Arguments. Required. Arguments to \`identicalCheck\` for your watch."$'\n'""
base="identical.sh"
description="Watch a project for changes and propagate them immediately upon save. Can be quite dangerous so use with caution."$'\n'"Still a known bug which trims the last end bracket from files"$'\n'""
file="bin/build/tools/identical.sh"
fn="identicalWatch"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/identical.sh"
sourceModified="1768721469"
summary="Watch a project for changes and propagate them immediately upon"
usage="identicalWatch [ --help ] [ --handler handler ] ..."
