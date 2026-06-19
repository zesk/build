# shellcheck disable=SC2034
base="NOTIFY_URL_AUTHORIZATION.sh"
category="Notify"
derivations=([0]="env" [1]="envMarker" [2]="name")
description=$'Authorization token for default notifications\n\n'
descriptionLineCount="2"
env="NOTIFY_URL_AUTHORIZATION"
envMarker="notify_url_authorization"
file="bin/build/env/NOTIFY_URL_AUTHORIZATION.sh"
fn="NOTIFY_URL_AUTHORIZATION"
foundNames=([0]="name" [1]="category" [2]="type" [3]="see")
name="Notification URL"
rawComment=$'Name: Notification URL\nCategory: Notify\nType: Secret\nAuthorization token for default notifications\nSee: notifyURL\n\n'
see=$'notifyURL\n'
sourceFile="bin/build/env/NOTIFY_URL_AUTHORIZATION.sh"
sourceHash="6933ad72ed2b60225ff1b8959f2da330ae46ea38"
sourceLine=""
summary="Authorization token for default notifications"
summaryComputed="true"
type="Secret"
