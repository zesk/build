#!/usr/bin/env bash
# Testing any environment variable in the build must be in the bin/env directory as well
# Copyright &copy; 2024 Market Acumen, Inc.
export APP_THING
APP_THING="${APP_THING-}"
