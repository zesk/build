#!/usr/bin/env bash
#
# github.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.

#
# read urls one per line and output to a CSV
#
# Sleep 1 second between requests. No rush.
#
githubURLsToCSV() {
  local url

  while read -r url; do
    local repo

    if ! repo=$(githubURLParse "$url"); then
      printf -- "\"%s\",\"%s\",\"%s\"\n" "-" "$url" "" || return $?
    else
      local date hasReleases=true
      date=$(githubPublishDate "$repo") || return $?
      if [ "$date" = "null" ]; then
        hasReleases=false
        date=$(githubLatest "$repo" | jq -r .pushed_at) || return $?
      fi
      printf -- "\"%s\",\"%s\",\"%s\"\n" "$date" "$url" "$hasReleases" || return $?
      sleep 1
    fi
  done
}
