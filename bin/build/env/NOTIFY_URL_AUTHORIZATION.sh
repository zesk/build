#!/usr/bin/env bash
# Name: Notification URL Authorization Token
# Copyright &copy; 2026 Market Acumen, Inc.
# Category: Notify
# Type: Secret
# Authorization token for default notifications.
# Passed as a string to Notify URLs via a header:
#
#     Authorization: Bearer $NOTIFY_URL_AUTHORIZATION
#
# See: notifyURL
NOTIFY_URL_AUTHORIZATION=${NOTIFY_URL_AUTHORIZATION-}
