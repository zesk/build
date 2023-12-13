# `aws-ip-access.sh` - Grant access to AWS resources for current IP

Register current IP address in listed security group(s) to allow for access to deployment systems from a specific IP.

## Usage

    aws-ip-access.sh [ --debug ] [ --services service0,service1 ] [ --profile awsProfile ] [ --id developerId ] [ --ip ip ] [ --revoke ] security-group0 security-group1 ...

Use this during deployment to grant temporary access to your systems during deployment only.

Build scripts should have a `--revoke` step afterwards, always.

- `--profile awsProfile`              Use this AWS profile when connecting using `~/.aws/credentials`
- `--services service0,service1,...`  List of services to add or remove (maps to ports)
- `--id developerId`                  Specify an developer id manually (uses DEVELOPER_ID from environment by default)
- `--ip ip`                           Specify an IP manually (uses ipLookup tool from tools.sh by default)
- `--revoke`                          Remove permissions
- `--debug`                           Enable debugging. Defaults to BUILD_DEBUG environment variable.
- `--help`                            Show this help

services are looked up in `/etc/services` and match `/tcp` services only for port selection.

If no `/etc/services` matches the default values are supported within the script: `mysql,postgres,ssh,http,https`

## Local cache

No local caches.

### Environment variables:

- `AWS_REGION` (required) - AWS Region
- `DEVELOPER_ID` (optional) - ID of this developer
- `AWS_ACCESS_KEY_ID` - AWS Access key
- `AWS_SECRET_ACCESS_KEY` - AWS Access key secret

AWS credentials may be extracted from `~/.aws/credentials`

[⬅ Return to top](index.md)