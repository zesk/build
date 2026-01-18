#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="--remove - Flag. Optional. Remove instead of add - only \`group\`, and \`description\` required."$'\n'"--add - Flag. Optional. Add to security group (default)."$'\n'"--register - Flag. Optional. Add it if not already added."$'\n'"--group group - String. Required. Security Group ID"$'\n'"--region region - String. Optional. AWS region, defaults to \`AWS_REGION\`. Must be supplied."$'\n'"--port port - Required. for \`--add\` only. Integer. service port"$'\n'"--description description - String. Required. Description to identify this record."$'\n'"--ip ip - Required. for \`--add\` only. String. IP Address to add or remove."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="aws.sh"
description="Usages can be"$'\n'""$'\n'"    {fn} --add --group group [ --region region ] --port port --description description --ip ip"$'\n'"    {fn} --remove --group group [ --region region ] --description description"$'\n'""$'\n'"Modify an EC2 Security Group and add or remove an IP/port combination to the group."$'\n'""
file="bin/build/tools/aws.sh"
fn="awsSecurityGroupIPModify"
foundNames=([0]="argument" [1]="summary")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/aws.sh"
sourceModified="1768758981"
summary="Modify an EC2 Security Group"$'\n'""
usage="awsSecurityGroupIPModify --remove [ --add ] [ --register ] --group group [ --region region ] --port port --description description --ip ip [ --help ]"
