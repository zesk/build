# shellcheck disable=SC2034
base="APPLICATION_BUILD_DATE.sh"
category="Deployment"
derivations=([0]="env" [1]="envMarker" [2]="name")
description=$'Time when a build was initiated, set upon first invocation if not already.\n\n'
descriptionLineCount="2"
env="APPLICATION_BUILD_DATE"
envMarker="application_build_date"
file="bin/build/env/APPLICATION_BUILD_DATE.sh"
fn="APPLICATION_BUILD_DATE"
foundNames=([0]="name" [1]="category" [2]="type")
name="Application Build Date"
original="APPLICATION_BUILD_DATE"
rawComment=$'Name: Application Build Date\nTime when a build was initiated, set upon first invocation if not already.\nCategory: Deployment\nType: String\n\n'
sourceFile="bin/build/env/APPLICATION_BUILD_DATE.sh"
sourceHash="9586f9badc5a659db7d288f7b862a806c93fc4fd"
sourceLine=""
summary="Time when a build was initiated, set upon first invocation"
summaryComputed="true"
type="String"
