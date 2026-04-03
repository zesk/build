## `awsSecurityGroupIPModify`

> Modify an EC2 Security Group

### Usage

    awsSecurityGroupIPModify --remove [ --add ] [ --register ] --group group [ --region region ] --port port --description description --ip ip [ --help ]

Usages can be
    awsSecurityGroupIPModify --add --group group [ --region region ] --port port --description description --ip ip
    awsSecurityGroupIPModify --remove --group group [ --region region ] --description description
Modify an EC2 Security Group and add or remove an IP/port combination to the group.

### Arguments

- `--remove - Flag. Optional. Remove instead of add` - only `group`, and `description` required.
- `--add` - Flag. Optional. Add to security group (default).
- `--register` - Flag. Optional. Add it if not already added.
- `--group group` - String. Required. Security Group ID
- `--region region` - String. Optional. AWS region, defaults to `AWS_REGION`. Must be supplied.
- `--port port` - Required. for `--add` only. Integer. service port
- `--description description` - String. Required. Description to identify this record.
- `--ip ip` - Required. for `--add` only. String. IP Address to add or remove.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

