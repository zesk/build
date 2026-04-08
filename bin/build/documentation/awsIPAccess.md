## `awsIPAccess`

> Grant access to AWS security group for this IP only using Amazon IAM credentials

### Usage

    awsIPAccess [ --profile profileName ] --services service0,service1,... [ --id developerId ] --group securityGroup [ --ip ip ] [ --revoke ] [ --help ]

Register current IP address in listed security groups to allow for access to deployment systems from a specific IP.
Use this during deployment to grant temporary access to your systems during deployment only.
Build scripts should have a `awsIPAccess --revoke` step afterward, always.
services are looked up in /etc/services and match /tcp services only for port selection
If no `/etc/services` matches the default values are supported within the script: `mysql`,`postgres`,`ssh`,`http`,`https`
You can also simply supply a list of port numbers, and mix and match: `--services ssh,http,3306,12345` is valid

### Arguments

- `--profile profileName` - String. Optional. Use this AWS profile when connecting using ~/.aws/credentials
--services service0,service1,- `...` - List. Required. List of services to add or remove (service names or port numbers)
- `--id developerId` - String. Optional. Specify an developer id manually (uses DEVELOPER_ID from environment by default)
- `--group securityGroup` - String.  String. Required. Specify one or more security groups to modify. Format: `sg-` followed by hexadecimal characters.
- `--ip ip` - IP. Optional. Specify bn IP manually (uses networkIPLookup tool from tools.sh by default)
- `--revoke` - Flag. Optional. Remove permissions
- `--help` - Flag. Optional. Show this help

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:AWS_REGION.sh}
- DEVELOPER_ID
- {SEE:AWS_ACCESS_KEY_ID.sh}
- {SEE:AWS_SECRET_ACCESS_KEY.sh}

