#!/usr/bin/env bash
# Name: Filter for IP Lookup
# jq filter to parse IP_URL result (assuming JSON)
# if blank, no filter is used and raw result is returned
# See: networkIPLookup
# Copyright &copy; 2026 Market Acumen, Inc.
# Category: Build Configuration
# Type: String
export IP_URL_FILTER
IP_URL_FILTER="${IP_URL_FILTER-}"
