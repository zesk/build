#!/usr/bin/env bash
# Date of key expiration which can be checked in pipelines.
# Not part of the Amazon specification but a good idea to track expiration of keys.
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Amazon Web Services
# Vendor: Amazon Web Services
# Type: Date
export AWS_ACCESS_KEY_DATE
AWS_ACCESS_KEY_DATE=${AWS_ACCESS_KEY_DATE-}
