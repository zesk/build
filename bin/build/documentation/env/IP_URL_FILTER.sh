# shellcheck disable=SC2034
base="IP_URL_FILTER.sh"
category="Build Configuration"
derivations=([0]="env" [1]="envMarker")
description=$'jq filter to parse IP_URL result (assuming JSON)\nif blank, no filter is used and raw result is returned\n\n'
descriptionLineCount="3"
env="IP_URL_FILTER"
envMarker="ip_url_filter"
file="bin/build/env/IP_URL_FILTER.sh"
fn="IP_URL_FILTER"
foundNames=([0]="see" [1]="category" [2]="type")
rawComment=$'jq filter to parse IP_URL result (assuming JSON)\nif blank, no filter is used and raw result is returned\nSee: networkIPLookup\nCategory: Build Configuration\nType: String\n\n'
see=$'networkIPLookup\n'
sourceFile="bin/build/env/IP_URL_FILTER.sh"
sourceHash="0c7aeb2eb7f2a99397e2631e70ee2c8439266578"
sourceLine=""
summary="jq filter to parse IP_URL result (assuming JSON)"
summaryComputed="true"
type="String"
