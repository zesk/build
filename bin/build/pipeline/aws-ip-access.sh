#!/usr/bin/env bash
#
# Copyright &copy; 2023, Market Acumen, Inc.
#
errorEnvironment=1
errArgument=1

set -euo pipefail
# set -x # Uncomment to enable debugging

me=$(basename "$0")
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

export usageDelimiter="|"
usageOptions() {
    cat <<EOF
--profile awsProfile|Use this AWS profile when connecting using ~/.aws/credentials
--services service0,service1,...|List of services to add or remove (maps to ports)
--id developerId|Specify an developer id manually (uses DEVELOPER_ID from environment by default)
--ip ip|Specify bn IP manually (uses ipLookup tool from tools.sh by default)
--revoke|Remove permissions
--debug|Enable debugging. Defaults to BUILD_DEBUG environment variable.
--help|Show this help
EOF
}
usageDescription() {
    cat <<EOF
$(consoleReset)Register current IP address in listed security groups to allow for access to deployment sytstems from a specific IP.
Use this during deployment to grant temporary access to your systems during deployemnt only.
Build scripts should have a $(consoleCode --revoke) step afterwards, always.
services are looked up in /etc/services and match /tcp services only for port selection

If no $(consoleCode /etc/services) matches the default values are supported within the script: mysql,postgres,ssh,http,https

    $(consoleNameValue 40 "Required environment variables:" "AWS_REGION")
    $(consoleNameValue 40 "Optional environment variables:" "DEVELOPER_ID AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY")
EOF
}
usage() {
    usageMain "$me" "$@"
    exit $?
}

services=()
optionRevoke=
awsProfile=
debuggingFlag=
currentIP=
developerId=${DEVELOPER_ID:-}
while [ $# -gt 0 ]; do
    case $1 in
    --services)
        shift
        IFS=', ' read -r -a services <<<"$1"
        ;;
    --profile)
        if [ -n "$awsProfile" ]; then
            usage $errArgument "--profile already specified: $awsProfile"
        fi
        shift
        awsProfile=$1
        ;;
    --help)
        usage 0
        ;;
    --debug)
        debuggingFlag=1
        ;;
    --revoke)
        optionRevoke=1
        ;;
    --ip)
        shift
        currentIP="$1"
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

if test "${BUILD_DEBUG-}"; then
    debuggingFlag=1
fi
if test "$debuggingFlag"; then
    consoleWarning "Debugging is enabled"
    set -x
fi

if [ -z "$currentIP" ]; then
    currentIP=$(ipLookup)
    if [ -z "$currentIP" ]; then
        usage $errorEnvironment "Unable to determine IP address"
    fi
fi
currentIP="$currentIP/32"

if [ -z "$developerId" ]; then
    usage $errArgument "Empty --id or DEVELOPER_ID environment"
fi

if [ "${#services[@]}" -eq 0 ]; then
    usage $errArgument "Supply one or more services"
fi
awsProfile=${awsProfile:=default}

./bin/build/install/aws-cli.sh

if needAWSEnvironment; then
    consoleInfo "Need AWS Environment: $awsProfile"
    if awsEnvironment "$awsProfile" >/dev/null; then
        export AWS_ACCESS_KEY_ID
        export AWS_SECRET_ACCESS_KEY
        eval "$(awsEnvironment "$awsProfile")"
    else
        usage $errorEnvironment "No AWS credentials available: $awsProfile"
    fi
fi

usageEnvironment AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_REGION
usageWhich aws

ipRemove() {
    local old_ip group_id port desc start

    group_id=$1
    port=$2
    desc=$3

    start=$(beginTiming)
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
        if ! aws --output json ec2 revoke-security-group-ingress --region "$AWS_REGION" --group-id "$group_id" --protocol tcp --port "$port" --cidr "$old_ip" >/dev/null; then
            consoleError "FAILED $?"
            return $errorEnvironment
        fi
        reportTiming "$start" Success
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
    local group_id port desc temp_error start

    group_id=$1
    port=$2
    desc=$3

    start=$(beginTiming)
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
            consoleYellow -n "duplicate found, skipping "
            reportTiming "$start" Done
            rm $temp_error
            return 0
        else
            consoleError -n "error "
            reportTiming "$start" Done
            prefixLines "$(consoleCode)" <"$temp_error" 1>&2
            rm "$temp_error"
            return 2
        fi
    fi
    reportTiming "$start" Success
    return 0
}

registerMyIP() {
    ipRemove "$@"
    ipAdd "$@"
}

simpleServicePortLookup() {
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
        exit $errorEnvironment
        ;;
    esac
    return 0

}

servicePortLookup() {
    local port
    if [ ! -f /etc/services ]; then
        simpleServicePortLookup "$@"
    else
        port=$(($(grep /tcp /etc/services | grep "^$1\s" | awk '{ print $2 }' | cut -d / -f 1) + 0))
        if [ $port -eq 0 ]; then
            return $errorEnvironment
        fi
        echo $port
    fi
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
