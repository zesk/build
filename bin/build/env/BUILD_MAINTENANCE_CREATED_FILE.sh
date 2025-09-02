#!/usr/bin/env bash
# Copyright &copy; 2025 Market Acumen, Inc.
# Category: Application
# When true, means the `.env.local` file was created by the maintenance hook and should be deleted when maintenance is
# no longer enabled.
# Type: Boolean
export BUILD_MAINTENANCE_CREATED_FILE
BUILD_MAINTENANCE_CREATED_FILE="${BUILD_MAINTENANCE_CREATED_FILE-}"
