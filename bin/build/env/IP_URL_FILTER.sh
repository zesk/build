#!/usr/bin/env bash
# jq filter to parse IP_URL result (assuming JSON)
# if blank, no filter is used and raw result is returned
# See: ipLookup
# Type: String
# Copyright &copy; 2024 Market Acumen, Inc.
# Category: pipeline
export IP_URL_FILTER
IP_URL_FILTER="${IP_URL_FILTER-}"