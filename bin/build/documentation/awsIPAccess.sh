#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--profile profileName - String. Optional. Use this AWS profile when connecting using ~/.aws/credentials"$'\n'"--services service0,service1,... - List. Required. List of services to add or remove (service names or port numbers)"$'\n'"--id developerId - String. Optional. Specify an developer id manually (uses DEVELOPER_ID from environment by default)"$'\n'"--group securityGroup - String.  String. Required. Specify one or more security groups to modify. Format: \`sg-\` followed by hexadecimal characters."$'\n'"--ip ip - IP. Optional. Specify bn IP manually (uses ipLookup tool from tools.sh by default)"$'\n'"--revoke - Flag. Optional. Remove permissions"$'\n'"--help - Flag. Optional. Show this help"$'\n'""
base="aws.sh"
description="Register current IP address in listed security groups to allow for access to deployment systems from a specific IP."$'\n'"Use this during deployment to grant temporary access to your systems during deployment only."$'\n'"Build scripts should have a \`awsIPAccess --revoke\` step afterward, always."$'\n'"services are looked up in /etc/services and match /tcp services only for port selection"$'\n'"If no \`/etc/services\` matches the default values are supported within the script: \`mysql\`,\`postgres\`,\`ssh\`,\`http\`,\`https\`"$'\n'"You can also simply supply a list of port numbers, and mix and match: \`--services ssh,http,3306,12345\` is valid"$'\n'""
environment="AWS_REGION"$'\n'"DEVELOPER_ID"$'\n'"AWS_ACCESS_KEY_ID"$'\n'"AWS_SECRET_ACCESS_KEY"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsIPAccess"
foundNames=([0]="summary" [1]="argument" [2]="environment")
rawComment="Summary: Grant access to AWS security group for this IP only using Amazon IAM credentials"$'\n'"Argument: --profile profileName - String. Optional. Use this AWS profile when connecting using ~/.aws/credentials"$'\n'"Argument: --services service0,service1,... - List. Required. List of services to add or remove (service names or port numbers)"$'\n'"Argument: --id developerId - String. Optional. Specify an developer id manually (uses DEVELOPER_ID from environment by default)"$'\n'"Argument: --group securityGroup - String.  String. Required. Specify one or more security groups to modify. Format: \`sg-\` followed by hexadecimal characters."$'\n'"Argument: --ip ip - IP. Optional. Specify bn IP manually (uses ipLookup tool from tools.sh by default)"$'\n'"Argument: --revoke - Flag. Optional. Remove permissions"$'\n'"Argument: --help - Flag. Optional. Show this help"$'\n'"Register current IP address in listed security groups to allow for access to deployment systems from a specific IP."$'\n'"Use this during deployment to grant temporary access to your systems during deployment only."$'\n'"Build scripts should have a \`awsIPAccess --revoke\` step afterward, always."$'\n'"services are looked up in /etc/services and match /tcp services only for port selection"$'\n'"If no \`/etc/services\` matches the default values are supported within the script: \`mysql\`,\`postgres\`,\`ssh\`,\`http\`,\`https\`"$'\n'"You can also simply supply a list of port numbers, and mix and match: \`--services ssh,http,3306,12345\` is valid"$'\n'"Environment: AWS_REGION"$'\n'"Environment: DEVELOPER_ID"$'\n'"Environment: AWS_ACCESS_KEY_ID"$'\n'"Environment: AWS_SECRET_ACCESS_KEY"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceHash="3b62faeca80ac2a7aa667991589c611b8a721864"
summary="Grant access to AWS security group for this IP only using Amazon IAM credentials"$'\n'""
usage="awsIPAccess [ --profile profileName ] --services service0,service1,... [ --id developerId ] --group securityGroup [ --ip ip ] [ --revoke ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
