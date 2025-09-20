#!/usr/bin/env bash
#
# Amazon Web Services: aws
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Requires: aws env
__awsWrapper() {
  local command=(aws --no-paginate) configFile=".aws/config"

  # AWS_SHARED_CREDENTIALS_FILE
  # AWS_CONFIG_FILE
  [ -f "$configFile" ] || configFile=""
  # env -u unsets a variable name
  [ -n "${AWS_PROFILE-}" ] || command=(env -u AWS_PROFILE "${command[@]}")
  AWS_CONFIG_FILE="$configFile" AWS_PROFILE="${AWS_PROFILE-}" AWS_PAGER="" "${command[@]}" "$@"
}
