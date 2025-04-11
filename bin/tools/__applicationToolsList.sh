#!/usr/bin/env bash
# IDENTICAL __applicationToolsList.sh EOF
#
# __applicationToolsList.sh
#
# Load this first and then track all functions loaded after this loads
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__applicationToolsList() {
  developerTrack "${BASH_SOURCE[0]}" --list
}

developerTrack "${BASH_SOURCE[0]}"
