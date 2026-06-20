# shellcheck disable=SC2034
base="APACHE_HOME.sh"
category="Vendor"
default=$'/etc/apache2\n'
derivations=([0]="env" [1]="envMarker" [2]="name")
description=$'Constant for the Apache configuration home directory.\n\n'
descriptionLineCount="2"
env="APACHE_HOME"
envMarker="apache_home"
file="bin/build/env/APACHE_HOME.sh"
fn="APACHE_HOME"
foundNames=([0]="name" [1]="default" [2]="category" [3]="vendor" [4]="type")
name="Apache Home Directory"
original="APACHE_HOME"
rawComment=$'Name: Apache Home Directory\nConstant for the Apache configuration home directory.\nDefault: /etc/apache2\nCategory: Vendor\nVendor: Apache\nType: Directory\n\n'
sourceFile="bin/build/env/APACHE_HOME.sh"
sourceHash="d7f6a17620d6cb5e5ea61746eacfe3f0d59a5018"
sourceLine=""
summary="Constant for the Apache configuration home directory."
summaryComputed="true"
type="Directory"
vendor=$'Apache\n'
