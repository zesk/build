#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'groupName - String. Required. Group name to convert to a group ID\n'
base="group.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Convert a group name to a group ID\n\n'
descriptionLineCount="2"
file="bin/build/tools/group.sh"
fn="groupID"
fnMarker="groupid"
foundNames=([0]="argument" [1]="stdout" [2]="return_code" [3]="requires")
line="17"
rawComment=$'Convert a group name to a group ID\nArgument: groupName - String. Required. Group name to convert to a group ID\nstdout: `Integer`. One line for each group name passed as an argument.\nReturn Code: 0 - All groups were found in the database and IDs were output successfully\nReturn Code: 1 - Any group is not found in the database.\nReturn Code: 2 - Argument errors (blank argument)\nRequires: throwArgument getent cut printf bashDocumentation decorate grep  quoteGrepPattern\n\n'
requires=$'throwArgument getent cut printf bashDocumentation decorate grep  quoteGrepPattern\n'
return_code=$'0 - All groups were found in the database and IDs were output successfully\n1 - Any group is not found in the database.\n2 - Argument errors (blank argument)\n'
sourceFile="bin/build/tools/group.sh"
sourceHash="7d79055f81ebfe5cd03a32d8f79c7ea73eec7eac"
sourceLine="17"
stdout=$'`Integer`. One line for each group name passed as an argument.\n'
summary="Convert a group name to a group ID"
summaryComputed="true"
usage="groupID groupName"
