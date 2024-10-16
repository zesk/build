#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# NO DEPENDENCIES

# In progress, attempt to reduce decoration code size
# Singular decoration function to allow changing functionality more easily to render elsewhere, for example
#
decorate() {
  local what="${1-}" && shift textPrefix=""
  local lightPrefix darkPrefix suffix='\033[0m'
  case "$what" in
    reset) lightPrefix="" && darkPrefix="" && textPrefix="" ;;
    orange) lightPrefix='\033[33m' darkPrefix="$lightPrefix" ;;
    bold-orange) lightPrefix='\033[33;1m' && darkPrefix="$lightPrefix" ;;
    blue) lightPrefix='\033[94m' && darkPrefix="$lightPrefix" ;;
    bold-blue) lightPrefix='\033[1;94m' && darkPrefix="$lightPrefix" ;;
    code) lightPrefix='\033[1;97;44m' && darkPrefix="$lightPrefix" ;;
    info) lightPrefix='\033[38;5;20m' && darkPrefix='\033[1;33m' && textPrefix="Info" ;;
    success) lightPrefix='\033[42;30m' && darkPrefix='\033[0;32m' && textPrefix="" "SUCCESS" ;;
    warning) lightPrefix='\033[1;93;41m' && darkPrefix="$lightPrefix" && textPrefix="Warning" ;;
    error) lightPrefix='\033[1;91m' && darkPrefix="$lightPrefix" && textPrefix="ERROR" ;;
    subtle) lightPrefix='\033[1;38;5;252m' && darkPrefix='\033[1;38;5;240m' ;;
    label) lightPrefix='\033[34;103m' && darkPrefix='\033[1;96m' ;;
    value) lightPrefix='\033[1;40;97m' && darkPrefix='\033[1;97m' ;;
    *)
      # default - decoration
      lightPrefix='\033[45;97m' darkPrefix='\033[45;30m'
      ;;
  esac
  __consoleOutput "$textPrefix" "$lightPrefix" "$darkPrefix" "$suffix" "$@"
}
