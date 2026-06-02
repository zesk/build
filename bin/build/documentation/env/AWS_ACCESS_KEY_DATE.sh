# shellcheck disable=SC2034
base="AWS_ACCESS_KEY_DATE.sh"
category="Amazon Web Services"
derivations=([0]="env" [1]="envMarker" [2]="name")
description=$'Date of key expiration which can be checked in pipelines.\nNot part of the Amazon specification but a good idea to track expiration of keys.\n\n'
descriptionLineCount="3"
env="AWS_ACCESS_KEY_DATE"
envMarker="aws_access_key_date"
file="bin/build/env/AWS_ACCESS_KEY_DATE.sh"
fn="AWS_ACCESS_KEY_DATE"
foundNames=([0]="name" [1]="category" [2]="vendor" [3]="type")
name="AWS Access Key Issue Date"
rawComment=$'Name: AWS Access Key Issue Date\nDate of key expiration which can be checked in pipelines.\nNot part of the Amazon specification but a good idea to track expiration of keys.\nCategory: Amazon Web Services\nVendor: Amazon Web Services\nType: Date\n\n'
sourceFile="bin/build/env/AWS_ACCESS_KEY_DATE.sh"
sourceHash="762ec7bb77993b8f9e7336b7893f0775d96c46b3"
sourceLine=""
summary="Date of key expiration which can be checked in pipelines."
summaryComputed="true"
type="Date"
vendor=$'Amazon Web Services\n'
