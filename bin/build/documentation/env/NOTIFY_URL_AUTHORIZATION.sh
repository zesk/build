# shellcheck disable=SC2034
base="NOTIFY_URL_AUTHORIZATION.sh"
category="Notify"
derivations=([0]="env" [1]="envMarker" [2]="name")
description=$'Authorization token for default notifications.\nPassed as a string to Notify URLs via a header:\n\n'
descriptionLineCount="3"
env="NOTIFY_URL_AUTHORIZATION"
envMarker="notify_url_authorization"
file="bin/build/env/NOTIFY_URL_AUTHORIZATION.sh"
fn="NOTIFY_URL_AUTHORIZATION"
foundNames=([0]="name" [1]="category" [2]="type" [3]="____authorization" [4]="see")
name="Notification URL Authorization Token"
original="NOTIFY_URL_AUTHORIZATION"
rawComment=$'Name: Notification URL Authorization Token\nCategory: Notify\nType: Secret\nAuthorization token for default notifications.\nPassed as a string to Notify URLs via a header:\n    Authorization: Bearer $NOTIFY_URL_AUTHORIZATION\nSee: notifyURL\n\n'
see=$'notifyURL\n'
sourceFile="bin/build/env/NOTIFY_URL_AUTHORIZATION.sh"
sourceHash="23891db3c3c5ba391efbcd6fa26d811ef95157f0"
sourceLine=""
summary="Authorization token for default notifications."
summaryComputed="true"
type="Secret"
