#!/usr/bin/env bash
# Constant for the directory where services are monitored by daemontools
# Copyright &copy; 2024 Market Acumen, Inc.

# IDENTICAL DAEMONTOOLS_HOME 2
export DAEMONTOOLS_HOME
DAEMONTOOLS_HOME=${DAEMONTOOLS_HOME-/etc/service}
