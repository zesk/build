#!/usr/bin/env bash
#
# Generate an environment file
#
# Pass in list of required environment values and export any additional values required
#
# Recommendation that environment generation should NOT include the entire environment and
# instead explicitly define all desired variables used as well as their coverage within
# the application.
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL bashHeader 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

usage() {
    usageDocument "./bin/build/pipeline/make-env.sh" "makeEnvironment" "$@"
}

export APPLICATION_CHECKSUM
export APPLICATION_TAG
export APPLICATION_VERSION
export APPLICATION_BUILD_DATE
export DEPLOYMENT

# fn: {base}
# Usage: {fn} [ deployment ] [ requireEnv1 requireEnv2 requireEnv3 ... ]"
# Argument: deployment - Required. String. `production` or `staging` or `docker`
# Argument: requireEnv1 - Optional. One or more environment variables which should be non-blank and included in the `.env` file.
# Create environment file `.env` for build.
#
makeEnvironment() {
    local start missing e

    #
    # e.g.
    #
    # Email: SMTP_URL MAIL_SUPPORT MAIL_FROM TESTING_EMAIL TESTING_EMAIL_IMAP
    # Database: DSN
    # Amazon: AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
    #
    # Must be defined and non-empty to run this script
    local requireEnvironment=(
        APPLICATION_CHECKSUM APPLICATION_TAG
        APPLICATION_VERSION APPLICATION_BUILD_DATE
        DEPLOYMENT
    )
    # Will be exported to the environment file, only if defined
    local buildEnvironment=(
        BUILD_TIMESTAMP
        "${requireEnvironment[@]}"
    )

    export BUILD_TIMESTAMP=$(($(date +%s) + 0))

    local envFile=./.env

    DEPLOYMENT=${DEPLOYMENT:-}
    while [ $# -gt 0 ]; do
        case $1 in
        docker | develop | production)
            if [ -n "$DEPLOYMENT" ]; then
                consoleWarning "DEPLOYMENT defined as $DEPLOYMENT, overwritten as $1"
            fi
            DEPLOYMENT=$1
            ;;
        *)
            requireEnvironment+=("$1")
            buildEnvironment+=("$1")
            ;;
        esac
        shift
    done

    if ! git config --global --get safe.directory | grep -q "$(pwd)"; then
        git config --global --add safe.directory "$(pwd)"
    fi

    # Computed
    APPLICATION_VERSION=$(runHook version-current)
    APPLICATION_BUILD_DATE=$(date -u +"%Y-%m-%d %H:%M:%S")
    APPLICATION_CHECKSUM=$(runHook application-checksum)
    APPLICATION_TAG=$(runHook application-tag)

    missing=()
    for e in "${requireEnvironment[@]}"; do
        if [ -z "${!e:-}" ]; then
            echo "$(consoleLabel "$(alignRight 30 "$e")"):" "$(consoleError "** No value **")"
            missing+=("$e")
        else
            echo "$(consoleLabel "$(alignRight 30 "$e")"):" "$(consoleValue "${!e}")"
        fi
    done
    if [ ${#missing[@]} -gt 0 ]; then
        usage "$errorEnvironment" "Missing environment variables: ${missing[*]}"
    fi

    #==========================================================================================
    #
    # Generate the .env artifact
    #
    start=$(beginTiming)
    consoleInfo -n "Build #$APPLICATION_VERSION on $APPLICATION_BUILD_DATE ... "
    if buildDebugEnabled; then
        consoleMagenta -n "(checksum \"$APPLICATION_CHECKSUM\", tag \"$APPLICATION_TAG\", timestamp $BUILD_TIMESTAMP)"
    fi
    [ -f "$envFile" ] && rm -f "$envFile"
    echo -n >"$envFile"
    for e in "${buildEnvironment[@]}"; do
        if [ -n "${!e}" ]; then
            echo "$e=\"${!e//\"/\\\"}\"" >>"$envFile"
        fi
    done
    reportTiming "$start" OK
    # artifact: .env
}

makeEnvironment "$@"
