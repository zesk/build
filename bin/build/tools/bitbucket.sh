#!/usr/bin/env bash
#
# Tools specifically for BitBucket pipelines
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: -
# bin: grep awk
#

#
# getFromPipelineYML name defaultValue
#
# Example:
#
# MARIADB_ROOT_PASSWORD=${MARIADB_ROOT_PASSWORD:-$(getFromPipelineYML MARIADB_ROOT_PASSWORD not-in-bitbucket-pipelines.yml)}
#
# Assumes current working directory is project root.
#
getFromPipelineYML() {
    local value

    value=$(grep "$1" bitbucket-pipelines.yml | awk '{ print $2 }')
    value=${value:-$2}

    echo -n "$value"
}
