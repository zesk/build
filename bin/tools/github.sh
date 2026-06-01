#!/usr/bin/env bash
#
# github.sh
#
# IDENTICAL licenseHeader 11
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

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
