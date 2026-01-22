#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/aws.sh"
argument="--remove - Flag. Optional. Remove instead of add - only \`group\`, and \`description\` required."$'\n'"--add - Flag. Optional. Add to security group (default)."$'\n'"--register - Flag. Optional. Add it if not already added."$'\n'"--group group - String. Required. Security Group ID"$'\n'"--region region - String. Optional. AWS region, defaults to \`AWS_REGION\`. Must be supplied."$'\n'"--port port - Required. for \`--add\` only. Integer. service port"$'\n'"--description description - String. Required. Description to identify this record."$'\n'"--ip ip - Required. for \`--add\` only. String. IP Address to add or remove."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="aws.sh"
description="Usages can be"$'\n'""$'\n'"    {fn} --add --group group [ --region region ] --port port --description description --ip ip"$'\n'"    {fn} --remove --group group [ --region region ] --description description"$'\n'""$'\n'"Modify an EC2 Security Group and add or remove an IP/port combination to the group."$'\n'""
file="bin/build/tools/aws.sh"
fn="awsSecurityGroupIPModify"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/aws.sh"
sourceModified="1768758981"
summary="Modify an EC2 Security Group"$'\n'""
usage="awsSecurityGroupIPModify --remove [ --add ] [ --register ] --group group [ --region region ] --port port --description description --ip ip [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mawsSecurityGroupIPModify[0m [38;2;255;255;0m[35;48;2;0;0;0m--remove[0m[0m [94m[ --add ][0m [94m[ --register ][0m [38;2;255;255;0m[35;48;2;0;0;0m--group group[0m[0m [94m[ --region region ][0m [38;2;255;255;0m[35;48;2;0;0;0m--port port[0m[0m [38;2;255;255;0m[35;48;2;0;0;0m--description description[0m[0m [38;2;255;255;0m[35;48;2;0;0;0m--ip ip[0m[0m [94m[ --help ][0m

    [31m--remove                   [1;97mFlag. Optional. Remove instead of add - only [38;2;0;255;0;48;2;0;0;0mgroup[0m, and [38;2;0;255;0;48;2;0;0;0mdescription[0m required.[0m
    [94m--add                      [1;97mFlag. Optional. Add to security group (default).[0m
    [94m--register                 [1;97mFlag. Optional. Add it if not already added.[0m
    [31m--group group              [1;97mString. Required. Security Group ID[0m
    [94m--region region            [1;97mString. Optional. AWS region, defaults to [38;2;0;255;0;48;2;0;0;0mAWS_REGION[0m. Must be supplied.[0m
    [31m--port port                [1;97mRequired. for [38;2;0;255;0;48;2;0;0;0m--add[0m only. Integer. service port[0m
    [31m--description description  [1;97mString. Required. Description to identify this record.[0m
    [31m--ip ip                    [1;97mRequired. for [38;2;0;255;0;48;2;0;0;0m--add[0m only. String. IP Address to add or remove.[0m
    [94m--help                     [1;97mFlag. Optional. Display this help.[0m

Usages can be

    awsSecurityGroupIPModify --add --group group [ --region region ] --port port --description description --ip ip
    awsSecurityGroupIPModify --remove --group group [ --region region ] --description description

Modify an EC2 Security Group and add or remove an IP/port combination to the group.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: awsSecurityGroupIPModify --remove [ --add ] [ --register ] --group group [ --region region ] --port port --description description --ip ip [ --help ]

    --remove                   Flag. Optional. Remove instead of add - only group, and description required.
    --add                      Flag. Optional. Add to security group (default).
    --register                 Flag. Optional. Add it if not already added.
    --group group              String. Required. Security Group ID
    --region region            String. Optional. AWS region, defaults to AWS_REGION. Must be supplied.
    --port port                Required. for --add only. Integer. service port
    --description description  String. Required. Description to identify this record.
    --ip ip                    Required. for --add only. String. IP Address to add or remove.
    --help                     Flag. Optional. Display this help.

Usages can be

    awsSecurityGroupIPModify --add --group group [ --region region ] --port port --description description --ip ip
    awsSecurityGroupIPModify --remove --group group [ --region region ] --description description

Modify an EC2 Security Group and add or remove an IP/port combination to the group.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
