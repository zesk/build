# shellcheck disable=SC2034
base="BUILD_DOCKER_PATH.sh"
category="Docker"
derivations=([0]="env" [1]="envMarker" [2]="name")
description=$'Default path for the shell to map the current directory to when launching `dockerLocalContainer`\n\n'
descriptionLineCount="2"
env="BUILD_DOCKER_PATH"
envMarker="build_docker_path"
file="bin/build/env/BUILD_DOCKER_PATH.sh"
fn="BUILD_DOCKER_PATH"
foundNames=([0]="name" [1]="see" [2]="category" [3]="type")
name="Docker Mapped Path"
original="BUILD_DOCKER_PATH"
rawComment=$'Name: Docker Mapped Path\nDefault path for the shell to map the current directory to when launching `dockerLocalContainer`\nSee: dockerLocalContainer\nCategory: Docker\nType: RemoteDirectory\n\n'
see=$'dockerLocalContainer\n'
sourceFile="bin/build/env/BUILD_DOCKER_PATH.sh"
sourceHash="d7b83960ffac799d245527adea86fef93d84e6b3"
sourceLine=""
summary="Default path for the shell to map the current directory"
summaryComputed="true"
type="RemoteDirectory"
