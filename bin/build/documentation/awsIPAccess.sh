#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="--profile profileName - String. Optional. Use this AWS profile when connecting using ~/.aws/credentials"$'\n'"--services service0,service1,... - List. Required. List of services to add or remove (service names or port numbers)"$'\n'"--id developerId - String. Optional. Specify an developer id manually (uses DEVELOPER_ID from environment by default)"$'\n'"--group securityGroup - String.  String. Required. Specify one or more security groups to modify. Format: \`sg-\` followed by hexadecimal characters."$'\n'"--ip ip - IP. Optional. Specify bn IP manually (uses ipLookup tool from tools.sh by default)"$'\n'"--revoke - Flag. Optional. Remove permissions"$'\n'"--help - Flag. Optional. Show this help"$'\n'""
base="aws.sh"
description="Register current IP address in listed security groups to allow for access to deployment systems from a specific IP."$'\n'"Use this during deployment to grant temporary access to your systems during deployment only."$'\n'"Build scripts should have a \$(decorate code --revoke) step afterward, always."$'\n'"services are looked up in /etc/services and match /tcp services only for port selection"$'\n'""$'\n'"If no \`/etc/services\` matches the default values are supported within the script: \`mysql\`,\`postgres\`,\`ssh\`,\`http\`,\`https\`"$'\n'"You can also simply supply a list of port numbers, and mix and match: \`--services ssh,http,3306,12345\` is valid"$'\n'""
environment="AWS_REGION"$'\n'"DEVELOPER_ID"$'\n'"AWS_ACCESS_KEY_ID"$'\n'"AWS_SECRET_ACCESS_KEY"$'\n'""
file="bin/build/tools/aws.sh"
fn="awsIPAccess"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceModified="1768758981"
summary="Grant access to AWS security group for this IP only using Amazon IAM credentials"$'\n'""
usage="awsIPAccess [ --profile profileName ] --services service0,service1,... [ --id developerId ] --group securityGroup [ --ip ip ] [ --revoke ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mawsIPAccess[0m [94m[ --profile profileName ][0m [38;2;255;255;0m[35;48;2;0;0;0m--services service0,service1,...[0m[0m [94m[ --id developerId ][0m [38;2;255;255;0m[35;48;2;0;0;0m--group securityGroup[0m[0m [94m[ --ip ip ][0m [94m[ --revoke ][0m [94m[ --help ][0m

    [94m--profile profileName             [1;97mString. Optional. Use this AWS profile when connecting using ~/.aws/credentials[0m
    [31m--services service0,service1,...  [1;97mList. Required. List of services to add or remove (service names or port numbers)[0m
    [94m--id developerId                  [1;97mString. Optional. Specify an developer id manually (uses DEVELOPER_ID from environment by default)[0m
    [31m--group securityGroup             [1;97mString.  String. Required. Specify one or more security groups to modify. Format: [38;2;0;255;0;48;2;0;0;0msg-[0m followed by hexadecimal characters.[0m
    [94m--ip ip                           [1;97mIP. Optional. Specify bn IP manually (uses ipLookup tool from tools.sh by default)[0m
    [94m--revoke                          [1;97mFlag. Optional. Remove permissions[0m
    [94m--help                            [1;97mFlag. Optional. Show this help[0m

Register current IP address in listed security groups to allow for access to deployment systems from a specific IP.
Use this during deployment to grant temporary access to your systems during deployment only.
Build scripts should have a $(decorate code --revoke) step afterward, always.
services are looked up in /etc/services and match /tcp services only for port selection

If no [38;2;0;255;0;48;2;0;0;0m/etc/services[0m matches the default values are supported within the script: [38;2;0;255;0;48;2;0;0;0mmysql[0m,[38;2;0;255;0;48;2;0;0;0mpostgres[0m,[38;2;0;255;0;48;2;0;0;0mssh[0m,[38;2;0;255;0;48;2;0;0;0mhttp[0m,[38;2;0;255;0;48;2;0;0;0mhttps[0m
You can also simply supply a list of port numbers, and mix and match: [38;2;0;255;0;48;2;0;0;0m--services ssh,http,3306,12345[0m is valid

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- AWS_REGION
- DEVELOPER_ID
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: awsIPAccess [ --profile profileName ] --services service0,service1,... [ --id developerId ] --group securityGroup [ --ip ip ] [ --revoke ] [ --help ]

    --profile profileName             String. Optional. Use this AWS profile when connecting using ~/.aws/credentials
    --services service0,service1,...  List. Required. List of services to add or remove (service names or port numbers)
    --id developerId                  String. Optional. Specify an developer id manually (uses DEVELOPER_ID from environment by default)
    --group securityGroup             String.  String. Required. Specify one or more security groups to modify. Format: sg- followed by hexadecimal characters.
    --ip ip                           IP. Optional. Specify bn IP manually (uses ipLookup tool from tools.sh by default)
    --revoke                          Flag. Optional. Remove permissions
    --help                            Flag. Optional. Show this help

Register current IP address in listed security groups to allow for access to deployment systems from a specific IP.
Use this during deployment to grant temporary access to your systems during deployment only.
Build scripts should have a $(decorate code --revoke) step afterward, always.
services are looked up in /etc/services and match /tcp services only for port selection

If no /etc/services matches the default values are supported within the script: mysql,postgres,ssh,http,https
You can also simply supply a list of port numbers, and mix and match: --services ssh,http,3306,12345 is valid

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- AWS_REGION
- DEVELOPER_ID
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- 
'
