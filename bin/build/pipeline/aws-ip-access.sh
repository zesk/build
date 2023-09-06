#!/usr/bin/env bash
#
# Copyright &copy; 2023, Market Acumen, Inc.
#
errEnv=1
errArgument=1

set -euo pipefail
# set -x # Uncomment to enable debugging

me=$(basename "$0")
relTop=../../..
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
    echo "$me: Can not cd to $relTop" 1>&2
    exit $errEnv
fi

# shellcheck source=/dev/null
. ./bin/build/tools.sh

usage() {
    local rs
    rs=$1
    shift
    exec 1>&2
    if [ -n "$*" ]; then
        consoleError "$@"
        echo
    fi
    {
        echo "$me [ --services service0,service1 ] [ --id developerId ] [ --ip ip ] [ --revoke ] security-group0 security-group1 ... "
        echo
        echo "Register current IP address in listed security group(s) to allow for access to deployment sytstems from a specific IP."
        echo "Use this during deployment to grant temporary access to your systems during deployemnt only."
        echo "Build scripts should have a --revoke step afterwards, always."
        echo
        echo "--services service0,service1,...  List of services to add or remove (maps to ports)"
        echo "--id developerId                  Specify an developer id manually (uses DEVELOPER_ID from environment by default)"
        echo "--ip ip                           Specify an IP manually (uses ipLookup tool from tools.sh by default)"
        echo "--revoke                          Remove permissions"
        echo "--help                            Show this help"
        echo
        echo "services are looked up in /etc/services and match /tcp services only for port selection"
        echo
        echo "If no /etc/services matches the default values are supported within the script: mysql,postgres,ssh,http,https"
    } | prefixLines "$(consoleInfo)"
    echo
    consoleLabel "Required environment variables:"
    consoleValue "    AWS_REGION"
    echo
    consoleLabel "Optional environment variables:"
    consoleValue "    DEVELOPER_ID AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY"
    echo
    if awsCredentialsFile 2>/dev/null; then
        echo "$(consoleInfo -n "AWS credentials are extracted from") $(consoleValue -n "$(awsCredentialsFile)")"
    else
        consoleInfo "AWS credentials can be extracted from \$HOME/.aws/credentials when configured)"
    fi
    exit "$rs"
}

services=()
optionRevoke=
currentIP=
developerId=${DEVELOPER_ID:=}
while [ $# -gt 0 ]; do
    case $1 in
    --services)
        shift
        IFS=', ' read -r -a services <<<"$1"
        ;;
    --help)
        usage 0
        ;;
    --revoke)
        optionRevoke=1
        ;;
    --ip)
        shift
        currentIP="$1/32"
        ;;
    --id)
        shift
        developerId=$1
        ;;
    *)
        break
        ;;
    esac
    shift
done

if [ -z "$currentIP" ]; then
    currentIP=$(ipLookup)
    if [ -z "$currentIP" ]; then
        usage $errEnv "Unable to determine IP address"
    fi
fi
currentIP="$currentIP/32"

if [ -z "$developerId" ]; then
    usage $errArgument "Empty --id or DEVELOPER_ID environment"
fi

if [ "${#services[@]}" -eq 0 ]; then
    usage $errArgument "Supply one or more services"
fi

./bin/build/install/aws-cli.sh

if [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
    awsEnvironment
fi
usageEnvironment AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_REGION
usageWhich aws

ipRemove() {
    local old_ip group_id port desc

    group_id=$1
    port=$2
    desc=$3

    set +o pipefail
    old_ip=$(aws ec2 describe-security-groups --region "$AWS_REGION" --group-id "$group_id" --output text --query "SecurityGroups[*].IpPermissions[*]" | grep "$desc" | head -1 | awk '{print $2}')
    set -o pipefail
    if [ -n "$old_ip" ]; then
        consoleInfo -n "Removing old IP: "
        consoleRed -n "$old_ip "
        consoleLabel -n "from group-id: "
        consoleValue -n "$group_id "
        consoleLabel -n "port: "
        consoleValue -n "$port "
        aws --output json ec2 revoke-security-group-ingress --region "$AWS_REGION" --group-id "$group_id" --protocol tcp --port "$port" --cidr "$old_ip" >/dev/null
    fi
}

##
## ipAdd
## group - Security Group ID
## region - AWS region
## port - service port
## email - developer email
## service tag - http|postgres|ssh|custom
##
ipAdd() {
    local group_id port desc temp_error

    group_id=$1
    port=$2
    desc=$3

    consoleInfo -n "Adding new IP: "
    consoleGreen -n "$currentIP "
    consoleLabel -n "to group-id: "
    consoleValue -n "$group_id "
    consoleLabel -n "port: "
    consoleValue -n "$port "
    consoleInfo -n "... "

    temp_error=/tmp/$$.ipAdd.err
    if ! aws --output json ec2 authorize-security-group-ingress --region "$AWS_REGION" --group-id "$group_id" --ip-permissions "[{\"IpProtocol\": \"tcp\", \"FromPort\": $port, \"ToPort\": $port, \"IpRanges\": [{\"CidrIp\": \"$currentIP\", \"Description\": \"$desc\"}]}]" >/dev/null 2>$temp_error; then
        if grep -q "Duplicate" $temp_error; then
            consoleYellow "duplicate found, skipping"
            rm $temp_error
            return 0
        else
            consoleError "error"
            prefixLines "$(consoleCode)" <"$temp_error" 1>&2
            rm "$temp_error"
            return 2
        fi
    fi
    consoleSuccess success
    return 0
}
registerMyIP() {
    ipRemove "$@"
    ipAdd "$@"
}
servicePortLookup() {
    local port
    if [ ! -f /etc/services ]; then
        case $1 in
        ssh)
            echo 22
            ;;
        http)
            echo 80
            ;;
        https)
            echo 443
            ;;
        mysql)
            echo 3306
            ;;
        postgres)
            echo 5432
            ;;
        *)
            exit $errEnv
            ;;
        esac
    fi
    port=$(($(grep /tcp /etc/services | grep "^$1\s" | awk '{ print $2 }' | cut -d / -f 1) + 0))
    if [ $port -eq 0 ]; then
        return $errEnv
    fi
    echo $port
}

bigText "$(test $optionRevoke && echo "Closing ..." || echo "Opening ..")" | prefixLines "$(consoleBlue)"

echo "$(consoleLabel -n "                ID"): $(consoleValue -n "$developerId")"
echo "$(consoleLabel -n "                IP"): $(consoleValue -n "$currentIP")"
echo "$(consoleLabel -n "            Region"): $(consoleValue -n "$AWS_REGION")"
echo "$(consoleLabel -n " AWS_ACCESS_KEY_ID"): $(consoleValue -n "$AWS_ACCESS_KEY_ID")"

for s in "${services[@]}"; do
    if ! servicePortLookup "$s" >/dev/null; then
        usage "$errArgument" "Invalid service $s provided"
    fi
done
for sg_id in "$@"; do
    if test $optionRevoke; then
        for s in "${services[@]}"; do
            port=$(servicePortLookup "$s")
            ipRemove "$sg_id" "$port" "$developerId-$s"
        done
    else
        for s in "${services[@]}"; do
            port=$(servicePortLookup "$s")
            registerMyIP "$sg_id" "$port" "$developerId-$s"
        done
    fi
done
