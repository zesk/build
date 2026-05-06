#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--remove - Flag. Optional. Remove instead of add - only \`group\`, and \`description\` required."$'\n'"--add - Flag. Optional. Add to security group (default)."$'\n'"--register - Flag. Optional. Add it if not already added."$'\n'"--group group - String. Required. Security Group ID"$'\n'"--region region - String. Optional. AWS region, defaults to \`AWS_REGION\`. Must be supplied."$'\n'"--port port - Required. for \`--add\` only. Integer. service port"$'\n'"--description description - String. Required. Description to identify this record."$'\n'"--ip ip - Required. for \`--add\` only. String. IP Address to add or remove."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="aws.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Usages can be"$'\n'""$'\n'"    {fn} --add --group group [ --region region ] --port port --description description --ip ip"$'\n'"    {fn} --remove --group group [ --region region ] --description description"$'\n'""$'\n'"Modify an EC2 Security Group and add or remove an IP/port combination to the group."$'\n'""$'\n'""
descriptionLineCount="7"
file="bin/build/tools/aws.sh"
fn="awsSecurityGroupIPModify"
fnMarker="awssecuritygroupipmodify"
foundNames=([0]="argument" [1]="summary")
line="283"
rawComment="Usages can be"$'\n'"    {fn} --add --group group [ --region region ] --port port --description description --ip ip"$'\n'"    {fn} --remove --group group [ --region region ] --description description"$'\n'"Argument: --remove - Flag. Optional. Remove instead of add - only \`group\`, and \`description\` required."$'\n'"Argument: --add - Flag. Optional. Add to security group (default)."$'\n'"Argument: --register - Flag. Optional. Add it if not already added."$'\n'"Argument: --group group - String. Required. Security Group ID"$'\n'"Argument: --region region - String. Optional. AWS region, defaults to \`AWS_REGION\`. Must be supplied."$'\n'"Argument: --port port - Required. for \`--add\` only. Integer. service port"$'\n'"Argument: --description description - String. Required. Description to identify this record."$'\n'"Argument: --ip ip - Required. for \`--add\` only. String. IP Address to add or remove."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Modify an EC2 Security Group and add or remove an IP/port combination to the group."$'\n'"Summary: Modify an EC2 Security Group"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3749f2a78e228db0a269cf15a470e384e355e706"
sourceLine="283"
summary="Modify an EC2 Security Group"
summaryComputed=""
usage="awsSecurityGroupIPModify --remove [ --add ] [ --register ] --group group [ --region region ] --port port --description description --ip ip [ --help ]"
